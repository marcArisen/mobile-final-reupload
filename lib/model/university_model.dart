
/// University Model
class University {
  String imageUrl;
  String name;
  List<String> country;
  List<String> flag;

  University({
    required this.imageUrl,
    required this.name,
    required this.country,
    required this.flag
  });
}


List<University> universities = [
  University(
    imageUrl: 'assets/images/mahidol.jpg',
    name: 'Mahidol University',
    country: ["30","20","10"],
    flag: ["🇮🇳", "🇭🇰","🇯🇵"]

  ),
  University(
      imageUrl: 'assets/images/chula.jpg',
      name: 'Chulalongkorn University',
      country: ["35","20","3"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
  University(
      imageUrl: 'assets/images/chiangmai.jpg',
      name: 'ChiangMai University',
      country: ["8","3","1"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
  University(
      imageUrl: 'assets/images/abac.jpg',
      name: 'ABAC University',
      country: ["50","24","20"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
  University(
      imageUrl: 'assets/images/bangkok.jpg',
      name: 'Bangkok University',
      country: ["44","25","20"],
      flag: ["🇮🇳", "🇭🇰","🇯🇵"]
  ),
];