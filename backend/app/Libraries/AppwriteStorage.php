<?php

namespace App\Libraries;

class AppwriteStorage
{
    /**
     * Check if Appwrite storage is configured.
     */
    public static function isConfigured(): bool
    {
        return !empty(env('appwrite.projectId')) && !empty(env('appwrite.bucketId'));
    }

    /**
     * Upload a file to Appwrite Storage.
     * Returns the full view URL of the uploaded file.
     */
    public static function uploadFile($file): string
    {
        $endpoint = env('appwrite.endpoint', 'https://cloud.appwrite.io/v1');
        $projectId = env('appwrite.projectId');
        $apiKey = env('appwrite.apiKey');
        $bucketId = env('appwrite.bucketId');

        $url = rtrim($endpoint, '/') . "/storage/buckets/{$bucketId}/files";

        // Build the multipart post data using CURLFile (PHP 8.1+)
        $cfile = new \CURLFile($file->getTempName(), $file->getClientMimeType(), $file->getClientName());

        $postData = [
            'fileId' => 'unique()',
            'file'   => $cfile,
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            "X-Appwrite-Project: {$projectId}",
            "X-Appwrite-Key: {$apiKey}",
        ]);

        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpCode >= 200 && $httpCode < 300) {
            $data = json_decode($response, true);
            if (isset($data['$id'])) {
                // Return the complete view URL of the file
                return rtrim($endpoint, '/') . "/storage/buckets/{$bucketId}/files/{$data['$id']}/view?project={$projectId}";
            }
        }

        $errorMsg = "Appwrite upload failed (HTTP {$httpCode}): " . ($response ?: 'cURL request failed');
        log_message('error', $errorMsg);
        throw new \RuntimeException($errorMsg);
    }

    /**
     * Delete a file from Appwrite Storage by extracting the file ID from the URL.
     */
    public static function deleteFile(string $fileUrl): bool
    {
        $endpoint = env('appwrite.endpoint', 'https://cloud.appwrite.io/v1');
        $projectId = env('appwrite.projectId');
        $apiKey = env('appwrite.apiKey');
        $bucketId = env('appwrite.bucketId');

        // Extract the file ID from URL: .../files/{fileId}/view...
        if (preg_match('/\/files\/([^\/]+)/', $fileUrl, $matches)) {
            $fileId = $matches[1];
            $url = rtrim($endpoint, '/') . "/storage/buckets/{$bucketId}/files/{$fileId}";

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, [
                "X-Appwrite-Project: {$projectId}",
                "X-Appwrite-Key: {$apiKey}",
            ]);

            curl_exec($ch);
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            curl_close($ch);

            return ($httpCode >= 200 && $httpCode < 300);
        }

        return false;
    }

    /**
     * Return the view URL for an Appwrite File ID (or return it directly if it's already a URL).
     */
    public static function getFileViewUrl(string $fileIdOrUrl): string
    {
        if (str_starts_with($fileIdOrUrl, 'http://') || str_starts_with($fileIdOrUrl, 'https://')) {
            return $fileIdOrUrl;
        }

        $endpoint = env('appwrite.endpoint', 'https://cloud.appwrite.io/v1');
        $projectId = env('appwrite.projectId');
        $bucketId = env('appwrite.bucketId');

        return rtrim($endpoint, '/') . "/storage/buckets/{$bucketId}/files/{$fileIdOrUrl}/view?project={$projectId}";
    }
}
