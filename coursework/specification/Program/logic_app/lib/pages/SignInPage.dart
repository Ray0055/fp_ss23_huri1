import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const Icon quiz = Icon(Icons.quiz, size: 120, color: Colors.blue,);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(
      alignment: Alignment(0, 0.4),
      children: <Widget>[
        // 在中间靠上的位置添加一个图标
        Positioned(
          left: MediaQuery.of(context).size.width /2 - 60 , // 图标宽度120，所以减去60使其居中
          top: MediaQuery.of(context).size.height / 4, // 放在屏幕的1/4高度位置
          child: quiz,
        ),
        // 在屏幕3/4的位置添加两个按钮
        Positioned(
          left: 0,
          right: 0,
          top: MediaQuery.of(context).size.height * 2 / 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {context.pushNamed('homepage');}, child: Text('Sign In')),
              ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
            ],
          ),
        ),
      ],
    ));
  }
}
