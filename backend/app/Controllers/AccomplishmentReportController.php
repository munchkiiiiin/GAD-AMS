<?php

namespace App\Controllers;

use App\Models\AccomplishmentReportModel;

class AccomplishmentReportController extends BaseController
{
    public function submitReport()
    {
        $accomplishmentReportModel = new AccomplishmentReportModel();

        $rules = [
            "activity-title"      => "required",
            "control-number"      => "required",
            "start-date"          => "required",
            "end-date"            => "required",
            "start-time"          => "required",
            "end-time"            => "required",
            "venue"               => "required",
            "attendees"           => "required|integer",
            "male"                => "required|integer",
            "female"              => "required|integer",
            "rating"              => "required|integer",
            "user_id"             => "required",
            "attachment"         => "uploaded[attachment]|max_size[attachment,10240]|ext_in[attachment,pdf]",
        ];

        if (!$this->validate($rules)) { 
            return $this->response->setJSON([
                "success" => false,
                "errors"  => $this->validator->getErrors()
            ])->setStatusCode(422);
        }

        try {
            $file = $this->request->getFile('attachment');
            $attachmentValue = '';

            if ($file && $file->isValid() && !$file->hasMoved()) {
                if (\App\Libraries\AppwriteStorage::isConfigured()) {
                    $attachmentValue = \App\Libraries\AppwriteStorage::uploadFile($file);
                } else {
                    $fileName = $file->getRandomName();
                    $uploadPath = rtrim((string) env('app.uploadPath', FCPATH . 'uploads'), DIRECTORY_SEPARATOR);
                    if (!is_dir($uploadPath)) {
                        mkdir($uploadPath, 0777, true);
                    }
                    $file->move($uploadPath, $fileName);
                    $attachmentValue = $fileName;
                }
            }

            $data = [
                "activity_title"      => $this->request->getPost("activity-title"),
                "control_number"      => $this->request->getPost("control-number"),
                "start_date"          => $this->request->getPost("start-date"),
                "end_date"            => $this->request->getPost("end-date"),
                "start_time"          => $this->request->getPost("start-time"),
                "end_time"            => $this->request->getPost("end-time"),
                "venue"               => $this->request->getPost("venue"),
                "attendees"           => $this->request->getPost("attendees"),
                "male"                => $this->request->getPost("male"),
                "female"              => $this->request->getPost("female"),
                "rating"              => $this->request->getPost("rating"),
                "user_id"             => $this->request->getPost("user_id"),
                "attachment"          => $attachmentValue,
                "status"              => "Pending",
            ];

            if (empty($data['user_id'])) {
                throw new \Exception("User ID is missing. Please log in again.");
            }

            if ($accomplishmentReportModel->insert($data)) {
                return $this->response->setJSON([
                    "success" => true,
                    "message" => "Data saved successfully"
                ]);
            }

            return $this->response->setJSON([
                "success" => false,
                "message" => "Failed to save data into database.",
                "errors"  => $accomplishmentReportModel->errors()
            ])->setStatusCode(500);

        } catch (\Exception $e) {
            return $this->response->setJSON([
                "success" => false,
                "message" => "Server Error: " . $e->getMessage()
            ])->setStatusCode(500);
        }
    }

    public function index()
    {
        $accomplishmentReportModel = new AccomplishmentReportModel();
        
        $reports = $accomplishmentReportModel
            ->select('accomplishment_report.*, control_number.control_number as control, accomplishment_report.activity_title as title, DATE_FORMAT(accomplishment_report.created_at, "%Y-%m-%d") as date, users.username as office, activity_design.form_type as formLabel')
            ->join('users', 'users.id = accomplishment_report.user_id', 'left')
            ->join('control_number', 'control_number.control_number = accomplishment_report.control_number', 'left')
            ->join('activity_design', 'activity_design.act_design_id = control_number.act_design_id', 'left')
            ->orderBy('accomplishment_report.id', 'DESC')
            ->findAll();

        return $this->response->setJSON([
            'success' => true,
            'data'    => $reports
        ]);
    }

    public function show($id = null)
    {
        if (!$id) {
            return $this->response->setJSON(['success' => false, 'message' => 'Report ID required'])->setStatusCode(400);
        }

        $accomplishmentReportModel = new AccomplishmentReportModel();
        $report = $accomplishmentReportModel
            ->select('accomplishment_report.*, control_number.control_number as control, DATE_FORMAT(accomplishment_report.created_at, "%Y-%m-%d") as date, users.username as office, activity_design.form_type as formLabel')
            ->join('users', 'users.id = accomplishment_report.user_id', 'left')
            ->join('control_number', 'control_number.control_number = accomplishment_report.control_number', 'left')
            ->join('activity_design', 'activity_design.act_design_id = control_number.act_design_id', 'left')
            ->where('accomplishment_report.id', $id)
            ->first();

        if (!$report) {
            $db = \Config\Database::connect();
            $report = $db->table('archived_accomplishment_reports as aar')
                ->select('aar.*, aar.original_report_id as id, aar.activity_title as title, DATE_FORMAT(aar.created_at, "%Y-%m-%d") as date, users.username as office, aar.control_number as control')
                ->join('users', 'users.id = aar.user_id', 'left')
                ->where('aar.original_report_id', $id)
                ->get()->getRowArray();

            if (!$report) {
                return $this->response->setJSON(['success' => false, 'message' => 'Report not found'])->setStatusCode(404);
            }
        }

        return $this->response->setJSON(['success' => true, 'data' => $report]);
    }

