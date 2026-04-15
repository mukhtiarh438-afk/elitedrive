class RideRequestModel {
  final String passengerName;
  final String rating;
  final String milesAway;
  final String price;
  final String estTime;
  final String pickupAddress;
  final String dropoffAddress;
  final String imageUrl;
  final bool isMini; // small card at bottom

  RideRequestModel({
    required this.passengerName,
    required this.rating,
    required this.milesAway,
    required this.price,
    required this.pickupAddress,
    required this.dropoffAddress,
    this.estTime = '',
    this.imageUrl = '',
    this.isMini = false,
  });
}
