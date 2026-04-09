import 'package:flutter/cupertino.dart';

class AppTextSize {
  static double _scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 0.9;   // Extra Small Phones
    if (width < 480) return 1.0;   // Small Phones  ← most phones here
    if (width < 600) return 1.05;  // Large Phones
    if (width < 900) return 1.15;  // Tablets
    return 1.2;                    // Large Tablets
  }

  static double _size(BuildContext context, double base) =>
      base * _scale(context);

  // Display  (Greeting heading)
  static double displayLarge(BuildContext context)  => _size(context, 34);
  static double displayMedium(BuildContext context) => _size(context, 28); // "Good Morning, Alex"
  static double displaySmall(BuildContext context)  => _size(context, 24);

  // Headlines  (Section titles: Our Fleet, Suggested, Drivers)
  static double headlineLarge(BuildContext context)  => _size(context, 22);
  static double headlineMedium(BuildContext context) => _size(context, 20);
  static double headlineSmall(BuildContext context)  => _size(context, 18); // section headers

  // Titles  (AppBar, card titles)
  static double titleLarge(BuildContext context)  => _size(context, 17); // AppBar title
  static double titleMedium(BuildContext context) => _size(context, 16);
  static double titleSmall(BuildContext context)  => _size(context, 15); // booking/fleet/place title

  // Body  (subtitles, hints)
  static double bodyLarge(BuildContext context)  => _size(context, 16);
  static double bodyMedium(BuildContext context) => _size(context, 15); // greeting subtitle
  static double bodySmall(BuildContext context)  => _size(context, 15); // search hint, view all

  // Labels  (prices, addresses, ratings, nav)
  static double labelLarge(BuildContext context)  => _size(context, 13); // driver name
  static double labelMedium(BuildContext context) => _size(context, 12); // address, rating
  static double labelSmall(BuildContext context)  => _size(context, 11); // price, nav label, DETAILS
}