    public function getUserReports($userId = null)
    {
        if (!$userId) {
            return $this->response->setJSON(['success' => false, 'message' => 'User ID required'])->setStatusCode(400);
        }

        $accomplishmentReportModel = new AccomplishmentReportModel();
        $reports = $accomplishmentReportModel
                                       ->select('accomplishment_report.*, control_number.control_number as control, accomplishment_report.activity_title as title, DATE_FORMAT(accomplishment_report.created_at, "%Y-%m-%d") as date, users.username as office, activity_design.form_type as formLabel')
                                       ->join('users', 'users.id = accomplishment_report.user_id', 'left')
                                       ->join('control_number', 'control_number.control_number = accomplishment_report.control_number', 'left')
                                       ->join('activity_design', 'activity_design.act_design_id = control_number.act_design_id', 'left')
                                       ->where('accomplishment_report.user_id', $userId)
                                       ->orderBy('accomplishment_report.id', 'DESC')
                                       ->findAll();

        return $this->response->setJSON([
            'success' => true,
            'data'    => $reports
        ]);
    }

    public function getArchivedReports()
    {
        $accomplishmentReportModel = new AccomplishmentReportModel();

        $reports = $accomplishmentReportModel
            ->select('accomplishment_report.*, control_number.control_number as control, accomplishment_report.activity_title as title, DATE_FORMAT(accomplishment_report.created_at, "%Y-%m-%d") as date, users.username as office, activity_design.form_type as formLabel')
            ->join('users', 'users.id = accomplishment_report.user_id', 'left')
            ->join('control_number', 'control_number.control_number = accomplishment_report.control_number', 'left')
            ->join('activity_design', 'activity_design.act_design_id = control_number.act_design_id', 'left')
            ->whereIn('accomplishment_report.status', ['Verified', 'Cancelled'])
            ->orderBy('accomplishment_report.id', 'DESC')
            ->findAll();

        return $this->response->setJSON([
            'success' => true,
            'data'    => $reports
        ]);
    }

    /**
     * Retrieve accomplishment report attachment (serves file locally or redirects to Appwrite file preview URL)
     */
    public function getAttachment($id = null)
    {
        if (!$id) {
            return $this->response->setStatusCode(400)->setJSON(['success' => false, 'message' => 'Report ID required']);
        }

        $accomplishmentReportModel = new AccomplishmentReportModel();
        $report = $accomplishmentReportModel->find($id);

        if (!$report) {
            // Check archive fallback
            $db = \Config\Database::connect();
            $report = $db->table('archived_accomplishment_reports')
                ->where('original_report_id', $id)
                ->get()->getRowArray();
        }

        if (!$report || empty($report['attachment'])) {
            return $this->response->setStatusCode(404)->setBody('Attachment not found');
        }

        $attachment = $report['attachment'];

        // If it looks like a binary PDF file (for backward compatibility if old binary data remains in DB)
        if (str_starts_with($attachment, '%PDF')) {
            return $this->response
                ->setHeader('Content-Type', 'application/pdf')
                ->setHeader('Content-Disposition', 'inline; filename="attachment.pdf"')
                ->setBody($attachment);
        }

        // If it is an Appwrite storage URL or Appwrite File ID
        if (str_starts_with($attachment, 'http://') || str_starts_with($attachment, 'https://')) {
            return $this->response->redirect($attachment);
        }

        if (\App\Libraries\AppwriteStorage::isConfigured() && !str_contains($attachment, '.')) {
            $viewUrl = \App\Libraries\AppwriteStorage::getFileViewUrl($attachment);
            return $this->response->redirect($viewUrl);
        }

        // Local file fallback
        $uploadPath = rtrim((string) env('app.uploadPath', FCPATH . 'uploads'), DIRECTORY_SEPARATOR);
        $filePath = $uploadPath . DIRECTORY_SEPARATOR . $attachment;

        if (file_exists($filePath)) {
            $fileContent = file_get_contents($filePath);
            return $this->response
                ->setHeader('Content-Type', 'application/pdf')
                ->setHeader('Content-Disposition', 'inline; filename="' . $attachment . '"')
                ->setBody($fileContent);
        }

        return $this->response->setStatusCode(404)->setBody('Attachment file not found on server');
    }
}