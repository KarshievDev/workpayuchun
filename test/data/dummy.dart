
final settingJson = {
  "result": true,
  "message": "Base settings information",
  "data": {
    "is_admin": true,
    "is_hr": true,
    "is_manager": true,
    "is_face_registered": true,
    "multi_checkin": true,
    "location_bind": true,
    "is_ip_enabled": false,
    "departments": [
      {
        "id": 1,
        "title": "IT"
      },
      {
        "id": 2,
        "title": "Management"
      },
      {
        "id": 5,
        "title": "LA Company 1"
      },
      {
        "id": 6,
        "title": "LA Company 2"
      },
      {
        "id": 7,
        "title": "LA Company 3"
      },
      {
        "id": 8,
        "title": "LA Company 4"
      },
      {
        "id": 9,
        "title": "LA Company 5"
      }
    ],
    "designations": [
      {
        "id": 1,
        "title": "Admin"
      },
      {
        "id": 2,
        "title": "HR"
      },
      {
        "id": 3,
        "title": "Staff"
      },
      {
        "id": 6,
        "title": "Police Constable"
      },
      {
        "id": 7,
        "title": "PI"
      },
      {
        "id": 9,
        "title": "Finance"
      }
    ],
    "employee_types": [
      "Permanent",
      "On Probation",
      "Contractual",
      "Intern"
    ],
    "permissions": "[\"team_menu\",\"team_list\",\"team_create\",\"team_update\",\"team_edit\",\"team_delete\",\"team_member_view\",\"team_member_create\",\"team_member_edit\",\"team_member_delete\",\"team_member_assign\",\"team_member_unassign\",\"dashboard\",\"hr_menu\",\"designation_read\",\"designation_create\",\"designation_update\",\"designation_delete\",\"shift_read\",\"shift_create\",\"shift_update\",\"shift_delete\",\"department_read\",\"department_create\",\"department_update\",\"department_delete\",\"user_menu\",\"user_read\",\"profile_view\",\"user_create\",\"user_edit\",\"user_update\",\"user_delete\",\"user_banned\",\"user_unbanned\",\"make_hr\",\"user_permission\",\"profile_image_view\",\"user_device_list\",\"reset_device\",\"phonebook_profile\",\"support_ticket_profile\",\"advance_profile\",\"commission_profile\",\"salary_profile\",\"project_profile\",\"task_profile\",\"award_profile\",\"travel_profile\",\"attendance_profile\",\"appointment_profile\",\"visit_profile\",\"leave_request_profile\",\"notice_profile\",\"role_read\",\"role_create\",\"role_update\",\"role_delete\",\"branch_read\",\"branch_create\",\"branch_update\",\"branch_delete\",\"leave_menu\",\"leave_type_read\",\"leave_type_create\",\"leave_type_update\",\"leave_type_delete\",\"leave_assign_read\",\"leave_assign_create\",\"leave_assign_update\",\"leave_assign_delete\",\"leave_request_read\",\"leave_request_create\",\"leave_request_store\",\"leave_request_update\",\"leave_request_approve\",\"leave_request_reject\",\"leave_request_delete\",\"daily_leave_read\",\"appointment_read\",\"appointment_menu\",\"appointment_create\",\"appointment_approve\",\"appointment_reject\",\"appointment_delete\",\"weekend_read\",\"weekend_update\",\"attendance_update\",\"holiday_read\",\"holiday_create\",\"holiday_update\",\"holiday_delete\",\"schedule_read\",\"schedule_create\",\"schedule_update\",\"schedule_delete\",\"attendance_menu\",\"attendance_read\",\"attendance_create\",\"attendance_update\",\"attendance_delete\",\"generate_qr_code\",\"leave_settings_read\",\"leave_settings_update\",\"company_settings_read\",\"company_settings_update\",\"locationApi\",\"company_setup_menu\",\"company_setup_activation\",\"company_setup_configuration\",\"company_setup_ip_whitelist\",\"company_setup_location\",\"location_create\",\"location_store\",\"location_edit\",\"location_update\",\"location_delete\",\"ip_read\",\"ip_create\",\"ip_update\",\"ip_delete\",\"attendance_report_read\",\"live_tracking_read\",\"report_menu\",\"report\",\"claim_read\",\"claim_create\",\"claim_update\",\"claim_delete\",\"payment_read\",\"payment_create\",\"payment_update\",\"payment_delete\",\"visit_menu\",\"visit_read\",\"visit_view\",\"visit_update\",\"payroll_menu\",\"list_payroll_item\",\"create_payroll_item\",\"store_payroll_item\",\"update_payroll_item\",\"delete_payroll_item\",\"view_payroll_item\",\"payroll_item_menu\",\"list_payroll_set\",\"create_payroll_set\",\"store_payroll_set\",\"update_payroll_set\",\"delete_payroll_set\",\"view_payroll_set\",\"edit_payroll_set\",\"payroll_set_menu\",\"advance_salaries_menu\",\"advance_salaries_create\",\"advance_salaries_store\",\"advance_salaries_edit\",\"advance_salaries_update\",\"advance_salaries_delete\",\"advance_salaries_view\",\"advance_salaries_approve\",\"advance_salaries_list\",\"advance_salaries_pay\",\"advance_salaries_invoice\",\"advance_salaries_search\",\"payslip_menu\",\"salary_generate\",\"salary_view\",\"salary_delete\",\"salary_edit\",\"salary_update\",\"salary_payment\",\"payslip_list\",\"advance_type_menu\",\"advance_type_create\",\"advance_type_store\",\"advance_type_edit\",\"advance_type_update\",\"advance_type_delete\",\"advance_type_view\",\"advance_type_list\",\"salary_menu\",\"salary_store\",\"salary_edit\",\"salary_update\",\"salary_delete\",\"salary_view\",\"salary_list\",\"salary_search\",\"salary_pay\",\"salary_invoice\",\"salary_approve\",\"salary_generate\",\"salary_calculate\",\"account_menu\",\"account_create\",\"account_store\",\"account_edit\",\"account_update\",\"account_delete\",\"account_view\",\"account_list\",\"account_search\",\"deposit_menu\",\"deposit_create\",\"deposit_store\",\"deposit_edit\",\"deposit_update\",\"deposit_delete\",\"deposit_list\",\"expense_menu\",\"expense_create\",\"expense_store\",\"expense_edit\",\"expense_update\",\"expense_delete\",\"expense_list\",\"expense_view\",\"expense_approve\",\"expense_invoice\",\"expense_pay\",\"transaction_menu\",\"transaction_create\",\"transaction_store\",\"transaction_edit\",\"transaction_update\",\"transaction_delete\",\"transaction_view\",\"transaction_list\",\"deposit_category_menu\",\"deposit_category_create\",\"deposit_category_store\",\"deposit_category_edit\",\"deposit_category_update\",\"deposit_category_delete\",\"deposit_category_list\",\"payment_method_menu\",\"payment_method_create\",\"payment_method_store\",\"payment_method_edit\",\"payment_method_update\",\"payment_method_delete\",\"payment_method_list\",\"project_menu\",\"project_create\",\"project_store\",\"project_edit\",\"project_update\",\"project_delete\",\"project_view\",\"project_list\",\"project_activity_view\",\"project_member_view\",\"project_member_delete\",\"project_complete\",\"project_payment\",\"project_invoice_view\",\"project_discussion_create\",\"project_discussion_store\",\"project_discussion_edit\",\"project_discussion_update\",\"project_discussion_delete\",\"project_discussion_view\",\"project_discussion_list\",\"project_discussion_comment\",\"project_discussion_reply\",\"project_file_create\",\"project_file_store\",\"project_file_edit\",\"project_file_update\",\"project_file_delete\",\"project_file_view\",\"project_file_list\",\"project_file_download\",\"project_file_comment\",\"project_file_reply\",\"project_notes_create\",\"project_notes_store\",\"project_notes_edit\",\"project_notes_update\",\"project_notes_delete\",\"project_notes_list\",\"client_menu\",\"client_create\",\"client_store\",\"client_edit\",\"client_update\",\"client_delete\",\"client_view\",\"client_list\",\"task_menu\",\"task_create\",\"task_store\",\"task_edit\",\"task_update\",\"task_delete\",\"task_view\",\"task_list\",\"task_activity_view\",\"task_assign_view\",\"task_assign_delete\",\"task_complete\",\"task_discussion_create\",\"task_discussion_store\",\"task_discussion_edit\",\"task_discussion_update\",\"task_discussion_delete\",\"task_discussion_view\",\"task_discussion_list\",\"task_discussion_comment\",\"task_discussion_reply\",\"task_file_create\",\"task_file_store\",\"task_file_edit\",\"task_file_update\",\"task_file_delete\",\"task_file_view\",\"task_file_list\",\"task_file_download\",\"task_file_comment\",\"task_file_reply\",\"task_notes_create\",\"task_notes_store\",\"task_notes_edit\",\"task_notes_update\",\"task_notes_delete\",\"task_notes_list\",\"task_files_comment\",\"award_type_menu\",\"award_type_create\",\"award_type_store\",\"award_type_edit\",\"award_type_update\",\"award_type_delete\",\"award_type_view\",\"award_type_list\",\"award_menu\",\"award_create\",\"award_store\",\"award_edit\",\"award_update\",\"award_delete\",\"award_list\",\"travel_type_menu\",\"travel_type_create\",\"travel_type_store\",\"travel_type_edit\",\"travel_type_update\",\"travel_type_delete\",\"travel_type_view\",\"travel_type_list\",\"travel_menu\",\"travel_create\",\"travel_store\",\"travel_edit\",\"travel_update\",\"travel_delete\",\"travel_list\",\"travel_approve\",\"travel_payment\",\"meeting_menu\",\"meeting_create\",\"meeting_store\",\"meeting_edit\",\"meeting_update\",\"meeting_delete\",\"meeting_list\",\"performance_menu\",\"performance_settings\",\"performance_indicator_menu\",\"performance_indicator_list\",\"performance_indicator_create\",\"performance_indicator_store\",\"performance_indicator_edit\",\"performance_indicator_update\",\"performance_indicator_delete\",\"performance_appraisal_menu\",\"performance_appraisal_create\",\"performance_appraisal_store\",\"performance_appraisal_edit\",\"performance_appraisal_update\",\"performance_appraisal_delete\",\"performance_appraisal_list\",\"performance_appraisal_view\",\"performance_goal_type_menu\",\"performance_goal_type_create\",\"performance_goal_type_store\",\"performance_goal_type_edit\",\"performance_goal_type_update\",\"performance_goal_type_delete\",\"performance_goal_type_list\",\"performance_goal_menu\",\"performance_goal_create\",\"performance_goal_store\",\"performance_goal_edit\",\"performance_goal_update\",\"performance_goal_delete\",\"performance_goal_view\",\"performance_goal_list\",\"performance_competence_type_list\",\"performance_competence_type_menu\",\"performance_competence_type_create\",\"performance_competence_type_store\",\"performance_competence_type_edit\",\"performance_competence_type_update\",\"performance_competence_type_delete\",\"performance_competence_type_view\",\"performance_competence_menu\",\"performance_competence_create\",\"performance_competence_store\",\"performance_competence_edit\",\"performance_competence_update\",\"performance_competence_delete\",\"performance_competence_view\",\"performance_competence_list\",\"app_settings_menu\",\"app_settings_update\",\"language_menu\",\"make_default\",\"conference_read\",\"general_settings_read\",\"general_settings_update\",\"email_settings_update\",\"storage_settings_update\",\"language_create\",\"language_store\",\"language_edit\",\"language_update\",\"language_delete\",\"setup_language\",\"content_menu\",\"content_create\",\"content_store\",\"content_edit\",\"content_update\",\"content_delete\",\"contact_menu\",\"contact_create\",\"contact_store\",\"contact_edit\",\"contact_update\",\"contact_delete\",\"conference_create\",\"conference_read\",\"conference_store\",\"conference_update\",\"conference_delete\",\"conference_join\",\"model_read\",\"model_create\",\"model_update\",\"model_delete\",\"brand_read\",\"brand_create\",\"brand_update\",\"brand_delete\",\"machine_read\",\"machine_create\",\"machine_update\",\"machine_delete\",\"package_read\",\"package_create\",\"package_update\",\"package_delete\",\"institution_read\",\"institution_create\",\"institution_update\",\"institution_delete\",\"addons_menu\",\"employee_document_type_read\",\"employee_document_type_create\",\"employee_document_type_update\",\"employee_document_type_delete\",\"employee_document_read\",\"employee_document_create\",\"employee_document_download\",\"subscription_read\",\"subscription_upgrade\",\"subscription_invoice\",\"announcement_menu\",\"notice_menu\",\"notice_list\",\"notice_create\",\"notice_update\",\"notice_edit\",\"notice_delete\",\"send_sms_menu\",\"send_sms_list\",\"send_sms_create\",\"send_sms_update\",\"send_sms_edit\",\"send_sms_delete\",\"send_email_menu\",\"send_email_list\",\"send_email_create\",\"send_email_update\",\"send_email_edit\",\"send_email_delete\",\"send_notification_menu\",\"send_notification_list\",\"send_notification_create\",\"send_notification_update\",\"send_notification_edit\",\"send_notification_delete\",\"announcement_menu\",\"notice_menu\",\"notice_list\",\"notice_create\",\"notice_update\",\"notice_edit\",\"notice_delete\",\"send_sms_menu\",\"send_sms_list\",\"send_sms_create\",\"send_sms_update\",\"send_sms_edit\",\"send_sms_delete\",\"send_email_menu\",\"send_email_list\",\"send_email_create\",\"send_email_update\",\"send_email_edit\",\"send_email_delete\",\"send_notification_menu\",\"send_notification_list\",\"send_notification_create\",\"send_notification_update\",\"send_notification_edit\",\"send_notification_delete\",\"support_menu\",\"support_read\",\"support_create\",\"support_reply\",\"support_delete\"]",
    "time_wish": {
      "wish": "Good Day",
      "sub_title": "Best wishes for your day!",
      "image": "https://demo.24hourworx.com/assets/app/dashboard/good-day.svg"
    },
    "time_zone": "Europe/Tirane",
    "currency_symbol": "£",
    "currency_code": "IMP",
    "attendance_method": "N",
    "duty_schedule": {
      "start_time": {
        "hour": 10,
        "min": 0,
        "sec": 0
      },
      "end_time": {
        "hour": 18,
        "min": 0,
        "sec": 0
      },
      "list_of_start_datetime": [
        {
          "id": 1000001,
          "datetime": "2024-07-02 10:0"
        },
        {
          "id": 1000002,
          "datetime": "2024-07-03 10:0"
        },
        {
          "id": 1000003,
          "datetime": "2024-07-04 10:0"
        },
        {
          "id": 1000004,
          "datetime": "2024-07-05 10:0"
        },
        {
          "id": 1000007,
          "datetime": "2024-07-08 10:0"
        },
        {
          "id": 1000008,
          "datetime": "2024-07-09 10:0"
        },
        {
          "id": 1000009,
          "datetime": "2024-07-10 10:0"
        },
        {
          "id": 1000010,
          "datetime": "2024-07-11 10:0"
        },
        {
          "id": 1000011,
          "datetime": "2024-07-12 10:0"
        },
        {
          "id": 1000014,
          "datetime": "2024-07-15 10:0"
        },
        {
          "id": 1000015,
          "datetime": "2024-07-16 10:0"
        },
        {
          "id": 1000016,
          "datetime": "2024-07-17 10:0"
        },
        {
          "id": 1000017,
          "datetime": "2024-07-18 10:0"
        },
        {
          "id": 1000018,
          "datetime": "2024-07-19 10:0"
        },
        {
          "id": 1000021,
          "datetime": "2024-07-22 10:0"
        },
        {
          "id": 1000022,
          "datetime": "2024-07-23 10:0"
        },
        {
          "id": 1000023,
          "datetime": "2024-07-24 10:0"
        },
        {
          "id": 1000024,
          "datetime": "2024-07-25 10:0"
        },
        {
          "id": 1000025,
          "datetime": "2024-07-26 10:0"
        },
        {
          "id": 1000028,
          "datetime": "2024-07-29 10:0"
        },
        {
          "id": 1000029,
          "datetime": "2024-07-30 10:0"
        },
        {
          "id": 1000030,
          "datetime": "2024-07-31 10:0"
        }
      ],
      "list_of_end_datetime": [
        {
          "id": 2000001,
          "datetime": "2024-07-02 18:0"
        },
        {
          "id": 2000002,
          "datetime": "2024-07-03 18:0"
        },
        {
          "id": 2000003,
          "datetime": "2024-07-04 18:0"
        },
        {
          "id": 2000004,
          "datetime": "2024-07-05 18:0"
        },
        {
          "id": 2000007,
          "datetime": "2024-07-08 18:0"
        },
        {
          "id": 2000008,
          "datetime": "2024-07-09 18:0"
        },
        {
          "id": 2000009,
          "datetime": "2024-07-10 18:0"
        },
        {
          "id": 2000010,
          "datetime": "2024-07-11 18:0"
        },
        {
          "id": 2000011,
          "datetime": "2024-07-12 18:0"
        },
        {
          "id": 2000014,
          "datetime": "2024-07-15 18:0"
        },
        {
          "id": 2000015,
          "datetime": "2024-07-16 18:0"
        },
        {
          "id": 2000016,
          "datetime": "2024-07-17 18:0"
        },
        {
          "id": 2000017,
          "datetime": "2024-07-18 18:0"
        },
        {
          "id": 2000018,
          "datetime": "2024-07-19 18:0"
        },
        {
          "id": 2000021,
          "datetime": "2024-07-22 18:0"
        },
        {
          "id": 2000022,
          "datetime": "2024-07-23 18:0"
        },
        {
          "id": 2000023,
          "datetime": "2024-07-24 18:0"
        },
        {
          "id": 2000024,
          "datetime": "2024-07-25 18:0"
        },
        {
          "id": 2000025,
          "datetime": "2024-07-26 18:0"
        },
        {
          "id": 2000028,
          "datetime": "2024-07-29 18:0"
        },
        {
          "id": 2000029,
          "datetime": "2024-07-30 18:0"
        },
        {
          "id": 2000030,
          "datetime": "2024-07-31 18:0"
        }
      ]
    },
    "location_services": {
      "google": true,
      "barikoi": false
    },
    "google_api_key": null,
    "barikoi_api": {
      "key": null,
      "secret": null,
      "endpoint": null,
      "status_id": 4
    },
    "break_status": {
      "break_time": "",
      "back_time": "",
      "reason": "",
      "created_at": "",
      "updated_at": "",
      "status": "break_out",
      "diff_time": ""
    },
    "live_tracking": {
      "app_sync_time": "",
      "live_data_store_time": ""
    },
    "location_service": true,
    "app_theme": "earth",
    "is_team_lead": true,
    "notification_channels": [
      "user1Demo",
      "department1Demo"
    ],
    "multi_shift": [
      {
        "shift_id": 1,
        "name": "Morning"
      },
      {
        "shift_id": 2,
        "name": "Evening"
      },
      {
        "shift_id": 3,
        "name": "Night"
      }
    ],
    "modules": {
      "MultiBranch": false,
      "FaceAttendance": true,
      "SingleDeviceLogin": false,
      "VideoConference": true,
      "Services": true,
      "Saas": true,
      "EmployeeDocuments": true,
      "MenuPermission": false,
      "LiveTracking": true,
      "MultiTheme": true,
      "AreaBasedAttendance": true,
      "IpBasedAttendance": true,
      "QrBasedAttendance": true,
      "SelfieBasedAttendance": true,
      "OfflineBasedAttendance": true,
      "MultiShift": true
    },
    "attendance_methods": [
      {
        "title": "Face Attendance",
        "short_description": "“Face attendance” tracked through facial recognition.",
        "slug": "face_attendance",
        "image": "https://demo.24hourworx.com/images/attendance/face-attendance.png"
      },
      {
        "title": "Selfie Attendance",
        "short_description": "“Selfie attendance” individuals confirm their presence by taking a selfie.",
        "slug": "selfie_attendance",
        "image": "https://demo.24hourworx.com/images/attendance/selfie-attendance.png"
      }
    ]
  }
};

