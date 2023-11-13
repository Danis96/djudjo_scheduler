// import 'package:sqflite/sqflite.dart';
//
// import '../../../config/constants.dart';
// import '../../models/achievement_model.dart';
// import '../database_helper.dart';
//
// class DBAchievementRepo {
//   DBAchievementRepo() {
//     databaseHelper = DatabaseHelper();
//   }
//
//   DatabaseHelper? databaseHelper;
//
//   Future<int> insertAchievementModel(Achievement model) async {
//     int result = 0;
//     final Database db = await databaseHelper!.database;
//     final int? count = Sqflite.firstIntValue(await db.rawQuery(
//         'SELECT COUNT(*) FROM ${Constants.ACHIEVEMENTS_TABLE} WHERE achievement_id = ?',
//         <int>[model.achievementID!]));
//     if (count == 0) {
//       result = await db.insert(Constants.ACHIEVEMENTS_TABLE, model.dbToJson());
//     } else {
//       result = await db.update(Constants.ACHIEVEMENTS_TABLE, model.dbToJson(),
//           where: 'achievement_id = ?', whereArgs: <int>[model.achievementID!]);
//     }
//
//     return result;
//   }
//
//   Future<List<Achievement>> fetchAchievements() async {
//     final List<Achievement> listAchievementsModels = <Achievement>[];
//     final Database db = await databaseHelper!.database;
//     final List<Map<String, dynamic>> result =
//         await db.query(Constants.ACHIEVEMENTS_TABLE);
//
//     result.map((Map<String, dynamic> e) {
//       listAchievementsModels.add(Achievement.dbFromJson(e));
//     }).toList();
//
//     return listAchievementsModels;
//   }
// }
