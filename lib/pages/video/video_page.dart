import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../model/comment_info.dart';
import '../../service/video_service.dart';
import '../../model/video_info.dart';
import '../../utils/format.dart';

class VideoSideButtons extends StatelessWidget {
  const VideoSideButtons({
    super.key,
    required this.videoInfo,
    required this.onOpenComment,
  });

  final VideoInfo videoInfo;

  final dynamic Function() onOpenComment;

  @override
  Widget build(BuildContext context){
    const double avatarSize = 52.0;
    const double buttonSize = 46.0;
    const double spacing = 16.0;

    return Container(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: ClipOval(
                child: Image.network(
                  videoInfo.authorThumbUrl!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: spacing),
            const SizedBox(
              width: buttonSize,
              height: buttonSize,
              child: Icon(
                Icons.thumb_up_rounded,
                color: Colors.white,
                size: buttonSize-10,
              ),
            ),
            TDText(
                videoInfo.diggCount==null?'点赞':FormatUtils.formatNumber(videoInfo.diggCount),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                )
            ),
            const SizedBox(height: spacing),
            GestureDetector(
              onTap: onOpenComment,
              child: const SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: Icon(
                  Icons.chat_bubble_rounded,
                  color: Colors.white,
                  size: buttonSize-10,
                ),
              ),
            ),
            TDText(
              videoInfo.commentCount==null?'评论':FormatUtils.formatNumber(videoInfo.commentCount),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: spacing),
            const SizedBox(
              width: buttonSize,
              height: buttonSize,
              child: Icon(
                Icons.star_rounded,
                color: Colors.white,
                size: buttonSize,
              ),
            ),
            TDText(
              videoInfo.collectCount==null?'收藏':FormatUtils.formatNumber(videoInfo.collectCount),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: spacing),
            const SizedBox(
              width: buttonSize,
              height: buttonSize,
              child: Icon(
                Icons.share,
                color: Colors.white,
                size: buttonSize-10,
              ),
            ),
            TDText(
              videoInfo.shareCount==null?'分享':FormatUtils.formatNumber(videoInfo.shareCount),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        )
    );
  }
}

