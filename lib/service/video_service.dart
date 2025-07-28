import '../apis/model/response/fetch_video_comments.dart';
import '../apis/tikhub_api.dart';
import '../model/video_info.dart';
import '../model/comment_info.dart';

class VideoService {
  // static Future<List<VideoInfo>> getTikTokVideo() async {
  //   var exploreVideoData = await TikHubApi.getTikTokExploreVideoData();
  //   List<VideoInfo> videoList = [];
  //   exploreVideoData.itemList?.forEach((item) {
  //     var videoUrl = item.video?.bitrateInfo?.first.playAddr?.urlList?.last;
  //     var authorThumbUrl = item.author?.avatarThumb;
  //     if (videoUrl == null || authorThumbUrl == null) {
  //       return;
  //     }
  //     videoList.add(
  //       VideoInfo(
  //         videoUrl: videoUrl,
  //         authorThumbUrl: authorThumbUrl
  //       )
  //     );
  //   });
  //   return videoList;
  // }

  static Future<List<VideoInfo>> getDouYinVideo() async {
    final fetchHomeFeed = await TikHubApi.getDouYinHomeFeed();
    List<VideoInfo> videoList = [];
    fetchHomeFeed.awemeList?.forEach((item){
      final videoId = item.awemeId;
      final videoUrl = item.video?.bitRate?.first.playAddr?.urlList?.last;
      final authorThumbUrl = item.author?.avatarThumb?.urlList?.first;
      final authorNickName = item.author?.nickname;
      final caption = item.caption;
      final description = item.desc;
      final commentCount = item.statistics?.commentCount;
      final diggCount = item.statistics?.diggCount;
      final shareCount = item.statistics?.shareCount;
      final collectCount = item.statistics?.collectCount;
      final playCount = item.statistics?.playCount;
      final createdTime = item.createTime;

      videoList.add(
        VideoInfo(
          videoId: videoId,
          videoUrl: videoUrl,
          authorThumbUrl: authorThumbUrl,
          authorNickName: authorNickName,
          caption: caption,
          description: description,
          commentCount: commentCount,
          diggCount: diggCount,
          shareCount: shareCount,
          collectCount: collectCount,
          playCount: playCount,
          createTime: createdTime,
        )
      );
    });
    return videoList;
  }

  static Future<List<CommentInfo>> getDouYinVideoComments({
    required String videoId,
    int count = 10,
    int cursor = 0,
  }) async {
    final fetchVideoComments = await TikHubApi.getDouYinVideoComments(
      awemeId: videoId,
      count: count,
      cursor: cursor,
    );
    List<CommentInfo> commentsList = [];
    fetchVideoComments.comments?.forEach((comment){
      commentsList.add(
        CommentInfo(
          commentId: comment.cid,
          commentText: comment.text,
          userId: comment.user?.uid,
          userName: comment.user?.nickname,
          userAvatar: comment.user?.avatarThumb?.urlList?.last,
          createTime: comment.createTime,
          diggCount: comment.diggCount,
          isAuthorDigged: comment.isAuthorDigged,
          ipLabel: comment.ipLabel,
        )
      );
    });
    return commentsList;
  }
}