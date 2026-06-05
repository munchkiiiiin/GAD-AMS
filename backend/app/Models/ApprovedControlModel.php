<?php

namespace App\Models;

use CodeIgniter\Model;

class ApprovedControlModel extends Model
{
    protected $table = 'control_number'; // Primary table for this model
    protected $primaryKey = 'control_number_id';
    protected $allowedFields = ['control_number', 'act_design_id', 'user_id'];

    /**
     * Fetches approved control numbers along with their associated activity design details
     * for a given user.
     *
     * @param int $userId The ID of the user.
     * @return array An array of objects containing control number and activity design details.
     */
    public function getApprovedControlsWithActivityDetails(int $userId): array
    {
        return $this->select('control_number.control_number,
                              activity_design.activity_title,
                              activity_design.start_date,
                              activity_design.end_date,
                              activity_design.start_time,
                              activity_design.end_time,
                              activity_design.venue,
                              activity_design.target_participants')
                    ->join('activity_design', 'activity_design.act_design_id = control_number.act_design_id')
                    ->where('control_number.user_id', $userId)
                    ->findAll();
    }
}