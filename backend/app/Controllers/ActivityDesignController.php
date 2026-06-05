<?php

namespace App\Controllers;

use App\Models\ActivityDesignModel;

class ActivityDesignController extends BaseController
{
    public function submitDesign()
    {
        $activityDesignModel = new ActivityDesignModel();

        // FIX 1: Ensure upload parameter name aligns with frontend append statement ('attachment')
        $rules = [
            "form-type"           => "required",
            "activity-title"      => "required",
            "start-date"          => "required",
            "end-date"            => "required",
            "start-time"          => "required",
            "end-time"            => "required",
            "venue"               => "required",
            "target-participants" => "required|numeric",
            "proposed-budget"     => "required|numeric",
            "user_id"             => "required",
            "attachment"         => "uploaded[attachment]|max_size[attachment,10240]|ext_in[attachment,pdf]",
        ];

        $messages = [
            "form-type" => ["required" => "Form type is required"],
            "activity-title" => ["required" => "Activity title is required"],
            "start-date" => ["required" => "Start date is required"],
            "end-date" => ["required" => "End date is required"],
            "start-time" => ["required" => "Start time is required"],
            "end-time" => ["required" => "End time is required"],
            "venue" => ["required" => "Venue is required"],
            "target-participants" => [
                "required" => "Target participants is required",
                "numeric"  => "Target participants must be a number",
            ],
            "proposed-budget" => [
                "required" => "Proposed budget is required",
                "numeric"  => "Proposed budget must be a numeric value",
            ],
            "user_id" => ["required" => "User identification is missing"],
            "attachment" => [
                "required" => "Design file is required",
                "uploaded" => "Design file was not uploaded correctly",
                "max_size" => "Design file size exceeds the 10MB limit",
                "ext_in" => "Design file must be a PDF",
            ],
        ];

        if (!$this->validate($rules, $messages)) {
            // FIX 2: Return errors as a JSON object, not a view
            return $this->response->setJSON([
                "success" => false,
                "errors"  => $this->validator->getErrors()
            ])->setStatusCode(422);
        }

        try {
            // FIX 3: Process and store physical upload file appropriately
            $file = $this->request->getFile('attachment');
            $fileName = '';

            if ($file && $file->isValid() && !$file->hasMoved()) {
                $fileName = $file->getRandomName();
                $uploadPath = rtrim((string) env('app.uploadPath', FCPATH . 'uploads'), DIRECTORY_SEPARATOR);

                if (!is_dir($uploadPath)) {
                    mkdir($uploadPath, 0777, true);
                }
                
                $file->move($uploadPath, $fileName);
            }

            $data = [
                "form_type"           => $this->request->getPost("form-type"),
                "activity_title"      => $this->request->getPost("activity-title"),
                "start_date"          => $this->request->getPost("start-date"),
                "end_date"            => $this->request->getPost("end-date"),
                "start_time"          => $this->request->getPost("start-time"),
                "end_time"            => $this->request->getPost("end-time"),
                "venue"               => $this->request->getPost("venue"),
                "target_participants" => $this->request->getPost("target-participants"),
                "proposed_budget"     => $this->request->getPost("proposed-budget"),
                "user_id"             => $this->request->getPost("user_id"),
                "attachment"          => $fileName,
                "status"              => "Pending",
            ];

            if (empty($data['user_id'])) {
                throw new \Exception("User ID is missing. Please log in again.");
            }

            if ($activityDesignModel->insert($data)) {
                return $this->response->setJSON([
                    "success" => true,
                    "message" => "Data saved successfully"
                ]);
            }

            // If insertion fails (e.g. model validation), return specific errors
            return $this->response->setJSON([
                "success" => false,
                "message" => "Failed to save data into database.",
                "errors"  => $activityDesignModel->errors()
            ])->setStatusCode(500);

        } catch (\Exception $e) {
            // Catch database or file system exceptions to provide a clear error message
            return $this->response->setJSON([
                "success" => false,
                "message" => "Server Error: " . $e->getMessage()
            ])->setStatusCode(500);
        }
    }

