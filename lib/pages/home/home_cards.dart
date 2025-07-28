import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../../components/gradient/presets.dart';
import '../../components/icons/gradient_icon.dart';
import 'components/sliver_card/sliver_card.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverTitleCard(
      backgroundColor: const Color.fromRGBO(232,238,243, 1),
      leading: [
        TDText(
          '最近消息',
          font: TDTheme.of(context).fontTitleMedium,
          textColor: Colors.black87,
        )
      ],
      trailing: [
        TDText(
          '更多',
          font: TDTheme.of(context).fontBodyLarge,
          textColor: Colors.black87,
        ),
        const Icon(
          TDIcons.chevron_right,
          size: 16,
        )
      ],
      child: Column(
        children: [
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const GradientIcon(
                TDIcons.notification_filled,
                size: 18,
                gradient: IconGradientPresets.passion,
              ),
              const SizedBox(width: 8),
              TDText(
                '好友消息',
                font: TDTheme.of(context).fontBodyMedium,
                textColor: Colors.black,
              ),
              const SizedBox(width: 8),
              TDText(
                '你的好友近期有新的消息哦',
                font: TDTheme.of(context).fontBodyMedium,
                textColor: Colors.black,
              ),
              const Spacer(),
              TDText(
                '1小时前',
                font: TDTheme.of(context).fontBodyMedium,
                textColor: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const GradientIcon(
                TDIcons.mail_filled,
                size: 18,
                gradient: IconGradientPresets.tech,
              ),
              const SizedBox(width: 8),
              TDText(
                '邮件通知',
                font: TDTheme.of(context).fontBodyMedium,
                textColor: Colors.black,
              ),
              const SizedBox(width: 8),
              TDText(
                '有10条未读邮件，请查看',
                font: TDTheme.of(context).fontBodyMedium,
                textColor: Colors.black,
              ),
              const Spacer(),
              TDText(
                '2小时前',
                font: TDTheme.of(context).fontBodyMedium,
                textColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SwiperCard extends StatelessWidget {
  const SwiperCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> swiperUrls = [
      'assets/images/swiper/swiper_bg1.png',
      'assets/images/swiper/swiper_bg2.png',
      'assets/images/swiper/swiper_bg3.png',
    ];

    return SliverCard(
      backgroundColor: const Color.fromRGBO(232,238,243, 1),
      child: SizedBox(
        height: 180,
        child: Swiper(
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: TDSwiperPagination.dotsBar
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(swiperUrls[index]),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}