class DriverBidModel {
  final String name;
  final String car;
  final String rating;
  final String bid;
  final String imageUrl;
  final bool isFavorite;

  DriverBidModel({
    required this.name,
    required this.car,
    required this.rating,
    required this.bid,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
