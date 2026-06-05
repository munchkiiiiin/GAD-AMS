<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

$routes->group('api', function($routes) {
    $routes->options('submit-activity-design', 'ActivityDesignController::submitDesign');
    $routes->post('submit-activity-design', 'ActivityDesignController::submitDesign');
    
    $routes->options('submit-activity-report', 'AccomplishmentReportController::submitReport');
    $routes->post('submit-activity-report', 'AccomplishmentReportController::submitReport');


    // Route for fetching all designs and reports (for staff/admin)
    $routes->options('activity-designs', 'ActivityDesignController::index');
    $routes->get('activity-designs', 'ActivityDesignController::index');

    $routes->options('activity-reports', 'AccomplishmentReportController::index');
    $routes->get('activity-reports', 'AccomplishmentReportController::index');

    
    // Route for fetching a single activity design's & accomplishment report's details
    $routes->options('activity-design/(:num)', 'ActivityDesignController::show/$1');
    $routes->get('activity-design/(:num)', 'ActivityDesignController::show/$1');

    $routes->options('activity-designs/(:num)', 'ActivityDesignController::getUserDesigns/$1');
    $routes->get('activity-designs/(:num)', 'ActivityDesignController::getUserDesigns/$1');

    $routes->options('activity-report/(:num)', 'AccomplishmentReportController::show/$1');
    $routes->get('activity-report/(:num)', 'AccomplishmentReportController::show/$1');

    $routes->options('activity-reports/(:num)', 'AccomplishmentReportController::getUserReports/$1');
    $routes->get('activity-reports/(:num)', 'AccomplishmentReportController::getUserReports/$1');

    // Route for fetching approved control numbers
    $routes->get('approved-controls/(:num)', 'ApprovedControlsController::index/$1');

    // Routes for archived items
    $routes->options('archives', 'ArchiveController::index');
    $routes->get('archives', 'ArchiveController::index');
    $routes->post('archive-item', 'ArchiveController::archiveItem');

    // Admin tracking routes
    $routes->get('admin/twg-submissions', 'ActivityDesignController::getTWGSubmissions');


    $routes->options('login', 'AuthController::login');
    $routes->post('login', 'AuthController::login');
});
