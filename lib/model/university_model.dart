
class University {
  String imageUrl;
  String name;
  List<String> country;

  University({
    required this.imageUrl,
    required this.name,
    required this.country,
  });
}


List<University> universities = [
  University(
    imageUrl: 'assets/images/chula.jpg',
    name: 'Mahidol University',
    country: ["30","20","10"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'Chulalongkorn University',
      country: ["35","20","3"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'ChiangMai University',
      country: ["8","3","1"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'ABAC University',
      country: ["50","24","20"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'Bangkok University',
      country: ["44","25","20"]
  ),
];