import 'package:flutter/material.dart';
import 'models/list_event.dart';
import 'pages/home/home_page.dart';
import '/services/app_navigator.dart';
import 'theme/theme.dart';

final testModels = [
  ListEventModel(
    imageSource: 'assets/images/buldring.png',
    name: 'Buldring med Maddy Z',
    date: DateTime(2023, 12, 5),
    registered: 18,
    capacity: 20,
  ),
  ListEventModel(
    imageSource: 'assets/images/cake.png',
    name: 'Kakebakekurs med Fredrik',
    date: DateTime(2023, 11, 26),
    registered: 10,
    capacity: 12,
  ),
  ListEventModel(
    imageSource: 'assets/images/heart.png',
    name: 'Flørtekurs med Maddy B',
    date: DateTime(2023, 9, 27),
    registered: 5,
    capacity: 5,
  ),
  ListEventModel(
    imageSource: 'assets/images/buldring.png',
    name: 'Buldring med Maddy Z',
    date: DateTime(2023, 12, 5),
    registered: 18,
    capacity: 20,
  ),
  ListEventModel(
    imageSource: 'assets/images/cake.png',
    name: 'Kakebakekurs med Fredrik',
    date: DateTime(2023, 11, 26),
    registered: 10,
    capacity: 12,
  ),
  ListEventModel(
    imageSource: 'assets/images/heart.png',
    name: 'Flørtekurs med Maddy B',
    date: DateTime(2023, 9, 27),
    registered: 5,
    capacity: 5,
  ),
];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigator,
      title: 'Online Events',
      debugShowCheckedModeBanner: false,
      color: OnlineTheme.background,
      home: const HomePage(),
    );
  }
}
