
class Language {
  // common
  static const String common_ok = 'Ok';
  static const String common_error = 'Error';

  // login provider
  static const String weak_password = 'The password provided is too weak.';
  static const String acc_exist = 'The account already exists for that email.';
  static const String all_fields = 'Fields cannot be empty.';
  static const String user_not_found = 'No user found for that email.';
  static const String wrong_password = 'Wrong password provided for that user.';
  static const String invalid_cred = 'Invalid login credentials';

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
  static const String ana_success_title = 'You have successfully added an appointment.';
  static const String ana_manually_finished = 'Here you can manually switch your appointment status.\nAppointment status will automatically be Finished (ON) if the time you add is in the past.';
  static const String ana_mandatory_title = 'Mandatory';
  static const String ana_optional_title = 'Optional';
  static const String ana_past_date_issue = 'Past Date';
  static const String ana_gender_title = 'Choose gender';
  static const String ana_past_content = 'You cannot turn this switch OFF because selected date for appointment is in the past. So automatically Finished switch is ON.\n\nSelect date in the future to be able to turn it off.';


  // Appointment details
  static const String ad_tab_info = 'Info';
  static const String ad_tab_img = 'Images';
  static const String ad_info_headline = 'Appointment Details';
  static const String ad_info_description = 'Description';



}