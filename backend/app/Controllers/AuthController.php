<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\RESTful\ResourceController;

class AuthController extends ResourceController
{
    protected $format = 'json';

    public function login()
    {
        // Set CORS headers
        $this->setCorsHeaders();

        // Handle preflight request
        if (strtoupper($this->request->getMethod()) === 'OPTIONS') {
            return $this->response->setStatusCode(204);
        }

        // Handle JSON or Form-data
        $data = $this->request->getJSON(true) ?: $this->request->getPost();

        $rules = [
            'identity' => 'required',
            'password' => 'required'
        ];

        if (!$this->validateData($data, $rules)) {
            return $this->fail($this->validator->getErrors());
        }

        $identity = trim($data['identity']);
        $password = $data['password'];

        log_message('error', "LOGIN ATTEMPT: Identity=[$identity]");

        $userModel = new UserModel();
        $user = $userModel->findByIdentity($identity);

        if (!$user) {
            return $this->failUnauthorized("User not found for identity: $identity");
        }

        if (!password_verify($password, $user['password'])) {
            // Debug: Check if it's a legacy MD5 or something (unlikely but let's check)
            if (md5($password) === $user['password']) {
                 return $this->failUnauthorized('Legacy MD5 password detected. Please reset your password.');
            }
            return $this->failUnauthorized("Password verification failed for user: " . $user['username']);
        }

        log_message('error', "LOGIN SUCCESS: User [" . $user['username'] . "] authenticated.");

        // In a real app, you'd generate a JWT here. 
        // For this demo, we'll just return user info.
        return $this->respond([
            'status' => 200,
            'message' => 'Login successful',
            'user' => [
                'id' => $user['id'],
                'username' => $user['username'],
                'role' => $user['role']
            ]
        ]);
    }

    public function register()
    {
        // Set CORS headers
        $this->setCorsHeaders();

        // Handle preflight request
        if (strtoupper($this->request->getMethod()) === 'OPTIONS') {
            return $this->response->setStatusCode(200);
        }

        $data = $this->request->getJSON(true) ?: $this->request->getPost();

        $rules = [
            'fullname' => 'required',
            'university_id' => 'required',
            'department' => 'required',
            'email' => 'required|valid_email',
            'password' => 'required|min_length[6]',
            'confirm_password' => 'required|matches[password]'
        ];

        if (!$this->validateData($data, $rules)) {
            return $this->fail($this->validator->getErrors());
        }

        $email = $data['email'];
        $username = strtolower(str_replace(' ', '_', explode('@', $email)[0]));
        
        $userModel = new UserModel();
        
        // Check if user exists
        if ($userModel->findByIdentity($email)) {
            return $this->failResourceExists('A user with that email or username already exists');
        }

        $userData = [
            'username' => $username,
            'email' => $email,
            'password' => password_hash($data['password'], PASSWORD_DEFAULT),
            'role' => 'college', // Default role for registration
            'full_name' => $data['fullname'],
            'student_id' => $data['university_id'],
            'college' => $data['department']
        ];

        if ($userModel->insert($userData)) {
            return $this->respondCreated(['message' => 'Account created successfully. Please log in.']);
        }

        return $this->fail('Unable to create account. Please try again later.');
    }

    public function logout()
    {
        $this->setCorsHeaders();
        return $this->respond(['message' => 'Logout successful']);
    }

    private function setCorsHeaders()
    {
        $frontendOrigin = rtrim((string) env('app.frontendURL', 'https://gad-ams.appwrite.network'), '/');

        $this->response->setHeader('Access-Control-Allow-Origin', $frontendOrigin)
                       ->setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS, PATCH')
                       ->setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With, Accept')
                       ->setHeader('Access-Control-Allow-Credentials', 'true')
                       ->setHeader('Access-Control-Max-Age', '86400');
    }
}
