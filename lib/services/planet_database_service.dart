import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/planet_model.dart';

// PlanetDatabase Class to represent the planet database.
class PlanetDatabase {
  // Instance of the database.
  static Database? _db;

  // Getter for the database.
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB('planets.db');
    return _db!;
  }

  // Method to initialize the database.
  Future<Database> _initDB(String pathName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, pathName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Method to create the database.
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE planets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        size REAL NOT NULL,
        distanceFromSun REAL NOT NULL,
        nickname TEXT
      )
    ''');
  }

  // Method to add a planet to the database.
  Future<void> addPlanet(Planet planet) async {
    final db = await this.db;
    await db.insert('planets', planet.toMap());
  }

  // Method to get the list from the database.
  Future<List<Planet>> readPlanets() async {
    final db = await this.db;
    final list = await db.query('planets');
    return list.map((map) => Planet.fromMap(map)).toList();
  }

  // Method to delete a planet from the database.
  Future<void> deletePlanet(int id) async {
    final db = await this.db;
    await db.delete('planets', where: 'id = ?', whereArgs: [id]);
  }

  // Method to edit a planet from the database.
  Future<void> editPlanet(Planet planet) async {
    final db = await this.db;
    await db.update('planets', planet.toMap(),
        where: 'id = ?', whereArgs: [planet.id]);
  }
}