final homeDataJson = {
  "result": true,
  "message": "Dashboard Statistics Data",
  "data": {
    "today": [
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/appoinment.png",
        "title": "Appointments",
        "slug": "appointment",
        "number": 0
      },
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/meeting.png",
        "title": "Meetings",
        "slug": "meeting",
        "number": 0
      },
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/visit.png",
        "title": "Visit",
        "slug": "visit",
        "number": 0
      },
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/ticket.png",
        "title": "Support Tickets",
        "slug": "support_ticket",
        "number": 0
      }
    ],
    "current_month": [
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/lateIn.png",
        "title": "Late In",
        "slug": "late_in",
        "number": "0"
      },
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/leave.png",
        "title": "Leave",
        "slug": "leave",
        "number": "0"
      },
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/absent.png",
        "title": "Absent",
        "slug": "absent",
        "number": "1"
      },
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/visit.png",
        "title": "Visits",
        "slug": "visits",
        "number": 0
      },
      {
        "image": "https://demo.24hourworx.com/assets/app/dashboard/rewards.png",
        "title": "Rewards",
        "slug": "rewards",
        "number": 0
      }
    ],
    "appoinment_list": [
      {
        "id": 7,
        "title": "Test",
        "date": "June 14",
        "day": "Friday",
        "time": "10:55 AM",
        "start_at": "10:55 am",
        "end_at": "2:55 pm",
        "location": "Test",
        "appoinmentWith": "HR",
        "participants": [
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          },
          {
            "name": "HR",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          }
        ]
      },
      {
        "id": 6,
        "title": "Test",
        "date": "June 14",
        "day": "Friday",
        "time": "2:54 PM",
        "start_at": "2:54 pm",
        "end_at": "3:55 pm",
        "location": "test",
        "appoinmentWith": "Admin1",
        "participants": [
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          },
          {
            "name": "Admin1",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          }
        ]
      },
      {
        "id": 5,
        "title": "Test PM",
        "date": "June 13",
        "day": "Thursday",
        "time": "1:30 PM",
        "start_at": "1:30 pm",
        "end_at": "3:30 pm",
        "location": "Test PM location",
        "appoinmentWith": "Admin",
        "participants": [
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          },
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          }
        ]
      },
      {
        "id": 4,
        "title": "hello there",
        "date": "June 13",
        "day": "Thursday",
        "time": "12:57 AM",
        "start_at": "12:57 am",
        "end_at": "3:57 am",
        "location": "dhaka",
        "appoinmentWith": "Admin3",
        "participants": [
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          },
          {
            "name": "Admin3",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          }
        ]
      },
      {
        "id": 3,
        "title": "jumpa kakoa",
        "date": "June 1",
        "day": "Saturday",
        "time": "8:21 AM",
        "start_at": "8:21 am",
        "end_at": "10:21 am",
        "location": "klcc",
        "appoinmentWith": "Admin",
        "participants": [
          {
            "name": "ZEMBO",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          },
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          }
        ]
      },
      {
        "id": 2,
        "title": "faysal",
        "date": "May 10",
        "day": "Friday",
        "time": "4:17 AM",
        "start_at": "4:17 am",
        "end_at": "3:17 am",
        "location": "gulshan",
        "appoinmentWith": "Admin4",
        "participants": [
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          },
          {
            "name": "Admin4",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          }
        ]
      },
      {
        "id": 1,
        "title": "whahah",
        "date": "May 24",
        "day": "Friday",
        "time": "6:32 AM",
        "start_at": "6:32 am",
        "end_at": "6:01 am",
        "location": "seleke",
        "appoinmentWith": "Admin",
        "participants": [
          {
            "name": "Admin1",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          },
          {
            "name": "Admin",
            "is_agree": "Agree",
            "is_present": "Absent",
            "present_at": null,
            "appoinment_started_at": null,
            "appoinment_ended_at": null,
            "appoinment_duration": null
          }
        ]
      }
    ],
    "upcoming_events": [],
    "attendance_status": {
      "id": 182,
      "checkin": true,
      "checkout": false,
      "in_time": "12:17 AM",
      "out_time": null,
      "stay_time": null
    },
    "break_history_data": {
      "total_break_time": "00:00:00",
      "has_break": false,
      "break_history": {
        "today_history": []
      }
    },
    "config": {
      "is_admin": true,
      "is_hr": true,
      "is_manager": true,
      "is_face_registered": true,
      "multi_checkin": true,
      "location_bind": true,
      "is_ip_enabled": false,
      "time_wish": {
        "wish": "Good Day",
        "sub_title": "Best wishes for your day!",
        "image": "https://demo.24hourworx.com/assets/app/dashboard/good-day.svg"
      },
      "time_zone": "Europe/Tirane",
      "currency_symbol": "£",
      "currency_code": "IMP",
      "attendance_method": "N",
      "duty_schedule": {
        "start_time": {
          "hour": 10,
          "min": 0,
          "sec": 0
        },
        "end_time": {
          "hour": 18,
          "min": 0,
          "sec": 0
        },
        "list_of_start_datetime": [
          {
            "id": 1000001,
            "datetime": "2024-07-02 10:0"
          },
          {
            "id": 1000002,
            "datetime": "2024-07-03 10:0"
          },
          {
            "id": 1000003,
            "datetime": "2024-07-04 10:0"
          },
          {
            "id": 1000004,
            "datetime": "2024-07-05 10:0"
          },
          {
            "id": 1000007,
            "datetime": "2024-07-08 10:0"
          },
          {
            "id": 1000008,
            "datetime": "2024-07-09 10:0"
          },
          {
            "id": 1000009,
            "datetime": "2024-07-10 10:0"
          },
          {
            "id": 1000010,
            "datetime": "2024-07-11 10:0"
          },
          {
            "id": 1000011,
            "datetime": "2024-07-12 10:0"
          },
          {
            "id": 1000014,
            "datetime": "2024-07-15 10:0"
          },
          {
            "id": 1000015,
            "datetime": "2024-07-16 10:0"
          },
          {
            "id": 1000016,
            "datetime": "2024-07-17 10:0"
          },
          {
            "id": 1000017,
            "datetime": "2024-07-18 10:0"
          },
          {
            "id": 1000018,
            "datetime": "2024-07-19 10:0"
          },
          {
            "id": 1000021,
            "datetime": "2024-07-22 10:0"
          },
          {
            "id": 1000022,
            "datetime": "2024-07-23 10:0"
          },
          {
            "id": 1000023,
            "datetime": "2024-07-24 10:0"
          },
          {
            "id": 1000024,
            "datetime": "2024-07-25 10:0"
          },
          {
            "id": 1000025,
            "datetime": "2024-07-26 10:0"
          },
          {
            "id": 1000028,
            "datetime": "2024-07-29 10:0"
          },
          {
            "id": 1000029,
            "datetime": "2024-07-30 10:0"
          },
          {
            "id": 1000030,
            "datetime": "2024-07-31 10:0"
          }
        ],
        "list_of_end_datetime": [
          {
            "id": 2000001,
            "datetime": "2024-07-02 18:0"
          },
          {
            "id": 2000002,
            "datetime": "2024-07-03 18:0"
          },
          {
            "id": 2000003,
            "datetime": "2024-07-04 18:0"
          },
          {
            "id": 2000004,
            "datetime": "2024-07-05 18:0"
          },
          {
            "id": 2000007,
            "datetime": "2024-07-08 18:0"
          },
          {
            "id": 2000008,
            "datetime": "2024-07-09 18:0"
          },
          {
            "id": 2000009,
            "datetime": "2024-07-10 18:0"
          },
          {
            "id": 2000010,
            "datetime": "2024-07-11 18:0"
          },
          {
            "id": 2000011,
            "datetime": "2024-07-12 18:0"
          },
          {
            "id": 2000014,
            "datetime": "2024-07-15 18:0"
          },
          {
            "id": 2000015,
            "datetime": "2024-07-16 18:0"
          },
          {
            "id": 2000016,
            "datetime": "2024-07-17 18:0"
          },
          {
            "id": 2000017,
            "datetime": "2024-07-18 18:0"
          },
          {
            "id": 2000018,
            "datetime": "2024-07-19 18:0"
          },
          {
            "id": 2000021,
            "datetime": "2024-07-22 18:0"
          },
          {
            "id": 2000022,
            "datetime": "2024-07-23 18:0"
          },
          {
            "id": 2000023,
            "datetime": "2024-07-24 18:0"
          },
          {
            "id": 2000024,
            "datetime": "2024-07-25 18:0"
          },
          {
            "id": 2000025,
            "datetime": "2024-07-26 18:0"
          },
          {
            "id": 2000028,
            "datetime": "2024-07-29 18:0"
          },
          {
            "id": 2000029,
            "datetime": "2024-07-30 18:0"
          },
          {
            "id": 2000030,
            "datetime": "2024-07-31 18:0"
          }
        ]
      },
      "location_services": {
        "google": true,
        "barikoi": false
      },
      "google_api_key": null,
      "barikoi_api": {
        "key": null,
        "secret": null,
        "endpoint": null,
        "status_id": 4
      },
      "break_status": {
        "break_time": "",
        "back_time": "",
        "reason": "",
        "created_at": "",
        "updated_at": "",
        "status": "break_out",
        "diff_time": ""
      },
      "live_tracking": {
        "app_sync_time": "",
        "live_data_store_time": ""
      },
      "location_service": true,
      "app_theme": "earth",
      "is_team_lead": true,
      "notification_channels": [
        "user1Demo",
        "department1Demo"
      ],
      "multi_shift": [
        {
          "shift_id": 1,
          "name": "Morning"
        },
        {
          "shift_id": 2,
          "name": "Evening"
        },
        {
          "shift_id": 3,
          "name": "Night"
        }
      ],
      "modules": {
        "MultiBranch": false,
        "FaceAttendance": true,
        "SingleDeviceLogin": false,
        "VideoConference": true,
        "Services": true,
        "Saas": true,
        "EmployeeDocuments": true,
        "MenuPermission": false,
        "LiveTracking": true,
        "MultiTheme": true,
        "AreaBasedAttendance": true,
        "IpBasedAttendance": true,
        "QrBasedAttendance": true,
        "SelfieBasedAttendance": true,
        "OfflineBasedAttendance": true,
        "MultiShift": true
      },
      "attendance_methods": [
        {
          "title": "Face Attendance",
          "short_description": "“Face attendance” tracked through facial recognition.",
          "slug": "face_attendance",
          "image": "https://demo.24hourworx.com/images/attendance/face-attendance.png"
        },
        {
          "title": "Selfie Attendance",
          "short_description": "“Selfie attendance” individuals confirm their presence by taking a selfie.",
          "slug": "selfie_attendance",
          "image": "https://demo.24hourworx.com/images/attendance/selfie-attendance.png"
        }
      ],
      "total_notice": 0
    },
    "menus": [
      {
        "name": "Support",
        "slug": "support",
        "position": 1,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/support.png",
        "image_type": "png"
      },
      {
        "name": "Attendance",
        "slug": "attendance",
        "position": 2,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/attendance.png",
        "image_type": "png"
      },
      {
        "name": "Task",
        "slug": "task",
        "position": 3,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/task.png",
        "image_type": "png"
      },
      {
        "name": "Notice",
        "slug": "notice",
        "position": 4,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/notice.png",
        "image_type": "png"
      },
      {
        "name": "Expense",
        "slug": "expense",
        "position": 5,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/expense.png",
        "image_type": "png"
      },
      {
        "name": "Leave",
        "slug": "leave",
        "position": 6,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/leave.png",
        "image_type": "png"
      },
      {
        "name": "Approval",
        "slug": "approval",
        "position": 7,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/approval.png",
        "image_type": "png"
      },
      {
        "name": "Phonebook",
        "slug": "phonebook",
        "position": 8,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/phonebook.png",
        "image_type": "png"
      },
      {
        "name": "Visit",
        "slug": "visit",
        "position": 9,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/visit.png",
        "image_type": "png"
      },
      {
        "name": "Appointments",
        "slug": "appointments",
        "position": 10,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/appointments.png",
        "image_type": "png"
      },
      {
        "name": "Break",
        "slug": "break",
        "position": 11,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/break.png",
        "image_type": "png"
      },
      {
        "name": "Report",
        "slug": "report",
        "position": 12,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/report.png",
        "image_type": "png"
      },
      {
        "name": "Payroll",
        "slug": "payroll",
        "position": 13,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/payroll.png",
        "image_type": "png"
      },
      {
        "name": "Daily Leave",
        "slug": "daily_leave",
        "position": 14,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/daily_leave.png",
        "image_type": "png"
      },
      {
        "name": "Meeting",
        "slug": "meeting",
        "position": 15,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/meeting.png",
        "image_type": "png"
      },
      {
        "name": "Conference",
        "slug": "conference",
        "position": 16,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/conference.png",
        "image_type": "png"
      },
      {
        "name": "Chat",
        "slug": "chat",
        "position": 17,
        "icon": "https://demo.24hourworx.com/assets/appScreenIcons/chat.png",
        "image_type": "png"
      }
    ]
  }
};
