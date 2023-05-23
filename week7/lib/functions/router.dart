import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:week6/screens/DieDetail.dart';
import 'package:week6/screens/DicePage.dart';
import 'package:week6/screens/HomePage.dart';
import 'package:week6/screens/SettingPage.dart';
import 'package:week6/screens/StatisticsPage.dart';
import 'package:week6/screens/SumDetail.dart';

final GoRouter router_config = GoRouter(routes: [
  GoRoute(
      name: 'dice',
      path: '/dice',
      pageBuilder: (context, state) {
        return MaterialPage(child: DicePage());
      }),
  GoRoute(
      name: 'homepage',
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(child: HomePage());
      }),
  GoRoute(
      name: 'statistics',
      path: '/statistics',
      pageBuilder: (context, state) {
        return MaterialPage(child: StatisticsPage());
      }),
  GoRoute(
      name: 'settings',
      path: '/settings',
      pageBuilder: (context, state) {
        return MaterialPage(child: SettingPage());
      }),
  GoRoute(
      name: 'diedetail',
      path: '/statistics/diedetail',
      pageBuilder: (context, state) {
        return MaterialPage(child: DieDetailPage());
      }),
  GoRoute(
      name: 'sumdetail',
      path: '/statistics/sumdetail',
      pageBuilder: (context, state) {
        return MaterialPage(child: SumDetialPage());
      })
]);
