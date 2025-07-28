import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../pages/auth/components/app_logo.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountInputController = useTextEditingController();
    final passwordInputController = useTextEditingController();
    final captchaInputController = useTextEditingController();

    void tryLogin() {
      if (accountInputController.text.isEmpty){
        TDToast.showWarning('账号不得为空！', context: context);
        return;
      }
      if (passwordInputController.text.isEmpty){
        TDToast.showWarning('密码不得为空！', context: context);
        return;
      }
      context.push('/home');
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
                            hintText: '手机号/邮箱',
                          ),
                          const SizedBox(height: 8),
                          TDInput(
                            obscureText: true,
                            controller: passwordInputController,
                            leftLabel: '密码',
                            hintText: '请输入注册密码',
                          ),
                          const SizedBox(height: 8),
                          TDInput(
                            obscureText: true,
                            controller: captchaInputController,
                            leftLabel: '验证码',
                            hintText: '请输入验证码',
                            rightWidget: TDButton(
                              child: const TDText('获取验证码'),
                              onTap: () {
                                TDToast.showSuccess('验证码已发送', context: context);
                              },
                            ),
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
                                    '注册',
                                  ),
                                ),
                              )
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
