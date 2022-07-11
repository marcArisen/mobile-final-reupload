class University {
  int? id;
  String? name;
  String? thaiName;
  String? imageUrl;
  String? logo;
  String? province;
  String? description;
  String? map;
  Map? numbers;

  University({
    this.id,
    this.name,
    this.thaiName,
    this.imageUrl,
    this.logo,
    this.province,
    this.description,
    this.map,
    this.numbers,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "thaiName": thaiName,
      "imageUrl": imageUrl,
      "logo": logo,
      "province": province,
      "description": description,
      "map": map,
      "numbers": numbers,
    };
  }
}
