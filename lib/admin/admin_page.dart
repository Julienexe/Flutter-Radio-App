import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AdminRadioProgramPage extends StatefulWidget {
  @override
  _AdminRadioProgramPageState createState() => _AdminRadioProgramPageState();
}

class _AdminRadioProgramPageState extends State<AdminRadioProgramPage> {
  final TextEditingController _programNameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<Map<String, dynamic>> _programs = [];

  @override
  void initState() {
    super.initState();
    _loadPrograms();
  }

  Future<void> _loadPrograms() async {
    final file = await _getJsonFile();
    if (await file.exists()) {
      final content = await file.readAsString();
      setState(() {
        _programs = List<Map<String, dynamic>>.from(json.decode(content));
      });
    }
  }

  Future<File> _getJsonFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/radio_programs.json');
  }

  Future<void> _saveProgram() async {
    if (_programNameController.text.isEmpty || _selectedDate == null || _selectedTime == null) {
      _showErrorDialog("Please fill all fields");
      return;
    }

    final program = {
      'name': _programNameController.text,
      'date': _selectedDate!.toIso8601String(),
      'time': _selectedTime!.format(context),
    };

    setState(() {
      _programs.add(program);
    });

    final file = await _getJsonFile();
    await file.writeAsString(json.encode(_programs));

    _programNameController.clear();
    _selectedDate = null;
    _selectedTime = null;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Program added successfully!')));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 19, 30),
        title: Center(child: Text('Admin - Add Radio Program',style: TextStyle(color: Colors.white),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _programNameController,
              decoration: InputDecoration(
                labelText: 'Program Name',labelStyle: TextStyle(color: Colors.white)
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Pick a date'
                  : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],style: TextStyle(color: Colors.white),),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text(_selectedTime == null
                  ? 'Pick a time'
                  : 'Time: ${_selectedTime!.format(context)}',style: TextStyle(color: Colors.white),),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProgram,
              child: Text('Add Program'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _programs.length,
                itemBuilder: (context, index) {
                  final program = _programs[index];
                  return ListTile(
                    title: Text(program['name'],style: TextStyle(color: Colors.white),),
                    subtitle: Text(
                        'Date: ${program['date'].split('T')[0]}, Time: ${program['time']}',style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
