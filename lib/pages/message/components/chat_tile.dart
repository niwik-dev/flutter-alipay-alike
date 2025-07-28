import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.time,
    this.icon = Icons.person,
    this.iconWidget,
    this.count = 0,
    this.onTap,
  }) : super(key: key);

  final String title;

  final String subTitle;

  final String time;

  final IconData icon;

  final Widget? iconWidget;

  final int count;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            iconWidget ?? CircleAvatar(
              radius: 24,
              child: Icon(
                icon,
                size: 36,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TDText(
                    title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                  TDText(
                      subTitle,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: TDTheme.of(context).grayColor6,
                          overflow: TextOverflow.ellipsis
                      )
                  )
                ],
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TDText(
                      time,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TDTheme.of(context).grayColor6,
                      )
                  ),
                  SizedBox(
                    width: 22,
                    child: TDBadge(
                      TDBadgeType.square,
                      count: count.toString(),
                      showZero: false,
                    ),
                  )
                ]
            )
          ],
        ),
      ),
    );
  }
}