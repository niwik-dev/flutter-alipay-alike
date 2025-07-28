import '../apis/tikhub_api.dart';

import 'apis/model/response/fetch_home_feed.dart';

main() async {
  FetchHomeFeed result = await TikHubApi.getDouYinHomeFeed();
  print(result.awemeList!.first.awemeId!);
  // var videoComments = await TikHubApi.getDouYinVideoComments(awemeId: '7477202773998718247');
  // print(videoComments.toJson());
}