import 'package:flutter/cupertino.dart';

class AppIconSize {
  static double _scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 0.9;
    if (width < 480) return 1.0;   // most phones
    if (width < 600) return 1.05;
    if (width < 900) return 1.15;
    return 1.2;
  }

  static double _size(BuildContext context, double base) =>
      base * _scale(context);

  // Raw sizes
  static double xs(BuildContext context)  => _size(context, 16);
  static double sm(BuildContext context)  => _size(context, 20);
  static double md(BuildContext context)  => _size(context, 24);
  static double lg(BuildContext context)  => _size(context, 28);
  static double xl(BuildContext context)  => _size(context, 32);
  static double xxl(BuildContext context) => _size(context, 40);

  // Semantic aliases — matched to original design values
  static double navBar(BuildContext context)    => sm(context);       // 20 — bottom nav
  static double appBar(BuildContext context)    => md(context);       // 24 — notifications, search
  static double avatar(BuildContext context)    => sm(context);       // 20 — person in appbar
  static double card(BuildContext context)      => lg(context);       // 28 — fleet card icon
  static double cardSmall(BuildContext context) => _size(context, 22);// 22 — booking card icon
  static double listTile(BuildContext context)  => sm(context);       // 20 — suggested place, chevron
  static double star(BuildContext context)      => _size(context, 13);// 13 — rating star
}
