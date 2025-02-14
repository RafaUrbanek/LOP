// Planet Class to represent a planet.
class Planet {
  // Attributes.
  int? id;  // Attribute for identifying the planet used in the database (not available to the user).
  String name; // Name of the planet.
  double size;  // Size of the planet.
  double distanceFromSun; // Distance of the planet from the sun.
  String? nickname; // Nickname of the planet, Optional attribute.

  // Planet Class constructor.
  Planet({
    this.id,
    required this.name,
    required this.size,
    required this.distanceFromSun,
    this.nickname,
  });

  // Alternative constructor with all attributes empty.
  Planet.empty()
      : id = null,
        name = '',
        size = 0,
        distanceFromSun = 0,
        nickname = '';

  // Method to convert the planet object to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'distanceFromSun': distanceFromSun,
      'nickname': nickname,
    };
  }

  // Method to convert a map to a planet object.
  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
      id: map['id'],
      name: map['name'],
      size: map['size'],
      distanceFromSun: map['distanceFromSun'],
      nickname: map['nickname'],
    );
  }
}
