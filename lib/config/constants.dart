import 'package:flutter/services.dart';

class Constants {
  static const MethodChannel platform = MethodChannel('com.amodo.mobility');
  static const String HTML_TEXT = 'DOCTYPE';
  static const String HTML_BODY_TAG = 'window.document.body.innerText;';

  ///Permissions
  static const String LOCATION_PERMISSION_TAG = 'Location';
  static const String ACTIVITY_PERMISSION_TAG = 'Motion';
  static const String STORAGE_PERMISSION_TAG = 'Storage';
  static const String BLUETOOTH_PERMISSION_TAG = 'Bluetooth';
  static const String CAMERA_PERMISSION_TAG = 'Camera';
  static const String NOTIFICATION_PERMISSION_TAG = 'Notification';

  ///Database tables
  static const String USER_MODEL_TABLE = 'UserModelTable';
  static const String USER_CONSENT_MODEL_TABLE = 'UserConsentModelTable';
  static const String CONSENT_MODEL_TABLE = 'ConsentModelTable';
  static const String TRIPS_TABLE = 'TripsTable';
  static const String TRACKS_TABLE = 'TracksTable';
  static const String USER_MESSAGES_TABLE = 'UserMessagesTable';
  static const String ACHIEVEMENTS_TABLE = 'AchievementsTable';
  static const String NEWS_TABLE = 'NewsTable';
  static const String MONTH_DISCOUNTS_TABLE = 'MonthDiscountsTable';
  static const String DRIVING_STATS_TABLE = 'DrivingStatsTable';
  static const String CHALLENGES_TABLE = 'ChallengesTable';
  static const String PRIZES_TABLE = 'PrizesTable';
  static const String VOUCHERS_TABLE = 'VouchersTable';

}
