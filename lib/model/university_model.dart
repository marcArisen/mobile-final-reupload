
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
    name: 'Mahidol',
    country: ["30,20,10"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'Chulalongkorn',
      country: ["35,20,3"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'ChiangMai',
      country: ["8,3,1"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'ABAC',
      country: ["50,24,20"]
  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'Bangkok',
      country: ["44,25,20"]
  ),
];