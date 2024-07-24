class DConstants {
  static const baseJpgImage = 'assets/images/jpgs/';
  static const basePngImage = 'assets/images/pngs/';
  static const baseSvgImage = 'assets/images/svgs/';
  static const baseLottieImage = 'assets/lotties/';

  static const List bannerImages = [
    'assets/images/jpgs/bannerImage.jpg',
    'assets/images/jpgs/bannerImage.jpg',
    'assets/images/jpgs/bannerImage.jpg',
    'assets/images/jpgs/bannerImage.jpg',
    'assets/images/jpgs/bannerImage.jpg',
  ];


  static const List companiesLogos = [
    'assets/images/pngs/mcdonalds.png',
    'assets/images/jpgs/hyper.jpg',
    'assets/images/pngs/spotify.png',
    'assets/images/pngs/starbucks.png',
    'assets/images/pngs/mcdonalds.png',
    'assets/images/jpgs/hyper.jpg',
    'assets/images/pngs/spotify.png',
    'assets/images/pngs/starbucks.png',
    'assets/images/pngs/mcdonalds.png',
    'assets/images/jpgs/hyper.jpg',
    'assets/images/pngs/spotify.png',
    'assets/images/pngs/starbucks.png',
  ];

  static const List companiesName = [
    'Mcdonalds Shop',
    'Hyper Shop',
    'Spotify Shop',
    'Starbucks Shop',
    'Mcdonalds Shop',
    'Hyper Shop',
    'Spotify Shop',
    'Starbucks Shop',
    'Mcdonalds Shop',
    'Hyper Shop',
    'Spotify Shop',
    'Starbucks Shop',
  ];

  static const List companiesOffers = [
    '1 Offers',
    '4 Offers',
    '35 Offers',
    '100 Offers',
    '2 Offers',
    '8 Offers',
    '9 Offers',
    '4 Offers',
    '23 Offers',
    '67 Offers',
    '23 Offers',
    '12 Offers',
  ];

  static const List categoriesName = [
    'All',
    'Electric',
    'Markets',
    'Other',
    'All',
    'Electric',
    'Markets',
    'Other',
    'All',
    'Electric',
    'Markets',
    'Other',
  ];
}

class Company {
  int id;
  String logo;
  String name;
  String offers;

  Company({
    required this.id,
    required this.logo,
    required this.name,
    required this.offers,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'name': name,
      'offers': offers,
    };
  }

  // Create from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      logo: json['logo'],
      name: json['name'],
      offers: json['offers'],
    );
  }
}