class VideoPage extends ConsumerStatefulWidget {
  const VideoPage({super.key});

  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage>{

  Player player = Player();
  Duration playProgress = const Duration(milliseconds: 0);

  List<VideoInfo> videoInfoList = [];
  bool isVideoLoadFinished = false;
  int currentVideoIndex = 0;

  List<CommentInfo> commentInfoList = [];
  bool isCommentFirstLoad = false;
  bool isCommentOpen = false;
  bool isCommentLoading = false;
  int commentPageNum = 0;
  final int commentPageSize = 10;
  double videoCommentHeight = 0;

  late VideoController videoController = VideoController(player);
  late PageController videoPageController = PageController();
  late ScrollController commentScrollController = ScrollController();

  Future<void> loadNewVideo() async {
    List<VideoInfo> fetchedVideoInfoList = await VideoService.getDouYinVideo();
    for (VideoInfo videoInfo in fetchedVideoInfoList) {
      if(videoInfo.videoUrl == null || videoInfo.authorThumbUrl == null) {
        loadNewVideo();
      }else{
        setState(() {
          videoInfoList.add(videoInfo);
        });
      }
    }
  }

  Future<void> initComment() async {
    if(!isCommentFirstLoad){
      List<CommentInfo> fetchedCommentInfoList = await VideoService.getDouYinVideoComments(
        videoId: videoInfoList[currentVideoIndex].videoId!,
        cursor: 0,
        count: commentPageSize,
      );
      setState(() {
        commentInfoList.addAll(fetchedCommentInfoList);
        isCommentFirstLoad = true;
        ++commentPageNum;
      });
    }
  }

  void loadNewComment() {
    setState(() {
      isCommentLoading = true;
    });

    VideoService.getDouYinVideoComments(
      videoId: videoInfoList[currentVideoIndex].videoId!,
      cursor: commentPageNum,
      count: commentPageSize,
    ).then((List<CommentInfo> fetchedCommentInfoList){
      setState(() {
        commentInfoList.addAll(fetchedCommentInfoList);
        ++commentPageNum;
        isCommentLoading = false;
      });
    });
  }

  Future<void> onPageGoto(int index) async {
    setState(() {
      currentVideoIndex = index;
      commentInfoList.clear();
      isCommentFirstLoad = false;
    });

    if(isVideoLoadFinished){
      player.open(Media(videoInfoList[index].videoUrl!));
    }
    if(index == videoInfoList.length-1){
      await loadNewVideo();
    }
  }

  void openComment(){
    setState(() {
      isCommentOpen = true;
      videoCommentHeight = 640;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if(!isCommentFirstLoad){
        initComment();
      }
    });
  }

  void closeComment(){
    setState(() {
      videoCommentHeight = 0;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          isCommentOpen = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();

    loadNewVideo().then((value){
      if (videoInfoList.length<=1) {
        loadNewVideo();
      }

      initComment();

      player.open(Media(
          videoInfoList[0].videoUrl!
      ));

      setState(() {
        isVideoLoadFinished = true;
      });
    });

    commentScrollController.addListener((){
      if(commentScrollController.position.pixels == commentScrollController.position.maxScrollExtent){
        loadNewComment();
      }
    });

    player.stream.position.listen((event) {
      setState(() {
        playProgress = player.state.position;
      });
    });

    player.stream.completed.listen((event) async {
      if(event){
        await loadNewVideo();
        videoPageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    videoPageController.dispose();
    videoController.notifier.dispose();
    commentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.black,
      child: isVideoLoadFinished?
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: PageView.builder(
              hitTestBehavior: HitTestBehavior.opaque,
              controller: videoPageController,
              itemCount: videoInfoList.length,
              scrollDirection: Axis.vertical,
              allowImplicitScrolling: false,
              onPageChanged: (index) async {
                onPageGoto(index);
              },
              itemBuilder: (context, index){
                return Stack(
                  children: [
                    Video(
                      controller: videoController,
                      controls: (state){
                        return Stack(
                          children: [
                            Positioned.fill(
                              top:32,
                              bottom: 32,
                              child: GestureDetector(
                                onTap: (){
                                  if(isCommentOpen){
                                    closeComment();
                                  }else{
                                    if(player.state.playing){
                                      player.pause();
                                    }else{
                                      player.play();
                                    }
                                  }
                                },
                              )
                            ),
                            Positioned(
                              bottom: 0,
                              child: SizedBox(
                                height: 18,
                                width: MediaQuery.of(context).size.width,
                                child: SliderTheme(
                                  data: const SliderThemeData(
                                    trackHeight: 3,
                                    thumbColor: Colors.white,
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 0,
                                      disabledThumbRadius: 0,
                                    ),
                                    activeTrackColor: Colors.white,
                                    inactiveTrackColor: Colors.grey,
                                    valueIndicatorColor: Colors.white,
                                  ),
                                  child: Builder(
                                    builder: (context){
                                      if (player.state.duration.inSeconds == 0) {
                                        return const SizedBox.shrink();
                                      }

                                      return Slider(
                                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                                        thumbColor: Colors.white,
                                        min: 0, max: 1,
                                        value: playProgress.inSeconds / player.state.duration.inSeconds,
                                        onChanged: (value){
                                          Future.delayed(const Duration(milliseconds: 500), () {
                                            player.seek(Duration(seconds: (player.state.duration.inSeconds * value).toInt()));
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              )
                            )
                          ],
                        );
                      },
                    ),
                    !isCommentOpen?
                    Align(
                      alignment: const Alignment(1,0.75),
                      child: VideoSideButtons(
                        videoInfo:videoInfoList[index],
                        onOpenComment: () => openComment(),
                      ),
                    ):
                    const SizedBox.shrink(),
                  ],
                );
              },
            ),
          ),
          AnimatedContainer(
            height: videoCommentHeight,
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: CustomScrollView(
                controller: commentScrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          final newHeight = videoCommentHeight - details.delta.dy;
                          if (newHeight >= 0 && newHeight <= 640) {
                            videoCommentHeight = newHeight;
                          }
                        });
                      },
                      onVerticalDragEnd: (details) {
                        if(videoCommentHeight > 400){
                          openComment();
                        }else{
                          closeComment();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                      videoInfoList[currentVideoIndex].authorThumbUrl!
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  TDText(
                                    videoInfoList[currentVideoIndex].authorNickName!,
                                    font: TDTheme.of(context).fontTitleLarge,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TDButton(
                                    type: TDButtonType.ghost,
                                    child: TDText(
                                      '关注',
                                      font: TDTheme.of(context).fontBodyLarge,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: GestureDetector(
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.grey,
                                      ),
                                      onTap: ()=> closeComment(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TDText(
                              videoInfoList[currentVideoIndex].caption!,
                              font: TDTheme.of(context).fontTitleLarge,
                            ),
                            const SizedBox(height: 8),
                            TDText(
                              '发布于 ${FormatUtils.timeFormatTimestamp(
                                  videoInfoList[currentVideoIndex].createTime!
                              )}',
                              font: TDTheme.of(context).fontBodyLarge,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 32),
                            TDText(
                              '评论 ${videoInfoList[currentVideoIndex].commentCount}',
                              font: TDTheme.of(context).fontTitleLarge,
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    )
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index){
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    commentInfoList[index].userAvatar!
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TDText(
                                      commentInfoList[index].userName!,
                                      font: TDTheme.of(context).fontBodyLarge,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    TDText(
                                      commentInfoList[index].commentText!,
                                      font: TDTheme.of(context).fontBodyLarge,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        TDText(
                                          FormatUtils.dateFormatTimestamp(
                                              commentInfoList[index].createTime!
                                          ) + (
                                              commentInfoList[index].ipLabel == null ? '' : ' · ${commentInfoList[index].ipLabel!}'
                                          ),
                                          font: TDTheme.of(context).fontBodyLarge,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: 65,
                                          child: Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            direction: Axis.horizontal,
                                            children: [
                                              const Icon(
                                                Icons.thumb_up_outlined,
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              TDText(
                                                FormatUtils.formatNumber(commentInfoList[index].diggCount),
                                                font: TDTheme.of(context).fontBodyLarge,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.thumb_down_outlined,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                      ]
                                    )
                                  ]
                                )
                              )
                            ]
                          )
                        );
                      },
                      childCount: commentInfoList.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child:isCommentLoading?
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ):
                        TDText(
                          '下拉以获取更多评论',
                          font: TDTheme.of(context).fontBodyLarge,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
      :
      Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            TDText(
              '加载中...',
              font: TDTheme.of(context).fontTitleMedium,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      )
    );
  }
}