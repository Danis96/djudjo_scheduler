// import 'dart:convert';
//
// import 'package:json_annotation/json_annotation.dart';
//
// part 'achievement_model.g.dart';
//
// @JsonSerializable()
// class Achievement {
//   Achievement({
//     this.nameResponse,
//     this.progress,
//     this.achievementColor,
//     this.achievementID,
//     this.achievementOrder,
//     this.categories,
//     this.count,
//     this.description,
//     this.isShereable,
//     this.isUnlocked,
//     this.lockedThumbnail,
//     this.lockedThumbnailSmall,
//     this.maxCount,
//     this.rewardPoints,
//     this.seenAt,
//     this.seenAtEpoh,
//     this.segments,
//     this.shareDescription,
//     this.shareThumbnail,
//     this.shortDescription,
//     this.termsUrl,
//     this.thumbnail,
//     this.thumbnailSmall,
//     this.unlockAtEpoh,
//     this.unlockedAt,
//     this.unlockedSharedDescription,
//     this.userLang,
//     this.isHomepage = false,
//   });
//
//   factory Achievement.fromJson(dynamic json) =>
//       _$AchievementFromJson(json as Map<String, dynamic>);
//   Map<String, dynamic> toJson() => _$AchievementToJson(this);
//
//   static Achievement dbFromJson(dynamic json) {
//     final int jsonIsShereable = json['is_shareable'] as int;
//     final int jsonIsUnlocked = json['is_unlocked'] as int;
//     final int jsonIsHomepage = json['isHomepage'] as int;
//     final String jsonCategories = json['categories'] as String;
//     final String jsonSegments = json['segments'] as String;
//
//     return Achievement(
//       achievementID: json['achievement_id'] as int,
//       userLang: json['user_lang'] as String,
//       nameResponse: json['name'] as String,
//       shortDescription: json['short_description'] as String,
//       shareDescription: json['share_description'] as String,
//       unlockedSharedDescription: json['unlocked_share_description'] as String,
//       description: json['description'] as String,
//       termsUrl: json['terms_url'] as String,
//       rewardPoints: json['reward_points'] as int,
//       progress: json['progress'] as double,
//       unlockedAt: json['unlocked_at'] as String,
//       seenAt: json['seen_at'] as String,
//       achievementColor: json['achievement_color'] as String,
//       maxCount: json['max_count'] as int,
//       count: json['count'] as int,
//       achievementOrder: json['achievement_order'] as int,
//       thumbnail: json['thumbnail'] as String,
//       thumbnailSmall: json['thumbnail_small'] as String,
//       lockedThumbnail: json['locked_thumbnail'] as String,
//       lockedThumbnailSmall: json['locked_thumbnail_small'] as String,
//       shareThumbnail: json['share_thumbnail'] as String,
//       unlockAtEpoh: json['unlocked_at_epoch'] as double,
//       seenAtEpoh: json['seen_at_epoch'] as double,
//       isShereable: jsonIsShereable != 0,
//       isUnlocked: jsonIsUnlocked != 0,
//       categories: jsonCategories.isNotEmpty
//           ? (jsonDecode(jsonCategories) as List<dynamic>).cast<String>()
//           : <String>[],
//       segments: jsonSegments.isNotEmpty
//           ? (jsonDecode(jsonSegments) as List<dynamic>).cast<int>()
//           : <int>[],
//       isHomepage: jsonIsHomepage != 0,
//     );
//   }
//
//   Map<String, dynamic> dbToJson() {
//     final Map<String, dynamic> map = <String, dynamic>{
//       'achievement_id': achievementID ?? 0,
//       'user_lang': userLang ?? 'en',
//       'name': name,
//       'short_description': shareDescription ?? '',
//       'share_description': shareDescription ?? '',
//       'unlocked_share_description': unlockedSharedDescription ?? '',
//       'description': description ?? '',
//       'terms_url': termsUrl ?? '',
//       'reward_points': rewardPoints ?? 0,
//       'progress': progress ?? 0.0,
//       'unlocked_at': unlockedAt ?? '',
//       'seen_at': seenAt ?? '',
//       'achievement_color': achievementColor ?? '',
//       'max_count': maxCount ?? 0,
//       'count': count ?? 0,
//       'achievement_order': achievementOrder ?? 0,
//       'thumbnail': thumbnail ?? '',
//       'thumbnail_small': thumbnailSmall ?? '',
//       'locked_thumbnail': lockedThumbnail ?? '',
//       'locked_thumbnail_small': lockedThumbnailSmall ?? '',
//       'share_thumbnail': shareThumbnail ?? '',
//       'unlocked_at_epoch': unlockAtEpoh ?? 0.0,
//       'seen_at_epoch': seenAtEpoh ?? 0.0
//     };
//
//     if (categories != null) {
//       map['categories'] = jsonEncode(categories);
//     }
//     if (isShereable != null) {
//       map['is_shareable'] = isShereable! ? 1 : 0;
//     }
//     if (isUnlocked != null) {
//       map['is_unlocked'] = isUnlocked! ? 1 : 0;
//     }
//
//     if (segments != null) {
//       map['segments'] = jsonEncode(segments);
//     }
//
//     if (isHomepage != null) {
//       map['isHomepage'] = isHomepage! ? 1 : 0;
//     }
//
//     return map;
//   }
//
//   @JsonKey(name: 'user_lang', defaultValue: '')
//   String? userLang;
//   @JsonKey(name: 'name', defaultValue: '')
//   String? nameResponse;
//   @JsonKey(name: 'short_description', defaultValue: '')
//   String? shortDescription;
//   @JsonKey(name: 'share_description', defaultValue: '')
//   String? shareDescription;
//   @JsonKey(name: 'unlocked_share_description', defaultValue: '')
//   String? unlockedSharedDescription;
//   @JsonKey(name: 'is_shareable', defaultValue: false)
//   bool? isShereable;
//   @JsonKey(defaultValue: '')
//   String? description;
//   @JsonKey(name: 'terms_url', defaultValue: '')
//   String? termsUrl;
//   @JsonKey(name: 'reward_points', defaultValue: 0)
//   int? rewardPoints;
//   @JsonKey(defaultValue: 0.0)
//   double? progress;
//   @JsonKey(name: 'is_unlocked', defaultValue: false)
//   bool? isUnlocked;
//   @JsonKey(name: 'unlocked_at', defaultValue: '')
//   String? unlockedAt;
//   @JsonKey(name: 'seen_at', defaultValue: '')
//   String? seenAt;
//   @JsonKey(name: 'achievement_color', defaultValue: '')
//   String? achievementColor;
//   @JsonKey(name: 'max_count', defaultValue: 0)
//   int? maxCount;
//   @JsonKey(defaultValue: 0)
//   int? count;
//   @JsonKey(defaultValue: <String>[])
//   List<String>? categories;
//   @JsonKey(name: 'achievement_order', defaultValue: 0)
//   int? achievementOrder;
//   @JsonKey(name: 'achievement_id', defaultValue: 0)
//   int? achievementID;
//   @JsonKey(defaultValue: <int>[])
//   List<int>? segments;
//   @JsonKey(defaultValue: '')
//   String? thumbnail;
//   @JsonKey(name: 'thumbnail_small', defaultValue: '')
//   String? thumbnailSmall;
//   @JsonKey(name: 'locked_thumbnail', defaultValue: '')
//   String? lockedThumbnail;
//   @JsonKey(name: 'locked_thumbnail_small', defaultValue: '')
//   String? lockedThumbnailSmall;
//   @JsonKey(name: 'share_thumbnail', defaultValue: '')
//   String? shareThumbnail;
//   @JsonKey(name: 'unlocked_at_epoch', defaultValue: 0.0)
//   double? unlockAtEpoh;
//   @JsonKey(name: 'seen_at_epoch', defaultValue: 0.0)
//   double? seenAtEpoh;
//   @JsonKey(defaultValue: false, includeIfNull: true)
//   bool? isHomepage;
// }
