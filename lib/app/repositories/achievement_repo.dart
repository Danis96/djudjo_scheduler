import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';


class AchievementRepository {
  // Future<Achievements> fetchAchievements({bool homepage = false}) async {
  //
  //   final Map<String, String> params = <String, String>{
  //     'homepage': homepage == false ? '' : 'true',
  //   };
  //   final Map<String, String> header =
  //       await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
  //   final dynamic response = await HTTPClient.instance.fetchData(
  //       ApiPathHelper.getValue(ApiPath.drivers_achievement), header,
  //       params: homepage != false ? params : null);
  //   print('Response: $response');
    // final Map<String, dynamic> responseList = <String, dynamic>{
    //   'list': response,
    // };
    // return Achievements.fromJson(responseList);
  // }
}
