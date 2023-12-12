class Language {
  // common
  static const String common_ok = 'Ok';
  static const String common_error = 'Error';

  // drawer
  static const String dr_item_home = 'Home';
  static const String dr_item_profile = 'Profile';
  static const String dr_item_up = 'Unconfirmed appointments';
  static const String dr_item_settings = 'Settings';

  // login provider
  static const String weak_password = 'The password provided is too weak.';
  static const String acc_exist = 'The account already exists for that email.';
  static const String all_fields = 'Fields cannot be empty.';
  static const String user_not_found = 'No user found for that email.';
  static const String wrong_password = 'Wrong password provided for that user.';
  static const String invalid_cred = 'Invalid login credentials';
  static const String confirm_pass = 'New password does not match Confirm password.';

  // appointment provider
  static const String mandatory_fields = 'Need to fulfill all mandatory fields.';

  // login page
  static const String login_btn = 'Login';
  static const String login_tappable = 'Login';
  static const String login_headline = 'Welcome back';
  static const String email_hint = 'Enter email';
  static const String password_hint = 'Enter password';

  // Register page
  static const String reg_btn = 'Register';
  static const String reg_tappable_link = 'Register';
  static const String reg_tappable_text = "If you don't have an account? Register";
  static const String reg_headline = 'Create profile';
  static const String reg_email_hint = 'Enter email';
  static const String reg_password_hint = 'Enter password';
  static const String reg_confirm_password_hint = 'Confirm password';
  static const String reg_phone_hint = 'Enter phone';
  static const String reg_name_hint = 'Enter name';

  // Home page
  static const String home_headline = 'Appointments';
  static const String home_empty = 'You do not have any confirmed appointments.';

  // Home page drawer
  static const String hd_title = 'Sign out';
  static const String hd_content = 'Are you sure you want to sign out of DjudjoInk?';
  static const String hd_cancel = 'Cancel';
  static const String hd_logout_title = 'Logout';

  // Add new appointment page
  static const String ana_headline = 'Add new appointment';
  static const String ana_name_hint = 'Enter name';
  static const String ana_phone_hint = 'Enter phone number';
  static const String ana_email_hint = 'Enter email';
  static const String ana_time_hint = 'Enter time range';
  static const String ana_date_hint = 'Enter date';
  static const String ana_placement_hint = 'Placement';
  static const String ana_description_hint = 'Description';
  static const String ana_size_hint = 'Size';
  static const String ana_from_time = 'From';
  static const String ana_to_time = 'To';
  static const String ana_img = 'Upload image';
  static const String ana_button = 'Save Appointment';
  static const String ana_choose_date = 'Choose date';
  static const String ana_success_subtitle = 'You have successfully added an appointment.';
  static const String ana_success_title = 'Success!';
  static const String ana_manually_finished =
      'Here you can manually switch your appointment status.\nAppointment status will automatically be Finished (ON) if the time you add is in the past.';
  static const String ana_mandatory_title = 'Mandatory';
  static const String ana_optional_title = 'Optional';
  static const String ana_past_date_issue = 'Past Date';
  static const String ana_gender_title = 'Choose gender';
  static const String ana_past_content =
      'You cannot turn this switch OFF because selected date for appointment is in the past. So automatically Finished switch is ON.\n\nSelect date in the future to be able to turn it off.';

  // Appointment details
  static const String ad_tab_info = 'Info';
  static const String ad_tab_img = 'Images';
  static const String ad_info_headline = 'Appointment Details';
  static const String ad_info_description = 'Description';
  static const String ad_info_placement = 'Placement';
  static const String ad_info_finished = 'Appointment finished';
  static const String ad_info_approved = 'Appointment approved';

  // Notificfations
  static const String not_empty_state = 'Your notification box is empty.';
  static const String not_app_bar_title = 'Notifications';
  static const String not_headline_title = 'Unconfirmed appointments';
  static const String not_delete_slide = 'Delete';
  static const String not_info_content = 'You can delete request for appointment if you slide it to the left.';
  static const String not_headline_sub1 = 'You have ';
  static const String not_headline_sub2 =
      ' unconfirmed appointments that are waiting for your confirmation.Click on the icon to show appointments that needs to be confirmed.';

  // Edit page
  static const String ep_headline = 'Edit appointment';
  static const String ep_success_headline = 'Success';
  static const String ep_success_subtitle = 'You have successfully edit current appointment.';
  static const String ep_name_hint = 'Enter name';
  static const String ep_phone_hint = 'Enter phone number';
  static const String ep_email_hint = 'Enter email';
  static const String ep_time_hint = 'Enter time range';
  static const String ep_date_hint = 'Enter date';
  static const String ep_placement_hint = 'Placement';
  static const String ep_description_hint = 'Description';
  static const String ep_size_hint = 'Size';
  static const String ep_from_time = 'From';
  static const String ep_to_time = 'To';
  static const String ep_img = 'Upload image';
  static const String ep_button = 'Save Appointment';
  static const String ep_choose_date = 'Choose date';
  static const String ep_click_contact = 'Click to contact your client via: ';
  static const String ep_confirmation_title = 'Confirmation';
  static const String ep_confirmation_subtitle = 'You need to confirm appointment to see it on the homepage list.';
  static const String ep_manually_finished =
      'Here you can manually switch your appointment status.\nAppointment status will automatically be Finished (ON) if the time you add is in the past.';
  static const String ep_mandatory_title = 'Mandatory';
  static const String ep_optional_title = 'Optional';
  static const String ep_past_date_issue = 'Past Date';
  static const String ep_gender_title = 'Choose gender';
  static const String ep_past_content =
      'You cannot turn this switch OFF because selected date for appointment is in the past. So automatically Finished switch is ON.\n\nSelect date in the future to be able to turn it off.';

  // Profile page
  static const String pp_app_bar = 'Profile';
  static const String pp_headline = 'Tattoo artist';
  static const String pp_email_hint = 'Enter email';
  static const String pp_name_hint = 'Enter name';
  static const String pp_phone_hint = 'Enter phone';
  static const String pp_button = 'Save';
  static const String pp_success_subtitle = 'Successfully changed data';

  // Settings
  static const String s_app_bar = 'Settings';
  static const String s_headline = 'Personalize Your Mobile Settings for a DjudjoInk Experience';
  static const String s_general = 'General';
  static const String s_feedback = 'Feedback';
  static const String s_goodbye = 'Goodbye';

  // settings helper
  static const String sh_profile = 'Profile';
  static const String sh_bug = 'Report a bug';
  static const String sh_feedback = 'Send feedback';
  static const String sh_logout = 'Logout';
  static const String sh_delete = 'Delete account';
  static const String sh_change = 'Change Password';
  static const String sh_delete_title = 'Are you sure?';
  static const String sh_delete_subtitle = 'Are you sure you want to delete data from DjudjoInk?';
  static const String sh_delete_cancel = 'Cancel';

  // Change password
  static const String cp_app_bar = 'Change password';
  static const String cp_headline = 'Update Your Password for Enhanced Mobile Protection';
  static const String cp_old_hint = 'Enter old password';
  static const String cp_new_hint = 'Enter new password';
  static const String cp_confirm_hint = 'Confirm new password';
  static const String cp_button = 'Save';
  static const String cp_success_subtitle = 'Password is changed successfully';

}
