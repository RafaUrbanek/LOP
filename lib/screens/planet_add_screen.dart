import 'package:flutter/material.dart';
import '../services/planet_database_service.dart';
import '../models/planet_model.dart';

// PlanetAddScreen Class to represent the planet addition/edition screen.
class PlanetAddScreen extends StatefulWidget {
  final Planet planet; // Object to edit.
  final bool edit; // True if edition, false if addition.
  final Function addedPlanet; // Function to call when a planet is added.
  const PlanetAddScreen({
    super.key,
    required this.planet,
    required this.addedPlanet,
    required this.edit,
  });

  @override
  State<PlanetAddScreen> createState() => _PlanetAddScreenState();
}

// PlanetAddScreenState Class to represent the planet addition/edition screen state.
class _PlanetAddScreenState extends State<PlanetAddScreen> {
  // Global Key.
  final _formKey = GlobalKey<FormState>();
  // Controllers.
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _distanceController = TextEditingController();
  // Planet Object.
  late Planet _planet;

  // Initialize the planet object.
  @override
  void initState() {
    _planet = widget.planet;
    // Initializing fields for edit case.
    if (widget.edit) {
      _nameController.text = _planet.name;
      _sizeController.text = _planet.size.toString();
      _nicknameController.text = _planet.nickname ?? '';
      _distanceController.text = _planet.distanceFromSun.toString();
    }
    super.initState();
  }

  // Freeing memory.
  @override
  void dispose() {
    _nameController.dispose();
    _sizeController.dispose();
    _nicknameController.dispose();
    _distanceController.dispose();
    super.dispose();
  }

  // Method for adding a planet to the database.
  Future<void> _addPlanet() async {
    await PlanetDatabase().addPlanet(_planet);
  }

  // Method for editing a planet in the database.
  Future<void> _editPlanet() async {
    await PlanetDatabase().editPlanet(_planet);
  }

  // Method to show the addition success dialog box.
  void showAddPlanetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Planet Added Successfully!'),
          content: const Text('Do you want to add more planets or return to the home page?'),
          actions: [
            // Retunr to home page button.
            ElevatedButton(
              child: const Text("Return to home page"),
              onPressed: () {
                // Return to home page.
                Navigator.of(dialogContext).pop(); // Close the dialog.
                Navigator.of(context).pop(); // Return to home page.
                widget.addedPlanet();
              },
            ),
            const SizedBox(height: 16),
            // Add more planets button.
            ElevatedButton(
              child: const Text("Add more planets"),
              onPressed: () {
                // Stay on page to add more planets.
                Navigator.of(dialogContext).pop(); // Only close the dialog.
              },
            ),
          ],
        );
      },
    );
  }

  // Submit button procedure.
  void _submitForm() {
    // Fields Validation.
    if (_formKey.currentState!.validate()) {
      // Saving fields data.
      _formKey.currentState!.save();

      // New planet case.
      if (!widget.edit) {
        _addPlanet(); // Saving data to the database.
        showAddPlanetDialog(context); // Sucessfull mensage.
      }
      // Case editing an existing planet.
      else {
        _editPlanet(); // Saving data to the database.
        // Sucessfull mensage.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Planet edited successfully!'),
          ),
        );
        Navigator.of(context).pop(); // Return to home page.
        widget.addedPlanet(); // Update list.
      }

      // Clear all fields
      _formKey.currentState!.reset();
    }
  }

  // Method to create the decoration for the fields.
  InputDecoration _fieldDecoration(String labelText) {
    Widget? helperText;

    // Helper text for distance from sun field.
    if (labelText == 'Distance from Sun (AU)') {
      helperText = const Text('in Astronomical Units');
    }

    return InputDecoration(
      labelText: labelText,
      filled: true,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE0E1DD)),
      ),
      helper: helperText,
    );
  }

  // Build method.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App-bar
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Planet'),
      ),
      // Body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Spacer
              const SizedBox(height: 16),
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: _fieldDecoration('Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planet.name = value!;
                },
              ),
              // Spacer
              const SizedBox(height: 16),
              // Size field
              TextFormField(
                controller: _sizeController,
                decoration: _fieldDecoration('Size (km)'),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the size';
                  }
                  if (double.tryParse(value) == null ||
                      double.tryParse(value)! < 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planet.size = double.parse(value!);
                },
              ),
              // Spacer
              const SizedBox(height: 16),
              // Nickname field
              TextFormField(
                controller: _nicknameController,
                decoration: _fieldDecoration('Nickname'),
                onSaved: (value) {
                  _planet.nickname = value;
                },
              ),
              // Spacer
              const SizedBox(height: 16),
              // Distance from Sun field
              TextFormField(
                controller: _distanceController,
                decoration: _fieldDecoration('Distance from Sun (AU)'),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the distance from the sun';
                  }
                  if (double.tryParse(value) == null ||
                      double.tryParse(value)! < 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planet.distanceFromSun = double.parse(value!);
                },
              ),
              // Spacer
              const SizedBox(height: 32),
              // Submit/Cancel Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.addedPlanet(); // Update the list for security.
                    },
                    child: const Text("Cancel"),
                  ),
                  // Submit button
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(widget.edit ? "Save Changes" : "Add Planet"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
