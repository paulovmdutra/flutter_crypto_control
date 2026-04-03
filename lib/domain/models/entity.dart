abstract class Entity<T extends Entity<T>> {
  
  int id;

  String? publicId;

  String get primaryKey => "id";

  String get entityName;

  dynamic get getValueId => id;

  Entity({this.id = 0, this.publicId});

  Map<String, dynamic> toMap();

  T fromJson(String source);

  String toJson();

  T fromMap(Map<String, dynamic> map);
}
