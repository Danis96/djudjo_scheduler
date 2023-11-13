import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../../config/constants.dart';

class DatabaseHelper {
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    if (_databaseHelper != null) {
      return _databaseHelper!;
    }
    return DatabaseHelper();
  }

  DatabaseHelper._createInstance();

  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = p.join(directory.path, 'tower.db');

    final Database database = await openDatabase(
      path,
      version: _scripts.length,
      onCreate: (Database db, int version) async {
        print('DB created');
        for (int i = 1; i <= _scripts.length; i++) {
          for (int j = 0; j < _scripts[i]!.length; j++) {
            await db.execute(_scripts[i]![j]);
          }
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print('DB upgraded');
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          for (int j = 0; j < _scripts[i]!.length; j++) {
            await db.execute(_scripts[i]![j]);
          }
        }
      },
      onOpen: (Database db) {
        print('DB opened');
      },
    );
    return database;
  }

  Future<void> deleteDb(Database? db) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = p.join(directory.path, 'tower.db');
    db = null;
    _database = null;
    await deleteDatabase(path);
  }
}

// Make sure versions are sequential starting with 1
// ignore: always_specify_types
const Map<int, List<String>> _scripts = {
  1: <String>[
    '''
       CREATE TABLE IF NOT EXISTS ${Constants.USER_MODEL_TABLE} (
              driver_id INTEGER PRIMARY KEY,
              first_name TEXT,
              last_name TEXT,
              email TEXT,
              driver_token TEXT,
              vehicles TEXT,
              consent_ids_not_reviewed TEXT,
              finished_onboarding INTEGER,
              extra TEXT,
              profile TEXT,
              discount REAL,
              max_discount INTEGER,
              is_tester INTEGER
            )
     ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.CONSENT_MODEL_TABLE} (
              id INTEGER PRIMARY KEY,
              title TEXT,
              text TEXT,
              give_label TEXT,
              revoke_label TEXT,
              info_popup_title TEXT,
              info_popup_text TEXT,
              info_popup_button_label TEXT,
              mandatory_popup_title TEXT,
              mandatory_popup_text TEXT,
              mandatory_popup_button_label TEXT,
              related_android_permissions TEXT,
              related_ios_permissions TEXT,
              slug TEXT,
              image TEXT,
              info_popup_image TEXT,
              is_mandatory INTEGER,
              mandatory_popup_image TEXT,
              visible_from TEXT,
              visible_until TEXT,
              isGiven INTEGER,
              shouldCallAPI INTEGER
            )
    ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.USER_CONSENT_MODEL_TABLE} (
              id INTEGER PRIMARY KEY,
              user INTEGER,
              consent INTEGER,
              is_given INTEGER
            )
    ''',
    '''
     CREATE TABLE IF NOT EXISTS ${Constants.TRIPS_TABLE} (
              id INTEGER PRIMARY KEY,
              name TEXT,
              start_time TEXT,
              data TEXT,
              scoring TEXT,
              alerts_counts TEXT,
              processed INTEGER,
              analysis_error INTEGER
            )
    ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.TRACKS_TABLE} (
              id INTEGER PRIMARY KEY,
              matched TEXT
            )
    ''',
    '''
            CREATE TABLE IF NOT EXISTS ${Constants.USER_MESSAGES_TABLE} (
              order_id INTEGER PRIMARY KEY,
              id INTEGER,
              sent_at REAL,
              read_at REAL,
              deleted_at REAL,
              archived_at REAL,
              email_sent INTEGER,
              push_notification_sent INTEGER,
              sms_sent INTEGER,
              message TEXT,
              isDeleted INTEGER,
              isRead INTEGER
             )
     ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.ACHIEVEMENTS_TABLE} (
              achievement_id INTEGER PRIMARY KEY,
              name TEXT,
              user_lang TEXT,
              short_description TEXT,
              share_description TEXT,
              unlocked_share_description TEXT,
              is_shareable INTEGER,
              description TEXT,
              terms_url TEXT,
              reward_points INTEGER,
              progress REAL,
              is_unlocked INTEGER,
              unlocked_at TEXT,
              seen_at TEXT,
              achievement_color TEXT,
              max_count INTEGER,
              count INTEGER,
              categories TEXT,
              achievement_order INTEGER,
              segments TEXT,
              thumbnail TEXT,
              thumbnail_small TEXT,
              locked_thumbnail TEXT,
              locked_thumbnail_small TEXT,
              share_thumbnail TEXT,
              unlocked_at_epoch REAL,
              seen_at_epoch REAL,
              isHomepage INTEGER
          )    
    ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.NEWS_TABLE} (
              order_id INTEGER PRIMARY KEY,
              news_id INTEGER,
              title TEXT,
              main_text TEXT,
              lead_text TEXT,
              link TEXT,
              deep_link TEXT,
              is_visible_outside_segment INTEGER,
              date_created TEXT,
              publish_at TEXT,
              header_image TEXT,
              attachment TEXT,
              category INTEGER,
              segment INTEGER,
              epoch_created REAL
              
            )
    ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.DRIVING_STATS_TABLE} (
              id INTEGER PRIMARY KEY,
              trip_count INTEGER,
              distance REAL,
              duration REAL,
              idle_time REAL,
              max_speed REAL,
              overspeeding_time REAL,
              overspeeding_ratio REAL,      
              score REAL,
              focus_score REAL,
              days REAL       
            )
    ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.CHALLENGES_TABLE} (
              order_id INTEGER PRIMARY KEY,
              id INTEGER,
              name TEXT,
              description TEXT,
              summary TEXT,
              large_image TEXT,
              days_remaining INTEGER,
              participants INTEGER,
              score REAL,
              max_value REAL,
              is_joinable INTEGER,
              started INTEGER,      
              ended INTEGER,
              teams TEXT,
              user TEXT,
              results TEXT       
            )
    ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.PRIZES_TABLE} (
              order_id INTEGER PRIMARY KEY,
              reward_contest_id INTEGER,
              title TEXT,
              description TEXT,
              extra_info TEXT,
              image TEXT,
              number_of_rewards INTEGER,
              number_of_unlocked_achievements INTEGER,
              users_participating INTEGER,
              is_active INTEGER,      
              can_participate INTEGER,
              already_participates INTEGER,
              terms_url TEXT,
              contest_type TEXT,
              condition_text TEXT,
              active_from TEXT,
              conditions TEXT       
            )
    ''',
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.VOUCHERS_TABLE} (
              order_id INTEGER PRIMARY KEY,
              promocode_request_id INTEGER,
              code TEXT,
              requested_at REAL,
              valid_until REAL,
              isDeleted INTEGER,
              promocode TEXT       
            )
    ''',
    '''
     CREATE TABLE IF NOT EXISTS ${Constants.MONTH_DISCOUNTS_TABLE} (
              id INTEGER PRIMARY KEY,
              list TEXT
            )
    '''
  ],
  2: <String>[
    '''
      DROP TABLE IF EXISTS ${Constants.USER_MODEL_TABLE}
    '''
  ],
  3: <String>[
    '''
    CREATE TABLE IF NOT EXISTS ${Constants.USER_MODEL_TABLE} (
        driver_id INTEGER PRIMARY KEY,
        first_name TEXT,
        last_name TEXT,
        email TEXT,
        driver_token TEXT,
        vehicles TEXT,
        consent_ids_not_reviewed TEXT,
        finished_onboarding INTEGER,
        extra TEXT,
        profile TEXT,
        discount REAL,
        max_discount INTEGER,
        is_tester INTEGER,
        segments TEXT
    )
    '''
  ],
};
