import 'package:dio/dio.dart';
import '../../apis/model/response/fetch_home_feed.dart';
import '../../apis/model/response/fetch_video_comments.dart';

import 'model/response/explore_video_data.dart';

class TikHubApi {
  static const String baseUrl = "https://api.tikhub.io";

  static const String apiKey = "jbsMUmxMnmEkkxUizkawwmUo4ygtoaXJvIFuwBei5EVS3UQ2bOwomkeGJg==";

  static bool isClientInitialized = false;
  static late Dio httpClient;

  static Dio getClient(){
    if (!isClientInitialized) {
      httpClient = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          responseType: ResponseType.json,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            "Authorization": "Bearer $apiKey",
          },
        ),
      );
    }
    return httpClient;
  }

  static Future<Response> get(String uri, {Map<String, dynamic>? queryParameters}) async {
    final response = await getClient().get(
      '$baseUrl$uri',
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Authorization": "Bearer $apiKey",
        },
      ),
    );
    return response;
  }

  static Future<ExploreVideoData> getTikTokExploreVideoData({String categoryType='120', int count=16}) async {
    final response = await get('/api/v1/tiktok/web/fetch_explore_post?categoryType=$categoryType&count=$count');
    Map<String,dynamic> responseData = response.data;
    if (responseData['code'] == 200) {
      var data = responseData['data'];
      return ExploreVideoData.fromJson(data);
    } else {
      throw Exception(responseData['message']);
    }
  }

  static Future<FetchHomeFeed> getDouYinHomeFeed({
    int count = 1,
    int freshIndex = 1,
  }) async {
    final response = await get('/api/v1/douyin/web/fetch_home_feed',queryParameters: {
      'count': count,
      'fresh_index': freshIndex,
    });
    Map<String,dynamic> responseData = response.data;
    if (responseData['code'] == 200) {
      var data = responseData['data'];
      return FetchHomeFeed.fromJson(data);
    } else {
      throw Exception(responseData['message']);
    }
  }

  static Future<FetchVideoComments> getDouYinVideoComments({
    required String awemeId,
    int count = 10,
    int cursor = 0,
  }) async {
    final response = await get('/api/v1/douyin/web/fetch_video_comments',queryParameters: {
      'aweme_id': awemeId,
      'count': count,
      'cursor': cursor,
    });
    Map<String,dynamic> responseData = response.data;
    if (responseData['code'] == 200) {
      final data = responseData['data'];
      return FetchVideoComments.fromJson(data);
    }else{
      throw Exception(responseData['message']);
    }
  }
}