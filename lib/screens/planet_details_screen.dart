import 'package:flutter/material.dart';
import '../models/planet_model.dart';

// PlanetDetailsScreen Class to represent the planet details screen.
class PlanetDetailsScreen extends StatefulWidget {
  final Planet planet; // Object to show.
  const PlanetDetailsScreen({
    super.key,
    required this.planet,
  });

  @override
  State<PlanetDetailsScreen> createState() => _PlanetDetailsScreenState();
}

// PlanetDetailsScreenState Class to represent the planet details screen state.
class _PlanetDetailsScreenState extends State<PlanetDetailsScreen> {
  // Planet Object.
  late Planet _planet;

  // Initialize the planet object.
  @override
  void initState() {
    _planet = widget.planet;
    super.initState();
  }
  
  // Build method.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_planet.name} Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Planet name.
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text("Name"),
              subtitle: Text(_planet.name),
            ),
            // Planet size.
            ListTile(
              leading: const Icon(Icons.landscape),
              title: const Text("Size"),
              subtitle: Text("${_planet.size} km"),
            ),
            // Planet nickname.
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text("Nickname"),
              subtitle: Text(_planet.nickname ?? 'No Nickname'),
            ),
            // Planet distance from sun.
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text("Distance from Sun"),
              subtitle: Text("${_planet.distanceFromSun} Astronomical Units"),
            ),
          ],
        ),
      ),
    );
  }
}
