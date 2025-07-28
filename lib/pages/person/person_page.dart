import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../components/gradient/presets.dart';
import '../../../components/icons/gradient_icon.dart';

class PersonPageHeader extends StatelessWidget {
  const PersonPageHeader({super.key});

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
          useDefaultBack: false,
          backgroundColor: Colors.transparent,
          leftBarItems: [
            TDNavBarItem(
              iconWidget: Wrap(
                children: [
                  TDText(
                    '用户保护中心',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: TDTheme.of(context).grayColor8,
                    ),
                  ),
                  Icon(
                    TDIcons.chevron_right,
                    color: TDTheme.of(context).grayColor8,
                  )
                ],
              ),
            ),
          ],
          rightBarItems: [
            TDNavBarItem(
                iconWidget: Icon(
                  TDIcons.service,
                  color: TDTheme.of(context).grayColor11,
                )
            ),
            TDNavBarItem(
                padding: const EdgeInsets.only(left: 16),
                iconWidget: Icon(
                  TDIcons.setting,
                  color: TDTheme.of(context).grayColor11,
                )
            )
          ],
        )
    );
  }
}


class PersonPageSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  double headerHeight = 48;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: headerHeight,
      child: const PersonPageHeader(),
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

class PersonPage extends HookWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var refreshController = useState(RefreshController(initialRefresh: false));

    return SmartRefresher(
      controller: refreshController.value,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: PersonPageSliverHeaderDelegate(),
          ),
          SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
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
                    const TDAvatar(
                      size: TDAvatarSize.large,
                      shape: TDAvatarShape.square,
                      avatarUrl: 'https://thispersondoesnotexist.com/',
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TDText(
                            '英语六级不过不换昵称',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                          ),
                          TDText(
                            '@Lining7302',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: TDTheme.of(context).grayColor8,
                            ),
                          )
                        ],
                      ),
                    ),
                    Icon(
                      TDIcons.chevron_right,
                      color: TDTheme.of(context).grayColor8,
                      size: 28,
                    )
                  ],
                ),
              )
          ),
          SliverFillRemaining(
            child: Container(
                padding: const EdgeInsets.all(16),
                color: Color.fromRGBO(239,242,248,1),
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: TDTheme.of(context).grayColor1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: const GradientIcon(
                          TDIcons.discount_filled,
                          gradient: IconGradientPresets.tech,
                        ),
                        title: TDText(
                          '会员服务',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          TDIcons.chevron_right,
                          color: TDTheme.of(context).grayColor8,
                        ),
                        onTap: (){},
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: TDTheme.of(context).grayColor1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: const GradientIcon(
                          TDIcons.bill_filled,
                          gradient: IconGradientPresets.passion,
                        ),
                        title: TDText(
                          '账单',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          TDIcons.chevron_right,
                          color: TDTheme.of(context).grayColor8,
                        ),
                        onTap: (){},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: TDTheme.of(context).grayColor1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        tileColor: Colors.white,
                        leading: GradientIcon(
                          TDIcons.cardmembership_filled,
                          gradient: IconGradientPresets.tech,
                        ),
                        title: TDText(
                          '银行卡',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          TDIcons.chevron_right,
                          color: TDTheme.of(context).grayColor8,
                        ),
                        onTap: (){},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: TDTheme.of(context).grayColor1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: GradientIcon(
                          TDIcons.wallet_filled,
                          gradient: IconGradientPresets.tech,
                        ),
                        title: TDText(
                          '余额',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          TDIcons.chevron_right,
                          color: TDTheme.of(context).grayColor8,
                        ),
                        onTap: (){},
                      ),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}