    public function index()
    {
        $activityDesignModel = new ActivityDesignModel();

        // Fetch all activity designs joined with control numbers and user office details
        $designs = $activityDesignModel
            ->select('activity_design.*, control_number.control_number as control, users.username as office, activity_design.activity_title as title, activity_design.form_type as formLabel, activity_design.start_date as date')
            ->join('users', 'users.id = activity_design.user_id', 'left')
            ->join('control_number', 'control_number.act_design_id = activity_design.act_design_id', 'left')
            ->orderBy('activity_design.act_design_id', 'DESC')
            ->findAll();

        return $this->response->setJSON([
            'success' => true,
            'data'    => $designs
        ]);
    }


    public function getUserDesigns($userId = null)
    {
        if (!$userId) {
            return $this->response->setJSON(['success' => false, 'message' => 'User ID required'])->setStatusCode(400);
        }

        $activityDesignModel = new ActivityDesignModel();
        $designs = $activityDesignModel
                                       ->select('activity_design.*, control_number.control_number as control, users.username as office, activity_design.activity_title as title, activity_design.form_type as formLabel, activity_design.start_date as date')
                                       ->join('users', 'users.id = activity_design.user_id', 'left')
                                       ->join('control_number', 'control_number.act_design_id = activity_design.act_design_id', 'left')
                                       ->where('activity_design.user_id', $userId)
                                       ->orderBy('activity_design.act_design_id', 'DESC')
                                       ->findAll();

        return $this->response->setJSON([
            'success' => true,
            'data'    => $designs
        ]);
    }

    public function show($id = null)
    {
        if (!$id) {
            return $this->response->setJSON(['success' => false, 'message' => 'Design ID required'])->setStatusCode(400);
        }

        $activityDesignModel = new ActivityDesignModel();
        $design = $activityDesignModel
            ->select('activity_design.*, control_number.control_number as control, users.username as office, activity_design.start_date as date')
            ->join('users', 'users.id = activity_design.user_id', 'left')
            ->join('control_number', 'control_number.act_design_id = activity_design.act_design_id', 'left')
            ->where('activity_design.act_design_id', $id)
            ->first();

        if (!$design) {
            // Try searching in archive fallback
            $db = \Config\Database::connect();
            $design = $db->table('archived_activity_designs as aad')
                ->select('aad.*, aad.original_act_design_id as act_design_id, aad.activity_title as title, aad.form_type as formLabel, users.username as office, aad.start_date as date')
                ->join('users', 'users.id = aad.user_id', 'left')
                ->join('control_number as cn', 'cn.act_design_id = aad.original_act_design_id', 'left')
                ->select('COALESCE(cn.control_number, "N/A") as control')
                ->where('aad.original_act_design_id', $id)
                ->get()->getRowArray();

            if (!$design) {
                return $this->response->setJSON(['success' => false, 'message' => 'Activity design not found'])->setStatusCode(404);
            }
        }

        return $this->response->setJSON(['success' => true, 'data' => $design]);
    }

    public function getTWGSubmissions()
    {
        $db = \Config\Database::connect();
        
        // Fetch users (excluding admin) and use subqueries to count submissions per user
        $users = $db->table('users')
            ->select('id, username, role')
            ->select('(SELECT COUNT(*) FROM activity_design WHERE activity_design.user_id = users.id) as activity_designs_count')
            ->select('(SELECT COUNT(*) FROM accomplishment_report WHERE accomplishment_report.user_id = users.id) as accomplishment_reports_count')
            ->where('role !=', 'admin')
            ->orderBy('id', 'ASC')
            ->get()
            ->getResultArray();

        $totalDesigns = 0;
        $totalReports = 0;
        
        // Cast counts to integers and calculate totals
        foreach ($users as &$u) {
            $u['activity_designs_count'] = (int)$u['activity_designs_count'];
            $u['accomplishment_reports_count'] = (int)$u['accomplishment_reports_count'];
            $u['total_submissions'] = $u['activity_designs_count'] + $u['accomplishment_reports_count'];
            
            $totalDesigns += $u['activity_designs_count'];
            $totalReports += $u['accomplishment_reports_count'];
        }

        return $this->response->setJSON([
            'success' => true,
            'data'    => $users,
            'meta'    => [
                'total' => count($users),
                'total_designs' => $totalDesigns,
                'total_reports' => $totalReports,
                'last_page' => 1
            ]
        ]);
    }

