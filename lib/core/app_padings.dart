import 'package:flutter/cupertino.dart';

class AppPaddings {
  // MOBILE VALUES
  static const _mXS = 6.0;
  static const _mS  = 10.0;
  static const _mM  = 14.0;
  static const _mL  = 18.0;
  static const _mXL = 24.0;
  static const _mEL = 38.0;

  // TABLET VALUES
  static const _tXS = 10.0;
  static const _tS  = 14.0;
  static const _tM  = 20.0;
  static const _tL  = 28.0;
  static const _tXL = 36.0;
  static const _tEL = 50.0;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  static double _v(BuildContext context, double m, double t) =>
      isTablet(context) ? t : m;

  // HORIZONTAL
  static EdgeInsets hXS(BuildContext context) => EdgeInsets.symmetric(horizontal: _v(context, _mXS, _tXS));
  static EdgeInsets hS(BuildContext context)  => EdgeInsets.symmetric(horizontal: _v(context, _mS,  _tS));
  static EdgeInsets hM(BuildContext context)  => EdgeInsets.symmetric(horizontal: _v(context, _mM,  _tM));
  static EdgeInsets hL(BuildContext context)  => EdgeInsets.symmetric(horizontal: _v(context, _mL,  _tL));
  static EdgeInsets hXL(BuildContext context) => EdgeInsets.symmetric(horizontal: _v(context, _mXL, _tXL));
  static EdgeInsets hEL(BuildContext context) => EdgeInsets.symmetric(horizontal: _v(context, _mEL, _tEL));

  // VERTICAL
  static EdgeInsets vXS(BuildContext context) => EdgeInsets.symmetric(vertical: _v(context, _mXS, _tXS));
  static EdgeInsets vS(BuildContext context)  => EdgeInsets.symmetric(vertical: _v(context, _mS,  _tS));
  static EdgeInsets vM(BuildContext context)  => EdgeInsets.symmetric(vertical: _v(context, _mM,  _tM));
  static EdgeInsets vL(BuildContext context)  => EdgeInsets.symmetric(vertical: _v(context, _mL,  _tL));
  static EdgeInsets vXL(BuildContext context) => EdgeInsets.symmetric(vertical: _v(context, _mXL, _tXL));

  // ALL SIDES
  static EdgeInsets allS(BuildContext context) => EdgeInsets.all(_v(context, _mS,  _tS));
  static EdgeInsets allM(BuildContext context) => EdgeInsets.all(_v(context, _mM,  _tM));
  static EdgeInsets allL(BuildContext context) => EdgeInsets.all(_v(context, _mL,  _tL));

  // ONLY — for specific side padding
  static EdgeInsets onlyLeft(BuildContext context, {double mVal = _mL, double tVal = _tL}) =>
      EdgeInsets.only(left: _v(context, mVal, tVal));
  static EdgeInsets onlyRight(BuildContext context, {double mVal = _mL, double tVal = _tL}) =>
      EdgeInsets.only(right: _v(context, mVal, tVal));
  static EdgeInsets onlyTop(BuildContext context, {double mVal = _mL, double tVal = _tL}) =>
      EdgeInsets.only(top: _v(context, mVal, tVal));
  static EdgeInsets onlyBottom(BuildContext context, {double mVal = _mL, double tVal = _tL}) =>
      EdgeInsets.only(bottom: _v(context, mVal, tVal));

  // SYMMETRIC H+V combined
  static EdgeInsets symmetric(BuildContext context, {
    double mH = _mM, double tH = _tM,
    double mV = _mS, double tV = _tS,
  }) => EdgeInsets.symmetric(
    horizontal: _v(context, mH, tH),
    vertical:   _v(context, mV, tV),
  );

  // RAW value helper (for SizedBox heights, radii, etc.)
  static double val(BuildContext context, {double mobile = 0, double tablet = 0}) =>
      isTablet(context) ? tablet : mobile;
}
