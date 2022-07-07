
/// University Model
class University {
  String imageUrl;
  String logo;
  String name;
  List<String> country;
  List<String> flag;


  University({
    required this.imageUrl,
    required this.name,
    required this.country,
    required this.flag,
    required this.logo,
  });
}


List<University> universities = [
  University(
    imageUrl: 'assets/universities/images/mahidol.jpg',
    logo:'assets/universities/logo/mahidol.png',
    name: 'Mahidol University',
    country: ["30","20","10"],
    flag: ["🇮🇳", "🇭🇰","🇯🇵"]

  ),
  University(
      imageUrl: 'assets/universities/images/chula.jpg',
      logo:'assets/universities/logo/chula.png',
      name: 'Chulalongkorn University',
      country: ["35","20","3"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
  University(
      imageUrl: 'assets/universities/images/chiangmai.jpg',
      logo:'assets/universities/logo/chiangmai.png',
      name: 'ChiangMai University',
      country: ["8","3","1"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
  University(
      imageUrl: 'assets/universities/images/abac.jpg',
      logo:'assets/universities/logo/abac.png',
      name: 'ABAC University',
      country: ["50","24","20"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
  University(
      imageUrl: 'assets/universities/images/bangkok.jpg',
      logo:'assets/universities/logo/bangkok.png',
      name: 'Bangkok University',
      country: ["44","25","20"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
];