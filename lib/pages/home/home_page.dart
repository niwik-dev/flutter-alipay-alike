import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';


import '../../../pages/home/two_level_page.dart';
import '../../../store/tab_bar/tab_bar_state_store.dart';
import '../../../utils/td_icon.dart';
import '../../components/gradient/presets.dart';
import '../../components/icons/gradient_icon.dart';
import 'components/area/area_select.dart';
import 'components/buttons/vertical_icon_button.dart';
import 'components/sliver_card/sliver_card.dart';
import 'home_cards.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: CardGradientPresets.sky
      ),
      child: TDNavBar(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.only(left: 16, right: 16),
        titleWidget: Row(
          children: [
            Expanded(
              child: TDSearchBar(
                backgroundColor: Colors.transparent,
                style: TDSearchStyle.round,
                placeHolder: '今日话题',
                onSubmitted: (text){
                  print(text);
                },
              ),
            )
          ],
        ),
        useDefaultBack: false,
        leftBarItems: [
          TDNavBarItem(
            iconWidget: const AreaSelect(),
          )
        ],
        rightBarItems: [
          TDNavBarItem(
            icon: TDIcons.add_circle,
            iconColor: Colors.white,
          )
        ],
      ),
    );
  }
}


class HomePageSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  double headerHeight = 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: headerHeight,
      child: HomePageHeader(),
    );
  }

  @override
  double get maxExtent => headerHeight;

  @override
  double get minExtent => headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MainFunctionAction extends StatelessWidget {
  const MainFunctionAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VerticalIconButton(
            text: TDText(
              '扫一扫',
              font: TDTheme.of(context).fontBodyLarge,
              textColor: Colors.white,
            ),
            icon: const Icon(
              TDIcons.scan,
              size: 36,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          VerticalIconButton(
            text: TDText(
              '收付款',
              font: TDTheme.of(context).fontBodyLarge,
              textColor: Colors.white,
            ),
            icon: const Icon(
              TDIcons.money,
              size: 36,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          VerticalIconButton(
            text: TDText(
              '出行',
              font: TDTheme.of(context).fontBodyLarge,
              textColor: Colors.white,
            ),
            icon: const Icon(
              TDIcons.location,
              size: 36,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          VerticalIconButton(
            text: TDText(
              '卡包',
              font: TDTheme.of(context).fontBodyLarge,
              textColor: Colors.white,
            ),
            icon: const Icon(
              TDIcons.wallet,
              size: 36,
              color: Colors.white,
            ),
            onTap: () {},
          )
        ]
    );
  }
}

class SubFunctionAction extends StatelessWidget {
  const SubFunctionAction({super.key});

  @override
  Widget build(BuildContext context) {
    List<LinearGradient> gradients = [
      IconGradientPresets.tech,
      IconGradientPresets.passion,
      IconGradientPresets.nature,
    ];

    List<String> fakeAppNames = [
      '市民中心', '我的钱包', '银行卡', '校园派', '火车票抢购',
      '手机充值', '优惠券', '就业大厅', '饿了么', '游戏中心',
      '彩票', '亲情卡', '理财产品', '我的快递', '基金', '股票',
      '直播广场', '口碑团购', '会员专属','生活缴费', '网上银行'
    ];

    // 打乱列表
    fakeAppNames.shuffle();

    return GridView.extent(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        maxCrossAxisExtent: 90,
        crossAxisSpacing: 4,
        padding: const EdgeInsets.only(top: 16),
        children: [
          VerticalIconButton(
            icon: const GradientIcon(
              TDIcons.sensors,
              size: 36,
              gradient: IconGradientPresets.tech,
            ),
            text: TDText(
              '传感器',
              font: TDTheme.of(context).fontBodyMedium,
              textColor: Colors.black,
            ),
            onTap: () {
              context.push('/apps/sensor');
            },
          ),

          for (var i = 0; i < 14; i++)
            VerticalIconButton(
              icon: GradientIcon(
                TDIconUtils.randomTDFilledIcon(),
                size: 36,
                gradient: gradients[
                Random().nextInt(gradients.length)
                ],
              ),
              text: TDText(
                fakeAppNames[i],
                font: TDTheme.of(context).fontBodyMedium,
                textColor: Colors.black,
              ),
              onTap: () {},
            )
        ]
    );
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref,){
    final refreshController = useState(RefreshController(initialRefresh: false));
    final scrollController = useScrollController();
    final scrollUp = useState(false);
    final tabBarState = ref.read(tabBarStateStoreProvider.notifier);

    scrollController.addListener((){
      scrollUp.value =
          (!refreshController.value.isTwoLevel && scrollController.offset <= 0)
              || refreshController.value.isTwoLevel
              || refreshController.value.isRefresh;
    });

    return RefreshConfiguration(
      enableScrollWhenTwoLevel: true,
      closeTwoLevelDistance: 200,
      maxOverScrollExtent: 500,
      child: SmartRefresher(
        onTwoLevel: (isOpen){
          tabBarState.setHidden(isOpen);
        },
        controller: refreshController.value,
        enableTwoLevel: true,
        header: TwoLevelHeader(
          decoration: const BoxDecoration(
            gradient: CardGradientPresets.sky,
          ),
          idleText: '下拉刷新',
          refreshingText: '松开刷新',
          releaseText: '松开刷新',
          canTwoLevelText: '继续下拉进入聊天界面',
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
          completeDuration: const Duration(milliseconds: 500),
          twoLevelWidget: TwoLevelPage(
            refreshController: refreshController.value,
          ),
        ),
        child: CustomScrollView(
            controller: scrollController,
            slivers: [
              scrollUp.value?
              SliverToBoxAdapter(
                child: Container(
                  height: 84,
                  decoration: const BoxDecoration(
                      gradient: CardGradientPresets.sky
                  ),
                  child: Container(
                      height: 100,
                      color:Colors.transparent,
                      child: const HomePageHeader()
                  ),
                ),
              ):
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: HomePageSliverHeaderDelegate(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 84,
                  decoration: const BoxDecoration(
                      gradient: CardGradientPresets.sky
                  ),
                  child: Container(
                      height: 100,
                      color:Colors.transparent,
                      child: const MainFunctionAction()
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: CardGradientPresets.sky
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.0,0.01, 0.15,0.6],
                                  colors: [
                                    Colors.white,
                                    Color.fromRGBO(205,226,251, 1),
                                    Color.fromRGBO(248,248,248, 1),
                                    Color.fromRGBO(232,238,243, 1)
                                  ]
                              )
                          ),
                          child: const Center(
                            child: SubFunctionAction(),
                          )
                      ),
                    ),
                  )
              ),
              const NotificationCard(),
              const SwiperCard(),
              SliverCardRow(
                backgroundColor: const Color.fromRGBO(232,238,243, 1),
                children: [
                  CardInSliver(
                    hasDivider: false,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.05, 0.2],
                          colors: [
                            Color.fromRGBO(255, 222, 193, 1),
                            Color.fromRGBO(255, 233, 216, 1),
                            Color.fromRGBO(255, 255, 255, 1),
                          ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    leading: [
                      TDText(
                        '天天好物',
                        font: TDTheme.of(context).fontTitleMedium,
                        textColor: Colors.black87,
                      ),
                      TDText(
                        ' | ',
                        font: TDTheme.of(context).fontTitleMedium,
                        textColor: Colors.black26,
                      ),
                      TDText(
                        '限时低价',
                        font: TDTheme.of(context).fontTitleMedium,
                        textColor: Colors.deepOrange,
                      ),
                    ],
                    child: Container(
                      height: 120,
                    ),
                  ),
                  CardInSliver(
                    hasDivider: false,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.05, 0.25],
                          colors: [
                            Color.fromRGBO(210, 229, 247, 1),
                            Color.fromRGBO(241, 247, 255, 1),
                            Color.fromRGBO(255, 255, 255, 1),
                          ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    leading: [
                      const GradientIcon(
                        TDIcons.wallet_filled,
                        size: 22,
                        gradient: IconGradientPresets.tech,
                      ),
                      const SizedBox(width: 8),
                      TDText(
                        '理财助手',
                        font: TDTheme.of(context).fontTitleMedium,
                        textColor: Colors.black87,
                      ),
                    ],
                    child: Container(
                      height: 120,
                    ),
                  )
                ],
              ),
              SliverTitleCard(
                backgroundColor: const Color.fromRGBO(232,238,243, 1),
                leading: [
                  const GradientIcon(
                    TDIcons.chart,
                    size: 22,
                    gradient: IconGradientPresets.cool,
                  ),
                  const SizedBox(width: 8),
                  TDText(
                    '今日动向',
                    font: TDTheme.of(context).fontTitleMedium,
                    textColor: Colors.black,
                  ),
                ],
                trailing: [
                  TDText(
                    '查看详情',
                    font: TDTheme.of(context).fontBodyLarge,
                    textColor: Colors.black87,
                  ),
                  const Icon(
                    TDIcons.chevron_right,
                    size: 16,
                  )
                ],
                child: Container(
                  height: 120,
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                    color: const Color.fromRGBO(239,243,247, 1),
                    height: 200,
                    child: Placeholder(),
                  )
              ),
            ]
        ),
      ),
    );
  }
}