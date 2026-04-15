// App Colors
import 'dart:ui';

class AppColors {
  // Natural Colors
  static const blackColor = Color(0xFF050505);
  static const whiteColor = Color(0xFFFFFFFF);
  static const backgroundColor = Color(0xFFF2F2F2);

  // App Color
  static const mainColor = Color(0xFF7BEEC5);
  static const lightMintColor = Color(0xFFACF7DE);
  static const actionTealColor = Color(0xFF2AA88A);
  static const lightRedColor = Color(0xFFFFA69E);
  static const green = Color(0xFF48C78E);

  // Theme Colors
  static const greyColor = Color(0xFF969A9A);
  static const lightGreyColor = Color(0xFFB4B3B3);
  static const blueColor = Color(0xFF1087FF);
  static const lightBlueColor = Color(0xFF3C9DFF);
  static const darkRedColor = Color(0xFF990000);
  static const darkGreenColor = Color(0xFF228B22);
  static const darkOrangeColor = Color(0xFFFF9800);
  static const darkPurpleColor = Color(0xFF9C27B0);
  static const darkTealColor = Color(0xFF009688);

  // Soft Transparent Color Code
  static const blueTransparentColor = Color(0xFFE9F2FB);
  static const orangeTransparentColor = Color(0xFFFCEFE4);
  static const purpleTransparentColor = Color(0xFFF3F0FB);
  static const greenTransparentColor = Color(0xFFEDF7F1);
  static const redTransparentColor = Color(0xFFFCEDED);
  static const whiteTransparentColor = Color(0xB3FFFFFF);
  static const tealTransparentColor = Color(0xFFDCF0ED);

  // Dark Text Colors
  static const blueDarkText = Color(0xFF1E3A5F);
  static const orangeDarkText = Color(0xFF7A3E12);
  static const purpleDarkText = Color(0xFF3D2C6B);
  static const greenDarkText = Color(0xFF1F5B3A);
  static const redDarkText = Color(0xFF7A1F1F);

  // ── Home Screen ─────────────────────────────────────
  static const homeBackground   = Color(0xFFEEF3F0); // light mint-grey bg from design
  static const homePrimary      = Color(0xFF2D4A5E); // dark navy — primary
  static const homeTitleText    = Color(0xFF1A2B3C); // near-black titles
  static const homeSubtitleText = Color(0xFF6B7A8D); // medium grey subtitles
  static const homeHintText     = Color(0xFFADB5BD); // light grey hints/placeholders
  static const homeDivider      = Color(0xFFF0F4F8);
  static const homeLinkBlue     = Color(0xFF4A90D9); // "View All" medium blue
  static const homeStarColor    = Color(0xFF6B7A8D); // same as subtitle — design shows grey star
  static const homeAvatarRing   = Color(0xFFD0D8E4); // light ring around driver photo
  static const homeAvatarBg     = Color(0xFFD6E8F7);

  static const fleetCardBg         = Color(0xFFF5F6F8); // unselected fleet card grey
  static const fleetCardSelectedBg = Color(0xFFFFFFFF); // selected fleet card white
  static const fleetIconColor      = Color(0xFF3D5A73); // dark slate icon color
  static const advanceBookingBg    = Color(0xFFD6E8F7); // light blue card
  static const advanceBookingTitle = Color(0xFF2D4A5E); // dark blue title on card
  static const multiStopBg         = Color(0xFFD4EDDA); // light green card
  static const multiStopTitle      = Color(0xFF2D6A4F); // dark green title on card
  static const multiStopIcon       = Color(0xFF2D6A4F); // dark green icon

  // ── Support Screen ───────────────────────────────────
  static const supportSearchBg    = Color(0xFFEEF3F0);
  static const quickHelpCardBg    = Color(0xFFFFFFFF);
  static const liveChatCardBg     = Color(0xFFD4EDDA);
  static const liveChatBtnBg      = Color(0xFF2D4A5E);
  static const complaintCardBg    = Color(0xFFFFFFFF);
  static const inputFieldBg       = Color(0xFFF5F6F8);
  static const submitBtnBg        = Color(0xFF2D4A5E);
  static const articleIconBg1     = Color(0xFFD6E8F7);
  static const articleIconBg2     = Color(0xFFD6E8F7);
  static const articleIconBg3     = Color(0xFFD4EDDA);

