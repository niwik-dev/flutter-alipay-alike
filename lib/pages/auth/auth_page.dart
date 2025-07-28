import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../pages/auth/components/app_logo.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: Alignment(0, -0.25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(),
              const SizedBox(height: 16),
              TDText(
                '仅供学习使用，禁止用于商业用途',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black54
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll(
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white
                          )
                      ),
                    ),
                    onPressed: () {
                      context.push('/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        '登录',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton(
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
                      context.push('/register');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        '新用户注册',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
