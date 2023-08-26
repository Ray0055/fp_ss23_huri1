import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tex/flutter_tex.dart';

class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: TeXView(child: TeXViewColumn(children: [TeXViewDocument(r"$$ P \times Q$$")])),
        
      
    );
  }
}
