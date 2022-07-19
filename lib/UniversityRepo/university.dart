class University {
  int? id;
  String? name;
  String? thaiName;
  String? imageUrl;
  String? logo;
  String? province;
  String? description;
  String? map;
  String? numbers;

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

  University.fromJson(Map<String, Object?> json)
    : this(
    id: json['id']! as int,
    name: json['name']! as String,
    thaiName: json['thaiName']! as String,
    imageUrl: json['imageUrl']! as String,
    logo: json['logo']! as String,
    province: json['province']! as String,
    description: json['description']! as String,
    map: json['map']! as String,
    numbers: json['numbers']! as String,
  );

 /// this method just in case there's a problem with type dynamic
  Map<String, Object?> toJson() {
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
