import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 19, 30),
        title: Text('Schedule', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Horizontal Days Selector (as seen in the screenshot)
          Container(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildDayButton("Sun", "13 Oct", isSelected: false),
                _buildDayButton("Mon", "14 Oct", isSelected: true),
                _buildDayButton("Tue", "15 Oct", isSelected: false),
                _buildDayButton("Wed", "16 Oct", isSelected: false),
                _buildDayButton("Thu", "17 Oct", isSelected: false),
                // Add more days here as needed
              ],
            ),
          ),
          // Programs List
          Expanded(
            child: ListView.builder(
              itemCount: _programs.length,
              itemBuilder: (context, index) {
                final program = _programs[index];
                return _buildProgramItem(
                  program['name'],
                  program['date'],
                  program['time'],
                  'Freedom On Air', // Placeholder subtitle
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton(String day, String date, {required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(day, style: TextStyle(color: Colors.white)),
          SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(date, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramItem(String title, String date, String time, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // Placeholder Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300], // Placeholder color for images
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.radio, size: 30, color: Colors.grey[600]),
          ),
          SizedBox(width: 16),
          // Program Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$time", // Display time like 1:00am - 2:00am
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  title, // Program title
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle, // Placeholder subtitle
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