  // ── Fleet Performance Screen ─────────────────────────
  static const fleetChartBarActive   = Color(0xFF2D4A5E);
  static const fleetChartBarInactive = Color(0xFFD6E8F7);
  static const fleetStatCardBg       = Color(0xFFF5F6F8);
  static const vehicleInService      = Color(0xFF4CAF50);
  static const vehicleMaintenance    = Color(0xFFE53935);
  static const assignBtnBg           = Color(0xFFD4EDDA);
  static const assignBtnText         = Color(0xFF2D6A4F);
  static const driverCardBg          = Color(0xFFFFFFFF);
  static const ownerTabActive        = Color(0xFFFFFFFF);

  // ── Driver Bids Screen ──────────────────────────────
  static const mapCardBg          = Color(0xFFE8EEEB);
  static const bidsTabActiveBg    = Color(0xFFFFFFFF);
  static const newBidsBadgeBg     = Color(0xFFD4EDDA);
  static const newBidsBadgeText   = Color(0xFF2D6A4F);
  static const favoriteBadgeBg    = Color(0xFFD4EDDA);
  static const favoriteBadgeText  = Color(0xFF2D6A4F);
  static const acceptBtnActive    = Color(0xFF2D4A5E);
  static const acceptBtnInactive  = Color(0xFFF0F4F8);
  static const fixedRateCardBg    = Color(0xFFFFFFFF);
  static const fixedRateLockBg    = Color(0xFFF0F4F8);

  // ── Active Ride Screen ───────────────────────────────
  static const activeRideBg        = Color(0xFFDDE8E2); // map-like muted bg
  static const arrivingMinColor    = Color(0xFF1A2B3C);
  static const trafficBadgeBg      = Color(0xFFFFFFFF);
  static const trafficDot          = Color(0xFF4CAF50);
  static const routeIconNav        = Color(0xFF2D4A5E);
  static const routeIconStop       = Color(0xFFADB5BD);
  static const routeIconDest       = Color(0xFF2D4A5E);
  static const routeLine           = Color(0xFFD0D8E4);
  static const sosCardBg           = Color(0xFFFCEDED);
  static const sosIconColor        = Color(0xFFE53935);
  static const shareCardBg         = Color(0xFFFFFFFF);
  static const verifyCardBg        = Color(0xFFFFFFFF);
  static const verifyIconBg        = Color(0xFFD4EDDA);
  static const verifyIconColor     = Color(0xFF2D6A4F);
  static const proBadgeBg          = Color(0xFF2D4A5E);

  // ── Earnings Screen ─────────────────────────────────
  static const earningsBalanceBg   = Color(0xFFFFFFFF);
  static const loyaltyCardBg       = Color(0xFFFFFFFF);
  static const goldCardBg          = Color(0xFF2D4A5E);
  static const goldProgressColor   = Color(0xFFFFC107);
  static const paymentCardBg       = Color(0xFFFFFFFF);
  static const couponGreenBg       = Color(0xFFD4EDDA);
  static const couponGreenText     = Color(0xFF2D6A4F);
  static const couponCodeBg        = Color(0xFFFFFFFF);
  static const txPositive          = Color(0xFF2D6A4F);
  static const txNegative          = Color(0xFF1A2B3C);
  static const toggleActiveBg      = Color(0xFFFFFFFF);

  // ── Rides Screen ────────────────────────────────────
  static const ridesPrimary      = Color(0xFF2D4A5E);
  static const ridesCardDark     = Color(0xFF2D4A5E);
  static const ridesEarningsBg   = Color(0xFF2D4A5E);
  static const ridesStatsBg      = Color(0xFFFFFFFF);
  static const ridesOnlineBg     = Color(0xFFFFFFFF);
  static const ridesOnlineDot    = Color(0xFF4CAF50);
  static const ridesSelectedDay  = Color(0xFFEEF3F0);
  static const ridesHighDemand   = Color(0xFFFF6B6B);
  static const ridesAcceptBtn    = Color(0xFF2D4A5E);
  static const ridesDeclineBtn   = Color(0xFFEEF3F0);
  static const ridesPickupIcon   = Color(0xFF4CAF50);
  static const ridesDropIcon     = Color(0xFFE53935);
  static const ridesPositive     = Color(0xFF4CAF50);
  static const ridesRequestBg    = Color(0xFFFFFFFF);
  static const ridesMiniCard     = Color(0xFFFFFFFF);
  static const hubIconBg    = Color(0xFFD4E8C4); // yellow-green circle bg
  static const hubIconColor = Color(0xFF4A5E2A); // dark olive icon
  static const homeIconBg   = Color(0xFFC8E6C9); // light green circle bg
  static const homeIconColor = Color(0xFF2E6B3E); // dark green icon
}
