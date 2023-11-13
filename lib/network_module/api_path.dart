/// ApiPath
///
/// helper class in which we define paths that
/// we concatenate to our base url
enum ApiPath {
  login_user,
  logout,
  register_email,
  new_password_reset,
  set_password,
  change_password,
  consents,
  userConsents,
  setUserConsent,
  userData,
  onboarding,
  drivers_achievement,
  challenges,
  vouchers,
  challenges_join,
  challenges_top_list,
  prizes,
  reward_participate,
  news,
  inbox,
  delete_message,
  mark_message_read,
  deleteAccount,
  delete_image,
  upload_image,
  driver_trips,
  driver_trips_tracks,
  stats,
  discounts,
  push_notifications,
  voucher_delete,
  suggestion_tips,
  vehicle_make,
  fuel_types,
  vehicle_info,
  trip_details,
  co2_monthly_stats,
  co2_yearly_stats,
  co2_ranking,
}

mixin ApiPathHelper {
  static String getValue(
    ApiPath path, {
    String concatValue = '',
    String concatValue1 = '',
  }) {
    switch (path) {
      case ApiPath.login_user:
        return 'api/mobile/login/';
      case ApiPath.logout:
        return 'api/mobile/logout/';
      case ApiPath.register_email:
        return 'accounts/api/register/';
      case ApiPath.new_password_reset:
        return 'api/mobile/new_password_reset/';
      case ApiPath.set_password:
        return 'api/mobile/set_password/';
      case ApiPath.consents:
        return 'api/consents/';
      case ApiPath.userConsents:
        return 'api/user/consents/state/';
      case ApiPath.setUserConsent:
        return 'api/user/consents/';
      case ApiPath.userData:
        return 'api/mobile/user/';
      case ApiPath.onboarding:
        return 'api/onboarding/';
      case ApiPath.drivers_achievement:
        return 'api/drivers/achievements/';
      case ApiPath.challenges:
        return 'api/challenges/';
      case ApiPath.vouchers:
        return 'api/users/promocode_requests/';
      case ApiPath.voucher_delete:
        return 'api/users/promocode_requests/$concatValue/delete/';
      case ApiPath.challenges_join:
        return 'api/challenges/{id}/join/';
      case ApiPath.challenges_top_list:
        return 'api/challenges/top_list/';
      case ApiPath.prizes:
        return 'api/rewards/contest/';
      case ApiPath.reward_participate:
        return 'api/rewards/contest/$concatValue/participate/';
      case ApiPath.news:
        return 'api/insurance/news/';
      case ApiPath.inbox:
        return 'api/user/message/';
      case ApiPath.delete_message:
        return 'api/user/message/$concatValue/delete/';
      case ApiPath.mark_message_read:
        return 'api/user/message/$concatValue/read/';
      case ApiPath.change_password:
        return 'api/mobile/password_change/';
      case ApiPath.deleteAccount:
        return 'api/accounts/$concatValue/';
      case ApiPath.upload_image:
        return 'api/drivers/account/upload_image/';
      case ApiPath.driver_trips:
        return 'api/mobile/trips/';
      case ApiPath.driver_trips_tracks:
        return 'api/mobile/trips/$concatValue/alltracks/';
      case ApiPath.stats:
        return 'api/stats/mobile/tsw/';
      case ApiPath.discounts:
        return 'api/discounts/monthly/';
      case ApiPath.push_notifications:
        return 'api/mobile/notification_token/';
      case ApiPath.suggestion_tips:
        return 'api/suggestions/tips/';
      case ApiPath.vehicle_make:
        return 'api/vehicles/manufacturers/';
      case ApiPath.fuel_types:
        return 'api/vehicles/fuel_type/';
      case ApiPath.vehicle_info:
        return 'api/drivers/vehicles/$concatValue/';
      case ApiPath.trip_details:
        return 'api/mobile/trips/$concatValue/';
      case ApiPath.co2_monthly_stats:
        return '/api/co2/stats/monthly/';
      case ApiPath.co2_yearly_stats:
        return '/api/co2/stats/yearly/';
        case ApiPath.co2_ranking:
        return '/api/co2/ranking';
      default:
        return '';
    }
  }
}
