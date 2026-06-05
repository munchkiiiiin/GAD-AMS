-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2026 at 03:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gad_submission_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `accomplishment_report`
--

CREATE TABLE `accomplishment_report` (
  `id` int(11) NOT NULL,
  `control_number` varchar(50) NOT NULL,
  `activity_title` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `venue` varchar(255) NOT NULL,
  `attendees` int(11) NOT NULL,
  `male` int(11) NOT NULL,
  `female` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accomplishment_report`
--

INSERT INTO `accomplishment_report` (`id`, `control_number`, `activity_title`, `start_date`, `end_date`, `start_time`, `end_time`, `venue`, `attendees`, `male`, `female`, `rating`, `attachment`, `user_id`, `status`, `created_at`) VALUES
(1, 'GAD-2024-001', 'Voluptatum doloremqu', '2000-10-06', '1988-01-28', '23:45:00', '15:05:00', 'Qui rem reprehenderi', 58, 35, 28, 86, '1779884224_2f4c9f25b5500814d806.pdf', 47, 'Pending', '2026-05-27 12:17:04'),
(2, 'GAD-2024-003', 'Exercitationem dolor', '2010-07-11', '2016-09-14', '10:32:00', '16:05:00', 'Dolor sit irure dolo', 41, 22, 22, 20, '1780114466_73f25e1fd9093a3537ec.pdf', 2, 'Pending', '2026-05-30 04:14:26');

-- --------------------------------------------------------

--
-- Table structure for table `activity_design`
--

CREATE TABLE `activity_design` (
  `act_design_id` int(11) NOT NULL,
  `activity_title` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `attachment` varchar(500) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `gpb_id` int(11) DEFAULT NULL,
  `venue` varchar(255) DEFAULT NULL,
  `target_participants` int(11) DEFAULT NULL,
  `proposed_budget` int(8) DEFAULT NULL,
  `form_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_design`
--

INSERT INTO `activity_design` (`act_design_id`, `activity_title`, `start_date`, `end_date`, `start_time`, `end_time`, `status`, `attachment`, `user_id`, `gpb_id`, `venue`, `target_participants`, `proposed_budget`, `form_type`) VALUES
(1, 'Voluptatum doloremqu', '2000-10-06', '1988-01-28', '23:45:00', '15:05:00', 'Revision', '1779877140_31b6724d338a0bb7c2e7.pdf', 47, NULL, 'Qui rem reprehenderi', 58, 60, 'extension'),
(2, 'Eu Nam non itaque qu', '1977-09-03', '2018-06-05', '17:34:00', '06:11:00', 'Pending', '1779880718_f0964cad8b90daa94468.pdf', 47, NULL, 'Cupiditate voluptate', 26, 37, 'extension'),
(3, 'Exercitationem dolor', '2010-07-11', '2016-09-14', '10:32:00', '16:05:00', 'Pending', '1779948695_310c88237b212824d580.pdf', 47, NULL, 'Dolor sit irure dolo', 41, 77, 'inset'),
(4, 'Officia deserunt ill', '1974-07-22', '1984-03-02', '17:13:00', '02:36:00', 'Pending', '1780114334_1789776b8290ab550748.pdf', 2, NULL, 'Dicta est eos aut mo', 11, 13, 'extension'),
(5, 'Nostrum exercitation', '1983-10-12', '2016-09-03', '19:39:00', '00:58:00', 'Pending', '1780117957_4ec41dfc077083083b92.pdf', 2, NULL, 'Aute repellendus Ad', 89, 31, 'extension');

-- --------------------------------------------------------

--
-- Table structure for table `archived_accomplishment_reports`
--

CREATE TABLE `archived_accomplishment_reports` (
  `archive_id` int(11) NOT NULL,
  `original_report_id` int(11) NOT NULL,
  `control_number` varchar(50) NOT NULL,
  `activity_title` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `venue` varchar(255) NOT NULL,
  `attendees` int(11) NOT NULL,
  `male` int(11) NOT NULL,
  `female` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(20) DEFAULT 'Completed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `archived_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `archived_accomplishment_reports`
--

INSERT INTO `archived_accomplishment_reports` (`archive_id`, `original_report_id`, `control_number`, `activity_title`, `start_date`, `end_date`, `start_time`, `end_time`, `venue`, `attendees`, `male`, `female`, `rating`, `attachment`, `user_id`, `status`, `created_at`, `archived_at`) VALUES
(1, 1, 'GAD-2024-001', 'Voluptatum doloremqu', '2026-06-15', '2026-06-17', '08:00:00', '17:00:00', 'Qui rem reprehenderi', 58, 30, 28, 92, '1779884224_2f4c9f25b5500814d806.pdf', 47, 'Completed', '2026-05-27 04:17:04', '2026-05-29 23:02:15');

-- --------------------------------------------------------

--
-- Table structure for table `archived_activity_designs`
--

CREATE TABLE `archived_activity_designs` (
  `archive_id` int(11) NOT NULL,
  `original_act_design_id` int(11) NOT NULL,
  `activity_title` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Approved',
  `attachment` varchar(500) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `gpb_id` int(11) DEFAULT NULL,
  `venue` varchar(255) DEFAULT NULL,
  `target_participants` int(11) DEFAULT NULL,
  `proposed_budget` int(8) DEFAULT NULL,
  `form_type` varchar(255) NOT NULL,
  `archived_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `archived_activity_designs`
--

INSERT INTO `archived_activity_designs` (`archive_id`, `original_act_design_id`, `activity_title`, `start_date`, `end_date`, `start_time`, `end_time`, `status`, `attachment`, `user_id`, `gpb_id`, `venue`, `target_participants`, `proposed_budget`, `form_type`, `archived_at`) VALUES
(1, 1, 'Voluptatum doloremqu', '2026-06-15', '2026-06-17', '08:00:00', '17:00:00', 'Approved', '1779877140_31b6724d338a0bb7c2e7.pdf', 47, 3, 'Qui rem reprehenderi', 58, 60000, 'extension', '2026-05-29 22:15:00'),
(2, 2, 'Eu Nam non itaque qu', '2026-07-10', '2026-07-11', '09:00:00', '16:30:00', 'Approved', '1779880718_f0964cad8b90daa94468.pdf', 2, 4, 'Cupiditate voluptate', 26, 37000, 'extension', '2026-05-29 22:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `control_number`
--

CREATE TABLE `control_number` (
  `control_number_id` int(11) NOT NULL,
  `control_number` varchar(50) DEFAULT NULL,
  `act_design_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `control_number`
--

INSERT INTO `control_number` (`control_number_id`, `control_number`, `act_design_id`, `user_id`) VALUES
(1, 'GAD-2024-001', 1, 47),
(2, 'GAD-2024-002', 2, 47),
(3, 'GAD-2024-003', 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `gad_plan_budget`
--

CREATE TABLE `gad_plan_budget` (
  `gpb_id` int(11) NOT NULL,
  `gender_issue_mandate` varchar(255) DEFAULT NULL,
  `cause_of_gender_issue` text DEFAULT NULL,
  `gad_result_objective` text DEFAULT NULL,
  `relevant_org_mfo_pap` text DEFAULT NULL,
  `gad_activity` varchar(255) DEFAULT NULL,
  `performance_indicators_targets` text DEFAULT NULL,
  `gad_budget` decimal(15,2) DEFAULT NULL,
  `budget_breakdown` text DEFAULT NULL,
  `source_of_budget` varchar(100) DEFAULT NULL,
  `responsible_unit_office` varchar(100) NOT NULL,
  `form_type` enum('client-focused activity','organization-focused activity','attributed program') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gad_plan_budget`
--

INSERT INTO `gad_plan_budget` (`gpb_id`, `gender_issue_mandate`, `cause_of_gender_issue`, `gad_result_objective`, `relevant_org_mfo_pap`, `gad_activity`, `performance_indicators_targets`, `gad_budget`, `budget_breakdown`, `source_of_budget`, `responsible_unit_office`, `form_type`) VALUES
(1, 'Republic Act No. 10931, Universal Access to Quality Tertiary Education Act Section 8 on Affirmative Action Program; CHED Memorandum Orders on GAD Mainstreaming in Higher Education Institutions (HEIs)', 'Extraordinary life situations due to disasters, calamities, and socio-cultural discrimination', 'To promote equitable access and participation of both women and men from GIDAs in tertiary education through gender-responsive implementation of the Affirmative Action Agenda.', 'MFO: Higher Education Program', 'Implementation of Affirmative Action Agenda', 'Number of served disadvantaged students - 100% disadvantaged students', 700000.00, 'PS Attribution 500,000.00 Supplies and Materials 200,000.00', 'GAA GAA', 'OSS', 'client-focused activity'),
(2, 'Republic Act No. 10931, Universal Access to Quality Tertiary Education Act Section 8 on Affirmative Action Program; CHED Memorandum Orders on GAD Mainstreaming in Higher Education Institutions (HEIs)', 'High tuition and miscellaneous fees, compounded by socio-cultural expectations for women to prioritize domestic roles over education', 'To promote gender equality in access to tertiary education by eliminating financial barriers for both male and female students.', 'MFO: Higher Education Program', 'Provision of free tuition fee under RA 10931 to eligible male and female students of the university', 'Percentage of qualified students granted free tuition - 100% of qualified students granted free tuition.', 131100000.00, 'Tuition Fee 131,100,000.00', 'GAA', 'OSS, OUR, UHS', 'client-focused activity'),
(3, 'CHED Memorandum Order No. 01 series 2015', 'Limited activities to increase awareness of men and women students to GAD-related information (1st year students, transferees)', 'To increase the students level of awareness and appreciation on GAD', 'MFO: Higher Education Program', 'Conduct GAD orientation/ forum/ seminar to BSU 1st year/ transferees students (face to face/ online: 14 colleges)', 'No. of students oriented on GAD - 4,000 students oriented on GAD (F:2750 M:1250)', 453363.26, 'Meals and Snack 318,800.00 Supplies and Materials 10,000.00 PS Attribution 124,563.26', 'GAA GAA GAA', 'OSS, GAD Office, 3 Campuses (La Trinidad, Bokod & Buguias Campus)', 'client-focused activity'),
(4, 'CHED Memorandum Order No. 01 series 2015', 'Student leaders have limited understanding on GAD in the University', 'To empower student leaders regarding GAD responsive leadership (La Trinidad Campus, Bokod Campus and Buguias Campus)', 'MFO: Higher Education Program', 'Continuous conduct of GAD responsive leadership training for student', 'No. of training conducted to increase GAD awareness and responsiveness of students leaders - 2 training (Female:200 Male:100) (La Trinidad Campus, Bokod Campus and Buguias Campus)', 150000.00, 'Supplies and Materials 30,000.00 Snack 20,000.00 PS Attribution 100,000.00', 'GAA GAA GAA', 'OSS', 'client-focused activity'),
(5, 'Part VII of CHED Memorandum Order Number 1, series 2015 on Gender-Responsive Research and Extension Program', 'Presence of gender inequality, poverty and GAD-related concerns in the community', 'To sustain GAD-related extension activities delivering technology transfer, Livelihood Program, Technical Assistance, and Advocacy to community partners to help promote gender equality, poverty reduction and sustainable developmen', 'MFO: Extension Services- Research Services- Advance Education ServicesHigher Education Services', 'Conduct of Extension project/ activities to partner organizational/ communities as component of Gender Responsive Extension Program (GREP) to partner organization/ communities', 'No. of extension activities conducted within the year - 24 Extension program/project/ activities conducted within the year (Female:560 Male: 500)', 3500000.00, 'Seminar Package/Meals & Snacks/ Fuel for Transportation/ Vehicle Rental/ Other Professional Services 2,500,000.00 PS Attribution 1,000,000.00', 'GAA GAA', 'Research and Extension, various offices/ colleges in the University/ external campuses', 'client-focused activity'),
(6, 'Limited access of PWDs to gender-responsive programs and services/DBM-DSWD Joint Circular No. 2003-01 provides guidelines for the implementation of Section 29 of the General Appropriations Act (GAA), requiring government agencies to set aside at least 1% ', 'Limited access of PWDs to gender-responsive programs and services', 'Improved access of PWDs to gender-responsive, inclusive, and empowering programs and services.', 'MFO: Research Services- Extension Services-Advance Education ServicesHigher Education Services', 'Awareness of women PWDs who benefited from the program', 'Number of women PWDs who benefited from the program - FM No. of GAD program/project/ activityprovided for PWD - At least 1 program/project/ activity', 350000.00, 'PS Attribution 100,000.00 Supplies & Materials/ Meals & Snacks 250,000.00', 'GAA GAA', 'HRMO, OSS', 'client-focused activity'),
(7, 'Lack of senior citizens access to gender-responsive programs and services/DBM-DSWD Joint Circular No. 2003-01 provides guidelines for the implementation of Section 29 of the General Appropriations Act (GAA), requiring government agencies to set aside at l', 'Absence of sustainable and gender-responsive university programs for senior citizens', 'Improved access of senior citizensto gender-responsive, inclusive, and empowering programs and services', 'MFO: Research Services- Extension Services- Advance Education ServicesHigher Education Services', 'Program: BSU Kalinga for women Senior Citizens', 'Number of Programs provided for Senior Citizens - At least 1 program for BSU Number of women senior citizens who benefited from the program - F21 M23', 250000.00, 'Supplies & Materials/ Meals & Snacks 250,000.00', 'GAA', 'GAD Office, Colleges, External Campuses', 'client-focused activity'),
(8, 'Low number of women\'s participation in sports/MCW-IRR Section 14 Develop, establish and strengthen programs for the participation of women in competitive and non-competitive sports as means to achieve excellence, promote physical and social well-being', 'Minimal attendance of female students to competitive and non-competitive sports', 'To increase female students level of participation and awareness on Gender in Sports', 'MFO: Higher Education Program', 'Participate in sports activities targeted for female students', 'No. of sports activities supported through allocation of budget for sports and socio- cultural activities/ E-sports (i.e. Annual Women\'s Martial Arts Festival- 2 sports activities (Female:20)', 160000.00, 'Registration & Travelling Expenses 80,000.00 Meals and Snacks 60,000.00 PS Attribution 20,000.00', 'GAA GAA GAA', 'CHK', 'client-focused activity'),
(9, 'Programs on Awards and Incentives for Service Excellence (PRAISE under CSC Res.No.010112 and CSC MC No.1,s. 2001); Memo Circular No.2011-01 (Guidelines for the Creation, Strengthening and Institutionalization of GAD Focal Point System: Roles and Responsib', 'Low recognition/ appreciation on the Gender Mainstreaming in BSU', 'Strengthen Gender Mainstreaming through recognition of GAD implementation in the University', 'MFO: Research Services-Extension Services- Advance Education ServicesHigher Education Services', 'Provide recognition and award to GAD implementer and other GAD-related award (GAD implementer for students and employees, GAD Advocate Award)', 'No. of award will be provided through BSU-PRAISE- At least 1 GAD Advocate award will be provided through BSU-PRAISE', 205000.00, 'Incentive GAD Advocate Award 5,000.00 PS Attribution 200,000.00', 'GAA GAA', 'HRDO, HRMO, BSU-PRAISE Committee, GAD Office', 'organization-focused activity'),
(10, 'Limited application of GAD Mainstreaming (GM) in Instruction, Research, Extension and Production/Magna Carta of Women (RA 9710)', 'Low awareness among personnel in the University about GAD mainstreaming', 'To enhance GAD mainstreaming in Administration, Academic, Research and Extension, Production', 'MFO: Research Services- Extension Services- Advance Education ServicesHigher Education Services', 'Conduct GAD related Gender Mainstreaming capability building and competency acquisition', 'No. of training/workshop/ seminars conducted - 25 training/ workshop/ seminars/ Learning and Development (F:1500 M: 1000)', 4000000.00, 'Seminar Package/Meals & Snacks/ Fuel for Transportation/ Vehicle Rental/ Professional Services (La Trinidad Bokod and Buguias Campus) 3,500,000.00 PS Attribution 500,000.00', 'GAA GAA', 'GAD Office, HRDO, Research and Extension, OQAA, All Colleges with External Campuses', 'organization-focused activity'),
(11, 'Magna Carta of Women IRR Section 37 Gender Mainstreaming as a Strategy for Implementing the Magna Carta of Women', 'Productivity of employees affected due to filial obligations, affecting promotion of women to higher positions or from participating in capability enhancement sessions', 'Inadequate support services to personnel and students with children', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Operationalize of BSU College of Nursing Reproductive Health Care Center', 'No. of maintained Reproductive Health Care Center- 1 maintained BSU CN Reproductive Health Care Center', 120000.00, 'Supplies and Materials 20,000.00 PS Attribution 100,000.00', 'GAA GAA', 'College of Nursing', 'organization-focused activity'),
(12, 'Executive Order No. 340 s. 1997 Directing National Government Agencies and Government-Owned and-Controlled Corporations to provide Day Care Services for their Employee\'s Children under five years of age', 'Problems of parents and students related to child care', 'Ensure opportunities of personnel and students to have access on agency care services to children to avoid absenteeism', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Maintenance of Child Minding Center for working parents in ensuring that they have a safe place to leave their child while they are at their work places', 'No. of established child minding center- Fully maintained new established and existing child minding centers at BSU La Trinidad,Bokod Campus and Buguias Campus', 230000.00, 'Supplies and Materials 130,000.00 PS Attribution 100,000.00', 'GAA GAA', 'GAD Office, External Campuses', 'organization-focused activity'),
(13, 'Magna Carta of Women (RA 9710)', 'Low integration of gender mainstreaming of BSU', 'To strengthen the GAD integration in the operations of BSU', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Create a Monitoring Team to conduct monitoring and evaluation of the utilization/ outcome of GAD PAPs and ensure effectiveness of the GAD PAPs', 'No. of monitoring and assessment meetings with reports conducted4 monitoring and assessment meetings with reports conducted', 330000.00, 'Supplies and Materials 10,000.00 PS Attribution 320,000.00', 'GAA GAA', 'GAD Office', 'organization-focused activity'),
(14, 'Magna Carta of Women IRR Section 37 C. Creation and/or Strengthening of the GAD Focal Points (GFPs)', 'Low level of capacity of GFPS to develop and implement GAD programs and activities due to new members', 'Capacitated GFPS members in order to implement GAD PAP\'s and advance GAD Mainstreaming (GM) in the University', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'for GFPS/Secretariat: GMEF/HGDG/GPB/GAD Agenda/GAD Deepening Session and TOT among other related trainings and capacity building activities (Regional/ National GAD-related trainings/ seminars/ forum/workshop)', 'No. training/ seminars/ workshop attendance for each GFPS-members on GAD related updates and mandates- At least 1 Training/ seminar/ workshop attendance for each GFPS-members on GAD related updates and mandates (Female: 31, Male: 15)', 896000.00, 'GFPS TWG PAPs 396,000.00 PS Attribution 500,000.00', 'GAA GAA', 'GAD Office', 'organization-focused activity'),
(15, 'Section 37-C2 Rule VI of the Magna Carta of Women\'s IRR on duties and function of the GAD Focal Point System/Magna Carta of Women (RA 9710)', 'Compliance to provisions regarding regular monitoring of gender mainstreaming efforts', 'To ensure operations of GAD Office as well as monitor and evaluate GM efforts of the University', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Regular coordination and meetings of GAD-GFPS (Execom, GFPS- TWG members and external campus TWG members) and emergency meeting when necessary', 'No. of reports on regular meetings per campus conducted will be available at the end of the year - At least 6 reports on regular meetings conducted will be available at the end of the year, RGADC quarterly meeting/s', 211720.00, 'Meals & Snack 111,720.00 PS Attribution 100,000.00', 'GAA GAA', 'GAD Office', 'organization-focused activity'),
(16, 'Duties and function of the GAD Focal Point System/CHED Memo 2015-1', 'No plantilla personnel assigned to plan, implement and monitor GAD PAPs on a full-time basis', 'To ensure operations of GAD Office as well as monitor and evaluate GM efforts of the University', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Engage support staff to assist in the implementation of GFPS PPA\'s and Gender Mainstreaming in the university through rehiring of GAD staff and Student Assistant', 'Salary of GAD Staff: Casual No. of rehired personnel (casual) and student assistant -At least two (2) staff renewed/rehired (Casual) and at least one (3) Student Assistant/ SPES per semester', 550000.00, 'Salary of GAD Staff and SPES/ Student Assistant 550,000.00', 'GAA', 'GAD Office', 'organization-focused activity'),
(17, 'Low level of Awareness on Gender Mainstreaming (GM) in Instruction, Research, Extension and\nProduction among newly hired personnel/Magna of Women (RA 9710), CHED Memo 2015-1', 'Lack of regular orientation and refresher training on gender sensitivity and GAD mandates', 'To enhance awareness and understanding of gender concepts, GAD mandates, and gender-responsive work practices among newly hired and current personnel', 'MFO: Conduct Gender Sensitivity Training (GST) for newly hired and current personnel (continuing activity)', 'Conduct Gender Sensitivity Training (GST) for newly hired and current personnel (continuing activity)', 'No. of training conducted for newly hired personnel and refresher trainings for current personnel - 1 training conducted for at least 100% of newly hired personnel and 3 refresher trainings for current personnel', 421728.32, 'Meals & Snack 167,200.00 Token 4,000.00 Professional Fee 144,528.32 Supplies and Materials 6,000.00 PS Attribution 100,000.00', 'GAA GAA GAA GAA GAA', 'GAD Office', 'organization-focused activity'),
(18, 'Part V, Rule II, Section 4 of CHED Memorandum Order No. 1 Series of 2015/CHED Memo 2015-1', 'Limited number of GAD library and related learning materials across various discipline', 'To increase the provision of adequate and accessible library and related learning materials across various disciplines and educational levels', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Provision of knowledge products (books magazine, multi-media) for adequate and accessible library and related learning materials in support to gender-responsive Curriculum Programs', 'No. of procured library and learning materials- 200 books', 2600000.00, 'Books and Instructional Materials 2,500,000.00 PS Attribution 100,000.00', 'GAA GAA', 'ULIS', 'organization-focused activity'),
(19, 'Development and Dissemination of Gender and Development (GAD) Information, Education, and Communication (IEC) Materials', 'Presence of Gender Based Violence (GBV) issues/reports/cases in the university', 'Institutionalize GAD mechanisms in the University and sustain awareness campaigns on sexual harassment and gender-based violence', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Development and Dissemination of Gender and Development (GAD) Information, Education, and Communication (IEC) Materials', 'No. of Communication and IEC materials/knowledge products - Official Publication of BSU with GAD articles, pictures as a medium for employees, clients, students partners to disseminate programs, achievement and advocacies, Maintained GAD Bulletin board - At least 8 GAD Bulletin board ,Sector-specific knowledge products on GAD generated and designed to be downloadable via BSU website - At least 2', 296000.00, 'Shamag 96,000.00 PS Attribution 100,000.00 Supplies and Materials 100,000.00', 'GAA GAA GAA', 'UPAO, GAD Office', 'organization-focused activity'),
(20, 'Institutionalizing GAD database and Sex-Disaggregated Database/Magna Carta of Women (RA 9710), Section 36 on Sex-Disaggregated Database', 'Minimal awareness and appreciation on the relevance of the centralized Sex-Disaggregated database', 'To establish a centralized GAD-related database of the University', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Updating of Sex-Disaggregated Data (SDD) and other data related to personnel/students/clients GAD-related database for gender analysis and report preparation', 'No. of well-organized and maintained GAD database for easy reference and access 1 GAD databaseEstablishment of GAD-Database system per college/unit.', 1100000.00, 'PS Attribution 100,000.00 Maintenance of SDD/ Internet connection 1,000,000.00', 'GAA GAA', 'ICT, GAD Office', 'organization-focused activity'),
(21, 'Magna Carta for women, Chapter IV: Section 10 and RA 10121, Section 2 & 9', 'Limited resources of the DSWD and LGU to provide for students who are transient residents and limited appreciation on women\'s role in nation building among employees and students, especially new ones', 'To ensure that disaster assistance provided to distressed students are gender-responsive', 'MFO: MFO: Research ServicesMFO: Extension Services MFO: Advance Education ServicesMFO: Higher Education Services', 'Provision of gender-responsive services to employees and students who experienced crisis/ disaster (e.g. Distribution of hygiene kits for both women and men)', 'No. of pax of the most affected employees/ students during crises - 1,000 employees/students', 211200.00, 'Crisis pack: Php,200/ pack X 1,000.00 pax 200,000.00 PS TWG Members 10,000.00', 'GAA GAA', 'GAD Office, HDRO, NSTP, various offices/ all colleges in the University', 'organization-focused activity'),
(22, 'Compliance to Section 18 of MCW RA 9710:Special Leave Benefits for Women RA 8187: Paternity Leave Section 8 of RA 8972:Solo Parents Welfare Act of 2000 Section 43 of RA 9262: Anti-Violence Against Women and Their Children Act of 2004)', 'Employees may require special leaves due to parental obligations, health concerns and other circumstances that may require the need thereof', 'Enhanced support services for employees in need of special leaves', 'MFO: MFO: Research ServicesMFO: Extension Services MFO: Advance Education ServicesMFO: Higher Education Services', 'Provision of gender leaves and conduct of Seminar on Gender Related Leaves for Newly Hired Employees', 'No. of Maternity, Paternity, Solo parent, gynecological, VAWC leave of employees who will avail and 1 Seminar conducted (M:20 F:50)- All (100%) Maternity, Paternity, Solo parent, gynecological, VAWC leave of employees who will avail and 1 Seminar conducted (M:20 F:50)', 1000000.00, 'PS Attribution 1,000,000.00', 'GAA', 'HRMO, CBOO, various offices/ colleges in the University', 'organization-focused activity'),
(23, 'Compliance to Proclamation 227 on the observance of Women\'s Role in History Month and Proclamation 1172, s. 2006 on the 18-Day Campaign to End Violence Against Women (VAW)', 'The need to highlight women\'s rights, their role in national development/ nation building and need to provide platform to invoke protection of women\'s rights against VAW, gender-based violence, Safe Spaces Act (RA No. 11313) and concerns that affect women and men', 'To strengthen awareness of BSU students/ employees on women\'s rights and their role in national development and nation building', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Participation to18-Day Campaign to end VAW and Women\'s Month Celebration/ activities and programs organized by PCW and other agency/ies', 'No. of activities conducted per campus - At least one (1) activity conducted per campus', 450001.00, 'At least one (1) activity conducted per campus 250,000.00 PS Attribution 200,000.00', 'GAA GAA', 'GAD Office, various offices/ colleges in the University/ external campus', 'organization-focused activity'),
(24, 'Productivity of employees affected due to filial obligations, affecting promotion of women to higher positions or from participating in capability enhancement sessions/Magna Carta of Women IRR Section 37 Gender Mainstreaming as a Strategy for Implementing', 'Inadequate support services for personnel/students with young children and breastfeeding mothers (affecting productivity, especially among women non implementation of RA 10028)', 'Inadequate support services to personnel and students with children', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Establishment/ maintenance of breastfeeding station established in the preceding years', 'Fully maintained Lactation rooms - 100% fully maintained lactation rooms at BSU La Trinidad, Bokod and BuguiasCampus', 220000.00, 'Supplies and Materials 50,000.00 PS Attribution 170,000.00', 'GAA GAA', 'GAD Office, External Campuses', 'organization-focused activity'),
(25, 'Low level of employees understanding of gender issues/ concept to promote gender equality and a gender-responsive work environment./RA 9710 (Magna Carta of Women), PCWNEDADBM Joint Circular 2012-01, and CSC MC No. 12 s. 2005, the University shall conduct ', 'Lack of regular gender-related capacity-building activities and insufficient integration of gender sensitivity in employee development programs', 'To enhance the gender awareness and sensitivity of BSU employees, enabling them to recognize and eliminate gender bias and stereotyping, and to foster a gender-responsive and equitable workplace', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Conduct of gender sensitivity orientations for BSU Personnel (continuing activity)', 'No. of training conducted for BSU personnel -At least 3 training to be conducted', 253796.24, 'Supplies and Materials 10,000.00 Meals & Snack/ Professional Fee 233,796.24 PS 10,000.00', 'GAA GAA GAA', 'GAD Office', 'organization-focused activity'),
(26, 'Establishment of Gender-Responsive Curricular Programs/Part V of CMO 01, s. 2015/ CHED Memo 2015-1', 'Limited subject for GAD Integration of Gender-Responsive Instruction and Curriculum Developmen', 'Integration of gender mainstreaming in curriculum/ subjects in all levels', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Preparation of syllabi and classroom teaching integrating gender perspective', 'Number of faculty members integrated Gender perspective in the syllabus - 567 permanent and 125 COS females and males faculty integrating and development of gender-sensitive learning materials', 58295539.71, 'PS 567 Teaching employees and COS 51,294,972.71 Teaching Overload 7,000,000.00', 'GAA GAA', 'GAD Office, GFPS-TWG members, all colleges', 'organization-focused activity'),
(27, 'Need to sustain a functional and gender-responsive GAD Focal Point System (GFPS) and GAD Office to ensure the effective mainstreaming of gender perspective in BSU academic, research, extension, and administrative programs/Section 37-C2 of the Magna Carta ', 'Sustained operations of the existing GAD Office-Provision of administrative, logistical, and financial support for the day-to-day functioning of the GAD Office maintenance of GAD database and documentation systems coordination of GFPS and GAD-related activities across colleges and units.', 'To ensure the continuous and efficient operation of a functional, gender-responsive GAD Office that leads, monitors, and evaluates GAD mainstreaming efforts in the university.', 'MFO: Research ServicesExtension Services Advance Education ServicesHigher Education Services', 'Sustaining Gender Mainstreaming and Institutional Support in the University', 'Fully maintained GAD Office - 100% fully maintained GAD office', 8052420.09, 'PS on Procurement Process 30,992.09 PS Attribution: Execom & TWG members 7,219,424.00 Supplies Equipment and Materials 300,000.00 PS of GAD Director(50%) 501,954.00', 'GAA GAA GAA GAA', 'GAD Office', 'organization-focused activity'),
(28, '', '', '', '', 'Transportation Equipment Outlay', '', 12285000.00, '', 'GAA', 'TASU, PMO, SPMO', 'attributed program'),
(29, '', '', '', '', 'Repair and Maintenance Office Building and other Structures', '', 6402000.00, '', 'GAA', 'PU, PMO, SPMO', 'attributed program'),
(30, '', '', '', '', 'Bamboo Industry Development for Environment Conservation and Countryside', '', 3750000.00, '', 'GAA', 'PU, PMO, SPMO', 'attributed program'),
(31, '', '', '', '', 'Benguet State University Student Information and Accounting System (SIAS)', '', 5000000.00, '', 'GAA', 'ICT, PMO', 'attributed program');

-- --------------------------------------------------------

--
-- Table structure for table `gpb_budget_breakdown`
--

CREATE TABLE `gpb_budget_breakdown` (
  `breakdown_id` int(11) NOT NULL,
  `gpb_id` int(11) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `gpb_budget_breakdown`
--
DELIMITER $$
CREATE TRIGGER `trg_sync_budget` AFTER INSERT ON `gpb_budget_breakdown` FOR EACH ROW BEGIN
    UPDATE gad_ams.gad_plan_budget
    SET budget_breakdown = (
        SELECT GROUP_CONCAT(CONCAT(category, ': ', amount) SEPARATOR ', ')
        FROM gad_ams.gpb_budget_breakdown
        WHERE gpb_id = NEW.gpb_id
    )
    WHERE gpb_id = NEW.gpb_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `gpb_offices_map`
--

CREATE TABLE `gpb_offices_map` (
  `gpb_id` int(11) NOT NULL,
  `office_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `gpb_offices_map`
--
DELIMITER $$
CREATE TRIGGER `trg_sync_offices` AFTER INSERT ON `gpb_offices_map` FOR EACH ROW BEGIN
    UPDATE gad_ams.gad_plan_budget
    SET responsible_unit_office = (
        SELECT GROUP_CONCAT(o.office_name SEPARATOR ', ')
        FROM gad_ams.office_units o
        JOIN gad_ams.gpb_offices_map gom ON o.office_id = gom.office_id
        WHERE gom.gpb_id = NEW.gpb_id
    )
    WHERE gpb_id = NEW.gpb_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mandate`
--

CREATE TABLE `mandate` (
  `mandate_id` int(11) NOT NULL,
  `mandate_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `gpb_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `office_units`
--

CREATE TABLE `office_units` (
  `office_id` int(11) NOT NULL,
  `office_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `log_id` bigint(20) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action_type` varchar(100) DEFAULT NULL,
  `target_table` varchar(50) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `log_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `office_unit` varchar(255) DEFAULT NULL,
  `year_level` varchar(255) DEFAULT NULL,
  `user_acronym` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `email_verified_at`, `password`, `role`, `full_name`, `student_id`, `office_unit`, `year_level`, `user_acronym`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Gender And Development', 'gad.office@bsu.edu.ph', NULL, '$2y$12$TUG4cubrDNdHbOd2q6WsdOAyxxwwCW71UuPE9AEnIIyg.BQeueFW.', 'admin', NULL, NULL, NULL, NULL, 'GAD', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(2, 'College of Agriculture', 'ca@bsu.edu.ph', NULL, '$2y$12$CNLb7UPOnZpF2yZRY0lwSeykT0VWruAa6R753JUJR3bGr2OCvUyei', 'college', NULL, NULL, NULL, NULL, 'CA', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(3, 'Registrar\'s Office BSU Buguias Campus', 'buguias.registrar@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Buguias-RO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(4, 'Human Resources and Management Office BSU Bokod Campus', 'bokod.hrmo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, NULL, 'Bokod-HRMO', NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(5, 'International Relations Office', 'iro@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'IRO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(6, 'Disaster Risk Reduction Management', 'drrm@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'DRRM', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(7, 'College of Social Science', 'css@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CSS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-30 11:07:16'),
(8, 'College of Applied Techonology BSU Bokod Campus', 'bokod.cat@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Bokod-CAT', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(9, 'University Business Affairs Office', 'ubao@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'UBAO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(10, 'University Library and Information Service BSU Buguias Campus', 'ulis.buguias@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Buguias-ULIS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(11, 'College of Veterinary Medicine', 'vm@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CVM', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(12, 'Compensarion, Benefits and Other Obligations', 'cboo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CBOO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(13, 'Records Office and Archives', 'roa@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'ROA', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(14, 'Budget Office', 'bo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, NULL, 'BO', NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(15, 'Office for Quality Assurance and Accreditation', 'oqaa@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'OQAA', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(16, 'University Health Services BSU Buguias Campus', 'buguias.uhs@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Buguias-UHS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(17, 'College of Natural Sciences', 'cns@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, NULL, 'CNS', NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(18, 'College of Public Administration and Governance', 'cpag@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CPAG', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(19, 'Information and Communications Technolgy', 'ict@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'ICT', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(20, 'General Services Office', 'gso@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'GSO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(21, 'College of Engineering', 'ce@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CE', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(22, 'College of Nursing', 'cn@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CN', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(23, 'BSU Office of Student Services', 'oss@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'OSS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(24, 'University Public Affairs Office', 'upao@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'UPAO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(25, 'Accounting Office', 'ao@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'AO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(26, 'College of Human Kenetics', 'chk@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CHK', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(27, 'Horticulture', 'h@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Horticulture', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(28, 'Bokod Focal Person, University Health Services', 'bokod.uhs@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Bokod-FC,UHS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(29, 'Buguias Focal Person, College of Agriculture', 'buguias.ca@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Buguias-FC,CA', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(30, 'Human Resources Development Office', 'hrdo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'HRDO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(31, 'Budget Office Buguias Campus', 'buguias.bo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Buguias-BO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(32, 'College of Information Sciences', 'cis@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CIS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(33, 'Procurement Management Office BSU Bokod Campus', 'bokod.pmo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Bokod-PMO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(34, 'Procurement Management Office', 'pmo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'PMO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(35, 'Office of Student Services', 'oss.2@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'OSS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(36, 'College of Arts and Humanities', 'cah@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CAH', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(37, 'College of Teacher Education', 'cte@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CTE', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(38, 'Human Resource and Management Office', 'hrmo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'HRMO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(39, 'College of Home Economics and Technology', 'chet@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CHET', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(40, 'Supply Property Management Office', 'spmo@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'SPMO', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(41, 'University Library and Information Services', 'ulis@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'ULIS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(42, 'College of Numeracy and Applied Sciences', 'cnas@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CNAS', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(43, 'Northern Philippines Root Crops Research  & Training Center', 'nprcrtc@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'NPRCRTC', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(44, 'Open University', 'ou@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'OU', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(45, 'College of Education BSU Bokod Campus', 'bokod.ce@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'Bokod-CE', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(46, 'College of Forestry', 'cf@bsu.edu.ph', NULL, '$2y$12$l7EFqawcRIOIN9O.LGwQ..4PpoSt5sbaRziIQVMbNsOJbF7b/3Lpq', 'college', NULL, NULL, NULL, NULL, 'CF', NULL, NULL, '2026-05-25 11:58:10', '2026-05-25 11:58:10'),
(47, 'gad.staff', 'gad.staff@bsu.edu.ph', NULL, '$2y$12$fbD/jvk.znEQnBmKq4.ebOojmijHJO/zU7.P7Tzo.zV3FgvP8PzNe', 'gad_staff', 'GAD Staff User', NULL, NULL, NULL, 'GAD-STAFF', NULL, NULL, '2026-03-26 15:53:56', '2026-03-26 15:53:56');

-- --------------------------------------------------------

--
-- Table structure for table `users_auth`
--

CREATE TABLE `users_auth` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `user_role` enum('Director','Staff','TWG','Non-TWG') DEFAULT NULL,
  `office_unit_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accomplishment_report`
--
ALTER TABLE `accomplishment_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_report_user` (`user_id`);

--
-- Indexes for table `activity_design`
--
ALTER TABLE `activity_design`
  ADD PRIMARY KEY (`act_design_id`),
  ADD KEY `fk_activity_user` (`user_id`),
  ADD KEY `fk_activity_gpb` (`gpb_id`);

--
-- Indexes for table `archived_accomplishment_reports`
--
ALTER TABLE `archived_accomplishment_reports`
  ADD PRIMARY KEY (`archive_id`);

--
-- Indexes for table `archived_activity_designs`
--
ALTER TABLE `archived_activity_designs`
  ADD PRIMARY KEY (`archive_id`);

--
-- Indexes for table `control_number`
--
ALTER TABLE `control_number`
  ADD PRIMARY KEY (`control_number_id`),
  ADD UNIQUE KEY `control_number` (`control_number`),
  ADD KEY `fk_control_activity` (`act_design_id`),
  ADD KEY `fk_control_user` (`user_id`);

--
-- Indexes for table `gad_plan_budget`
--
ALTER TABLE `gad_plan_budget`
  ADD PRIMARY KEY (`gpb_id`);

--
-- Indexes for table `gpb_budget_breakdown`
--
ALTER TABLE `gpb_budget_breakdown`
  ADD PRIMARY KEY (`breakdown_id`),
  ADD KEY `gpb_id` (`gpb_id`);

--
-- Indexes for table `gpb_offices_map`
--
ALTER TABLE `gpb_offices_map`
  ADD PRIMARY KEY (`gpb_id`,`office_id`),
  ADD KEY `office_id` (`office_id`);

--
-- Indexes for table `mandate`
--
ALTER TABLE `mandate`
  ADD PRIMARY KEY (`mandate_id`),
  ADD KEY `fk_mandate_gpb` (`gpb_id`);

--
-- Indexes for table `office_units`
--
ALTER TABLE `office_units`
  ADD PRIMARY KEY (`office_id`),
  ADD UNIQUE KEY `office_name` (`office_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accomplishment_report`
--
ALTER TABLE `accomplishment_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `activity_design`
--
ALTER TABLE `activity_design`
  MODIFY `act_design_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `archived_accomplishment_reports`
--
ALTER TABLE `archived_accomplishment_reports`
  MODIFY `archive_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `archived_activity_designs`
--
ALTER TABLE `archived_activity_designs`
  MODIFY `archive_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `control_number`
--
ALTER TABLE `control_number`
  MODIFY `control_number_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gad_plan_budget`
--
ALTER TABLE `gad_plan_budget`
  MODIFY `gpb_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `gpb_budget_breakdown`
--
ALTER TABLE `gpb_budget_breakdown`
  MODIFY `breakdown_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mandate`
--
ALTER TABLE `mandate`
  MODIFY `mandate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `office_units`
--
ALTER TABLE `office_units`
  MODIFY `office_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accomplishment_report`
--
ALTER TABLE `accomplishment_report`
  ADD CONSTRAINT `fk_report_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `activity_design`
--
ALTER TABLE `activity_design`
  ADD CONSTRAINT `fk_activity_gpb` FOREIGN KEY (`gpb_id`) REFERENCES `gad_plan_budget` (`gpb_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `control_number`
--
ALTER TABLE `control_number`
  ADD CONSTRAINT `fk_control_activity` FOREIGN KEY (`act_design_id`) REFERENCES `activity_design` (`act_design_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_control_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `gpb_budget_breakdown`
--
ALTER TABLE `gpb_budget_breakdown`
  ADD CONSTRAINT `gpb_budget_breakdown_ibfk_1` FOREIGN KEY (`gpb_id`) REFERENCES `gad_plan_budget` (`gpb_id`) ON DELETE CASCADE;

--
-- Constraints for table `gpb_offices_map`
--
ALTER TABLE `gpb_offices_map`
  ADD CONSTRAINT `gpb_offices_map_ibfk_1` FOREIGN KEY (`gpb_id`) REFERENCES `gad_plan_budget` (`gpb_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `gpb_offices_map_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `office_units` (`office_id`) ON DELETE CASCADE;

--
-- Constraints for table `mandate`
--
ALTER TABLE `mandate`
  ADD CONSTRAINT `fk_mandate_gpb` FOREIGN KEY (`gpb_id`) REFERENCES `gad_plan_budget` (`gpb_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
