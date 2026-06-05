<?php

namespace Config;

use CodeIgniter\Database\Config;

/**
 * Database Configuration
 */
class Database extends Config
{
    /**
     * The directory that holds the Migrations and Seeds directories.
     */
    public string $filesPath = APPPATH . 'Database' . DIRECTORY_SEPARATOR;

    /**
     * Lets you choose which connection group to use if no other is specified.
     */
    public string $defaultGroup = 'default';

    /**
     * The default database connection.
     *
     * @var array<string, mixed>
     */
    public array $default = [
        'DSN'          => '',
        'hostname'     => 'localhost',
        'username'     => 'root',
        'password'     => '',
        'database'     => 'gad_submission_system',
        'DBDriver'     => 'MySQLi',
        'DBPrefix'     => '',
        'pConnect'     => false,
        'DBDebug'      => true,
        'charset'      => 'utf8mb4',
        'DBCollat'     => 'utf8mb4_general_ci',
        'swapPre'      => '',
        'encrypt'      => false,
        'compress'     => false,
        'strictOn'     => false,
        'failover'     => [],
        'port'         => 3306,
        'numberNative' => false,
        'foundRows'    => false,
        'dateFormat'   => [
            'date'     => 'Y-m-d',
            'datetime' => 'Y-m-d H:i:s',
            'time'     => 'H:i:s',
        ],
    ];

    //    /**
    //     * Sample database connection for SQLite3.
    //     *
    //     * @var array<string, mixed>
    //     */
    //    public array $default = [
    //        'database'    => 'database.db',
    //        'DBDriver'    => 'SQLite3',
    //        'DBPrefix'    => '',
    //        'DBDebug'     => true,
    //        'swapPre'     => '',
    //        'failover'    => [],
    //        'foreignKeys' => true,
    //        'busyTimeout' => 1000,
    //        'synchronous' => null,
    //        'dateFormat'  => [
    //            'date'     => 'Y-m-d',
    //            'datetime' => 'Y-m-d H:i:s',
    //            'time'     => 'H:i:s',
    //        ],
    //    ];

    //    /**
    //     * Sample database connection for Postgre.
    //     *
    //     * @var array<string, mixed>
    //     */
    //    public array $tests = [
    //        'DSN'         => '',
    //        'hostname'    => 'localhost',
    //        'username'    => 'root',
    //        'password'    => '',
    //        'database'    => 'ci4_test',
    //        'DBDriver'    => 'Postgre',
    //        'DBPrefix'    => 'db_', // Needed to protect 'public' keyword in Postgre
    //        'pConnect'    => false,
    //        'DBDebug'     => true,
    //        'charset'     => 'utf8',
    //        'DBCollat'    => '',
    //        'swapPre'     => '',
    //        'encrypt'     => false,
    //        'compress'    => false,
    //        'strictOn'    => false,
    //        'failover'    => [],
    //        'port'        => 5432,
    //        'numberNative' => false,
    //        'dateFormat'  => [
    //            'date'     => 'Y-m-d',
    //            'datetime' => 'Y-m-d H:i:s',
    //            'time'     => 'H:i:s',
    //        ],
    //    ];

    public function __construct()
    {
        parent::__construct();

        // Dynamic SSL configuration for Aiven MySQL or other remote DB
        $encrypt = env('database.default.encrypt');
        if ($encrypt !== null) {
            if ($encrypt === 'true' || $encrypt === true || $encrypt === '1' || $encrypt === 1) {
                $this->default['encrypt'] = [
                    'ssl_ca'     => ' ', // dummy non-empty string to trigger CI4 SSL initialization
                    'ssl_verify' => false
                ];
            } else {
                $this->default['encrypt'] = false;
            }
        }
    }
}
