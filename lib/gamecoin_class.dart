import 'dart:math';

import 'package:flutter/material.dart';

class gameCoin {
  final Widget tail = Image.asset("photos/tail.png", width: 180,);
  final Widget head = Transform.rotate(
    angle: pi,
      child: Image.asset("photos/head.png", width: 180,)
  );

}
