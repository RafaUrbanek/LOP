import 'package:flutter/material.dart';
import '../models/planet_model.dart';
import '../screens/planet_add_screen.dart';
import '../screens/planet_details_screen.dart';
import '../services/planet_database_service.dart';

// PlanetListScreen Class to represent the planet list screen.
class PlanetListScreen extends StatefulWidget {
  const PlanetListScreen({super.key});

  @override
  State<PlanetListScreen> createState() => _PlanetListScreenState();
}

// PlanetListScreenState Class to represent the planet list screen state.
class _PlanetListScreenState extends State<PlanetListScreen> {
  // Planets list
  List<Planet> _planets = [];

  // Method to initialize the state.
  @override
  void initState() {
    super.initState();
    // Update planet list.
    _loadPlanets();
  }

  // Method to load planets from the database.
  Future<void> _loadPlanets() async {
    final list = await PlanetDatabase().readPlanets();
    setState(() {
      _planets = list;
    });
  }

  // Method to open the planet addition page.
  void _addPlanetScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PlanetAddScreen(
              edit: false, // New planet case.
              planet: Planet.empty(), // Empty planet.
              addedPlanet: () {
                _loadPlanets(); // Update list function.
              },
            ),
      ),
    );
  }

  // Method to delete a planet.
  void _deletePlanet(int id) async {
    await PlanetDatabase().deletePlanet(id);
    _loadPlanets();
  }

  // Method to open the planet edition page.
  void _editPlanet(BuildContext context, Planet planet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PlanetAddScreen(
              edit: true, // Edition case.
              planet: planet, // Planet to edit.
              addedPlanet: () {
                _loadPlanets(); // Update list function.
              },
            ),
      ),
    );
  }

  // Method to show the delete planet dialog.
  void showDeletePlanetDialog(BuildContext context, Planet planet) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Planet'),
          content: const Text('Are you sure you want to delete this planet?'),
          actions: [
            // Cancel button.
            ElevatedButton(
              onPressed: () {
                // Cancel deletion and return to the home page.
                Navigator.of(dialogContext).pop(); // Close the dialog.
              },
              child: const Text("No"),
            ),
            // Delete button.
            ElevatedButton(
              onPressed: () {
                // Delete planet and return to the home page.
                _deletePlanet(planet.id!); // Delete planet.
                Navigator.of(dialogContext).pop(); // close the dialog.
                // Show a success message.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Planet deleted successfully!')),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  // Method to build the planet list screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('My Planets')),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: _planets.length,
        itemBuilder: (context, index) {
          final planet = _planets[index];
          return ListTile(
            title: Text(planet.name),
            subtitle: Text(planet.nickname ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit button.
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editPlanet(context, planet),
                ),
                // Delete button.
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => showDeletePlanetDialog(context, planet),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFE0E1DD), width: 1.0),
              borderRadius: BorderRadius.circular(40),
            ),
            // Details screen.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetDetailsScreen(planet: planet),
                ),
              );
            },
          );
        },
        // Spacing between items.
        separatorBuilder:
            (BuildContext context, int index) => const SizedBox(height: 10),
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        height: 60,
        child: Text(
          'Add Planet',
          textAlign: TextAlign.center,
          style: TextStyle(height: 4.3),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _addPlanetScreen(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
