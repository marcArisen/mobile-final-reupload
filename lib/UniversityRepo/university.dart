class University2 {
  int? id;
  String? name;
  String? province;
  String? description;
  String? map;
  int? numbers;

  University2({
    this.id,
    this.name,
    this.province,
    this.description,
    this.map,
    this.numbers,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "province": province,
      "description": description,
      "map": map,
      "numbers": numbers,
    };
  }
}
