import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../components/gradient/presets.dart';
import '../../../components/icons/gradient_avatar.dart';
import '../../../pages/message/components/chat_tile.dart';

class MessagePageHeader extends StatelessWidget {
  const MessagePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromRGBO(219,230,248,1),
              Color.fromRGBO(200,220,251,1),
            ],
          )
      ),
      child: TDNavBar(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.only(left: 16, right: 16),
        useDefaultBack: false,
        leftBarItems: [
          TDNavBarItem(
              iconWidget:TDText(
                '消息(23)',
                style: Theme.of(context).textTheme.titleLarge,
              )
          ),
          TDNavBarItem(
            iconWidget: const Icon(
              TDIcons.clear,
            )
          ),
        ],
        rightBarItems: [
          TDNavBarItem(
            iconWidget: const Icon(
              TDIcons.user_list,
            )
          ),
          TDNavBarItem(
            iconWidget: const Icon(
              TDIcons.add_circle,
            )
          )
        ],
      ),
    );
  }
}

class MessagePageSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  double headerHeight = 48;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: headerHeight,
      child: const MessagePageHeader(),
    );
  }

  @override
  double get maxExtent => headerHeight;

  @override
  double get minExtent => headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class MessagePage extends HookWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var refreshController = useState(RefreshController(initialRefresh: false));

    return SmartRefresher(
      header: const ClassicHeader(
        completeDuration: Duration(milliseconds: 500),
      ),
      controller: refreshController.value,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: MessagePageSliverHeaderDelegate(),
          ),
          SliverToBoxAdapter(
              child: Container(
                height: 72,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(239,242,248,1),
                        Color.fromRGBO(219,230,248,1),
                      ],
                    )
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TDSearchBar(
                        placeHolder: '搜索你的好友，最近联系人等',
                        backgroundColor: Colors.transparent,
                        style: TDSearchStyle.round,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: TDButton(
                        theme: TDButtonTheme.light,
                        textStyle: TextStyle(
                          color: TDTheme.of(context).brandColor8,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        child: const TDText('搜索'),
                      ),
                    )
                  ],
                ),
              )
          ),
          SliverFillRemaining(
            child: Container(
              color: const Color.fromRGBO(239,242,248,1),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 8
                ),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const ChatTile(
                      title: '生活号动态',
                      subTitle: '近期诈骗短信多发，请各位市民关注【生活号动态】公众号',
                      time: '12:00',
                      iconWidget: GradientCircleAvatar(
                        gradient: IconGradientPresets.tech,
                        child: Icon(
                          TDIcons.notification_filled,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      count: 20,
                    ),
                    const ChatTile(
                      title: '互动消息',
                      subTitle: '可查看私信，点赞，评论，关注等消息',
                      time: '12:00',
                      iconWidget: GradientCircleAvatar(
                        gradient: IconGradientPresets.passion,
                        child: Icon(
                          TDIcons.chat_bubble_1_filled,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                    const ChatTile(
                      title: '店铺消息',
                      subTitle: '有新的订单，请及时回复！',
                      time: '12:00',
                      iconWidget: GradientCircleAvatar(
                        gradient: IconGradientPresets.tech,
                        child: Icon(
                          TDIcons.shop_5_filled,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                    ChatTile(
                        title: '爱丽丝',
                        subTitle: '她已经通过了你的好友请求，快来聊天吧！',
                        time: '12:00',
                        iconWidget: CircleAvatar(
                          radius: 26,
                          backgroundImage: Image.network(
                            'https://thispersondoesnotexist.com/',
                            fit: BoxFit.cover,
                          ).image,
                        )
                    ),
                    ChatTile(
                        title: '丹博士',
                        subTitle: '我很认可你的观点，或许我们以后能合作。',
                        time: '12:00',
                        iconWidget: CircleAvatar(
                          radius: 26,
                          backgroundImage: Image.network(
                            'https://thispersondoesnotexist.com/',
                            fit: BoxFit.cover,
                          ).image,
                        )
                    ),
                    ChatTile(
                        title: '邻居乔姆',
                        subTitle: '哈哈，这真的是个混球主意！你怎么想出来的？',
                        time: '12:00',
                        iconWidget: CircleAvatar(
                          radius: 26,
                          backgroundImage: Image.network(
                            'https://thispersondoesnotexist.com/',
                            fit: BoxFit.cover,
                          ).image,
                        )
                    ),
                    ChatTile(
                        title: '同学西森',
                        subTitle: '[语音通话已结束]',
                        time: '12:00',
                        iconWidget: CircleAvatar(
                          radius: 26,
                          backgroundImage: Image.network(
                            'https://thispersondoesnotexist.com/',
                            fit: BoxFit.cover,
                          ).image,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}