    public function getArchivedDesigns()
    {
        $activityDesignModel = new ActivityDesignModel();

        // Fetch designs that are 'Approved' or 'Cancelled'
        $designs = $activityDesignModel
            ->select('activity_design.*, control_number.control_number as control, users.username as office, activity_design.activity_title as title, activity_design.form_type as formLabel, activity_design.start_date as date')
            ->join('users', 'users.id = activity_design.user_id', 'left')
            ->join('control_number', 'control_number.act_design_id = activity_design.act_design_id', 'left')
            ->whereIn('activity_design.status', ['Approved', 'Cancelled'])
            ->orderBy('activity_design.act_design_id', 'DESC')
            ->findAll();

        return $this->response->setJSON([
            'success' => true,
            'data'    => $designs
        ]);
    }

    public function updateDesign($id)
    {
        // 1. Initialize the Model
        // Ensure you have "use App\Models\ActivityDesignModel;" at the top of your file
        $model = new \App\Models\ActivityDesignModel(); 
        
        $design = $model->find($id);
        if (!$design) {
            return $this->response->setJSON([
                'success' => false,
                'message' => "Activity design record #$id not found."
            ])->setStatusCode(404);
        }

        // 2. Collect only the fields that were sent in the request
        // Using array_filter ensures we don't overwrite existing data with nulls
        $data = [
            'activity_title'      => $this->request->getPost('activity_title'),
            'form_type'           => $this->request->getPost('form_type'),
            'start_date'          => $this->request->getPost('start_date'),
            'end_date'            => $this->request->getPost('end_date'),
            'start_time'          => $this->request->getPost('start_time'),
            'end_time'            => $this->request->getPost('end_time'),
            'venue'               => $this->request->getPost('venue'),
            'proposed_budget'     => $this->request->getPost('proposed_budget'),
            'target_participants' => $this->request->getPost('target_participants'),
            'status'              => $this->request->getPost('status') ?? 'Pending', // Force back to Pending
        ];

        // Remove null values so we only update what was provided in the form
        $updateData = array_filter($data, function($value) {
            return $value !== null && $value !== '';
        });

        // 3. Handle New File Upload (if any)
        $file = $this->request->getFile('attachment');
        if ($file && $file->isValid() && !$file->hasMoved()) {
            // Optional: Delete old file if you want to save space
            // if ($design['attachment'] && file_exists(FCPATH . 'uploads/' . $design['attachment'])) {
            //     unlink(FCPATH . 'uploads/' . $design['attachment']);
            // }

            $newName = $file->getRandomName();
            $uploadPath = rtrim((string) env('app.uploadPath', FCPATH . 'uploads'), DIRECTORY_SEPARATOR);

            if (!is_dir($uploadPath)) {
                mkdir($uploadPath, 0777, true);
            }

            $file->move($uploadPath, $newName);
            $updateData['attachment'] = $newName;
        }

        // 4. Execute Update
        try {
            if ($model->update($id, $updateData)) {
                return $this->response->setJSON([
                    'success' => true,
                    'message' => 'Activity Design updated and resubmitted successfully.'
                ]);
            } else {
                return $this->response->setJSON([
                    'success' => false,
                    'message' => 'Database update failed.',
                    'errors'  => $model->errors()
                ])->setStatusCode(400);
            }
        } catch (\Exception $e) {
            return $this->response->setJSON([
                'success' => false,
                'message' => 'An error occurred: ' . $e->getMessage()
            ])->setStatusCode(500);
        }
    }
}