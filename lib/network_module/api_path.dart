/// ApiPath
///
/// helper class in which we define paths that
/// we concatenate to our base url
enum ApiPath { image_api }

mixin ApiPathHelper {
  static String getValue(ApiPath path, {String concatValue = ''}) {
    switch (path) {
      case ApiPath.image_api:
        return 'https://djudjoink-api.onrender.com/image-upload';
      default:
        return '';
    }
  }
}
