<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

class CorsFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        // Handle preflight OPTIONS requests
        if (strtoupper($request->getMethod()) === 'OPTIONS') {
            $response = service('response');
            $this->setCorsHeaders($response);
            return $response->setStatusCode(200);
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // Inject CORS headers into normal responses (GET, POST, etc.)
        $this->setCorsHeaders($response);
        return $response;
    }

    private function setCorsHeaders(ResponseInterface $response)
    {
        $frontendOrigin = rtrim((string) env('app.frontendURL', 'https://gad-ams.appwrite.network'), '/');

        $response->setHeader('Access-Control-Allow-Origin', $frontendOrigin);
        $response->setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS, PATCH');
        $response->setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With, Accept');
        $response->setHeader('Access-Control-Max-Age', '86400');
    }
}