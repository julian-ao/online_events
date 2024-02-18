import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:online/dark_overlay.dart';

import '../../theme/theme.dart';

class RoulettePage extends StatefulWidget {
  const RoulettePage({Key? key}) : super(key: key);

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

final challenges = [
  {
    "title": "Waterfall",
    "description": "Alle drikker help til de til venstre slutter"
  },
  {
    "title": "6 Minutes",
    "description": "Finn en spotify playlist og folk må gjette sangene"
  },
  {
    "title": "SHUG",
    "description": "Drikk opp enhenten din",
  },
  {
    "title": "Ratling Bog",
    "description": "Sett på ratling bog",
  },
  {
    "title": "Gi ut 10 slurker",
    "description": "tittel",
  },
  {
    "title": "Alle drikker",
    "description": "Finn en spotify playlist og folk må gjette sangene"
  },
  {
    "title": "Alle Single drikker",
    "description": "Alle drikker help til de til venstre slutter"
  },
  {
    "title": "Hot seat",
    "description": "Finn en spotify playlist og folk må gjette sangene"
  },
  {"title": "Shot", "description": "shot med den mest edrue i rommet"},
  {
    "title": "Fuck marry kill",
    "description": "Finn en spotify playlist og folk må gjette sangene"
  },
  // ... other challenges
];

class _RoulettePageState extends State<RoulettePage> {
  final StreamController<int> _selected = StreamController<int>();

  static final red = FortuneItemStyle(
    color: OnlineTheme.red,
    textStyle: OnlineTheme.textStyle(),
  );
  static final green = FortuneItemStyle(
    color: OnlineTheme.green,
    textStyle: OnlineTheme.textStyle(),
  );
  static final black = FortuneItemStyle(
    color: Colors.black,
    textStyle: OnlineTheme.textStyle(),
  );

  final fortuneList = List<FortuneItem>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < challenges.length; i++) {
      late final FortuneItemStyle color;

      if (i == 0) {
        color = green;
      } else if (i % 2 == 0) {
        color = red;
      } else {
        color = black;
      }

      fortuneList.add(
        FortuneItem(
          child: Text(
            challenges[i]['title']!,
            style: OnlineTheme.textStyle(weight: 7),
          ),
          style: color,
        ),
      );
    }
  }

  int index = 0;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OnlineTheme.background,
      child: Center(
        child: FortuneWheel(
          onAnimationEnd: () {
            RouletteOverlay(
              title: challenges[index]["title"] ?? "",
              description: challenges[index]["description"] ?? "",
            ).show(context);
          },
          animateFirst: false,
          selected: _selected.stream,
          items: fortuneList,
          physics: CircularPanPhysics(
            duration: const Duration(seconds: 1),
            curve: Curves.decelerate,
          ),
          onFling: () {
            _selected.add(random.nextInt(challenges.length));
          },
          onFocusItemChanged: (value) {
            index = value;
          },
        ),
      ),
    );
  }
}

class RouletteOverlay extends DarkOverlay {
  final String title;
  final String description;

  RouletteOverlay({required this.title, required this.description});

  @override
  Widget content(BuildContext context, Animation<double> animation) {
    // TODO: implement content
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: OnlineTheme.header(),
        ),
        const SizedBox(height: 24),
        Text(
          description,
          style: OnlineTheme.textStyle(),
        ),
      ],
    );
  }
}
