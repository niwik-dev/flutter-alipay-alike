import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../pages/chat/chat_page.dart';
import '../../store/tab_bar/tab_bar_state_store.dart';

class TwoLevelBackground extends StatelessWidget {
  const TwoLevelBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(154, 192, 253, 1),
                Color.fromRGBO(220, 237, 253, 1),
              ],
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height / 3,
        //     decoration: const BoxDecoration(
        //       gradient: RadialGradient(
        //         center: Alignment.topRight,
        //         radius: 2,
        //         colors: [
        //           Color.fromRGBO(176, 185, 250, 1),
        //           Color.fromRGBO(136, 203, 253, 0),
        //         ],
        //       )
        //     ),
        //     // child: Placeholder(),
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height /3,
        //     decoration: const BoxDecoration(
        //         gradient: RadialGradient(
        //           center: Alignment.bottomRight,
        //           radius: 2,
        //           colors: [
        //             Color.fromRGBO(176, 185, 250, 1),
        //             Color.fromRGBO(136, 203, 253, 0),
        //           ],
        //         )
        //     ),
        //   ),
        // ),
        child,
      ],
    );
  }
}

class TwoLevelPage extends HookConsumerWidget {
  const TwoLevelPage({
    super.key,
    required this.refreshController,
  });

  final RefreshController refreshController;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      body: TwoLevelBackground(
        child: Column(
          children: [
            const Expanded(
              child: ChatPage(),
            ),
            GestureDetector(
              onTap: () {
                refreshController.refreshToIdle();
                final tabBarState = ref.read(tabBarStateStoreProvider.notifier);
                tabBarState.setHidden(false);
              },
              child: Container(
                height: 64,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(238, 247, 254, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        '点击或上滑返回首页',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 120,
                        height: 4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
            )
          ]
        )
      ),
    );
  }
}