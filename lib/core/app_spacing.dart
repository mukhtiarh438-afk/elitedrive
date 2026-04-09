import 'package:flutter/cupertino.dart';

class AppSpacing {
  // MOBILE
  static const _mXS = 4.0;
  static const _mS  = 8.0;
  static const _mM  = 12.0;
  static const _mL  = 16.0;
  static const _mXL = 24.0;

  // TABLET
  static const _tXS = 6.0;
  static const _tS  = 12.0;
  static const _tM  = 16.0;
  static const _tL  = 24.0;
  static const _tXL = 32.0;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  // VERTICAL WIDGETS
  static Widget vXS(BuildContext context) => SizedBox(height: isTablet(context) ? _tXS : _mXS);
  static Widget vS(BuildContext context)  => SizedBox(height: isTablet(context) ? _tS  : _mS);
  static Widget vM(BuildContext context)  => SizedBox(height: isTablet(context) ? _tM  : _mM);
  static Widget vL(BuildContext context)  => SizedBox(height: isTablet(context) ? _tL  : _mL);
  static Widget vXL(BuildContext context) => SizedBox(height: isTablet(context) ? _tXL : _mXL);

  // HORIZONTAL WIDGETS
  static Widget hXS(BuildContext context) => SizedBox(width: isTablet(context) ? _tXS : _mXS);
  static Widget hS(BuildContext context)  => SizedBox(width: isTablet(context) ? _tS  : _mS);
  static Widget hM(BuildContext context)  => SizedBox(width: isTablet(context) ? _tM  : _mM);
  static Widget hL(BuildContext context)  => SizedBox(width: isTablet(context) ? _tL  : _mL);
  static Widget hXL(BuildContext context) => SizedBox(width: isTablet(context) ? _tXL : _mXL);

  // RAW VALUES — for use in SizedBox(height:), radius, etc.
  static double vVal(BuildContext context, {double mobile = 0, double tablet = 0}) =>
      isTablet(context) ? tablet : mobile;
  static double hVal(BuildContext context, {double mobile = 0, double tablet = 0}) =>
      isTablet(context) ? tablet : mobile;
}
