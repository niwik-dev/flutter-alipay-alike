import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../pages/auth/components/app_logo.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountInputController = useTextEditingController();
    final passwordInputController = useTextEditingController();

    Future<void> tryLogin() async {
      if (accountInputController.text.isEmpty){
        TDToast.showWarning('账号不得为空！', context: context);
        return;
      }
      if (passwordInputController.text.isEmpty){
        TDToast.showWarning('密码不得为空！', context: context);
        return;
      }

      context.go('/home');

      String account = accountInputController.text;
      String password = passwordInputController.text;
    }

    return SafeArea(
      child: Scaffold(
        appBar: const TDNavBar(
          backgroundColor: Colors.transparent,
        ),
        body: Align(
          alignment: const Alignment(0, -0.25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: FocusScope(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 24),
                  TDInput(
                    controller: accountInputController,
                    leftLabel: '账号',
                    hintText: '手机号/邮箱/昵称',
                  ),
                  const SizedBox(height: 8),
                  TDInput(
                    obscureText: true,
                    controller: passwordInputController,
                    leftLabel: '密码',
                    hintText: '请输入登录密码',
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white
                          )
                        ),
                        side: WidgetStatePropertyAll(
                          BorderSide(
                            color: Theme.of(context).colorScheme.primary
                          )
                        )
                      ),
                      onPressed: () {
                        tryLogin();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          '登录',
                        ),
                      ),
                    )
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                          child: Text(
                            '忘记密码？',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]
              ),
            ),
          )
        )
      )
    );
  }
}
