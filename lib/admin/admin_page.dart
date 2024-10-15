import 'package:flutter/material.dart'; 
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';


class AdminContentUploadPage extends StatefulWidget {
  @override
  _AdminContentUploadPageState createState() => _AdminContentUploadPageState();
}

class _AdminContentUploadPageState extends State<AdminContentUploadPage> {
  final _formKey = GlobalKey<FormState>();
  String _channelName = '';
  String _streamUrl = '';
  DateTime _scheduledTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                label: 'Channel Name',
                onChanged: (value) {
                  _channelName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a channel name';
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: 'Stream URL',
                onChanged: (value) {
                  _streamUrl = value;
                },
                validator: (value) {
                  if (value == null || !Uri.tryParse(value)!.hasAbsolutePath ?? true) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              _buildDateTimePicker(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _submitContent();
                  }
                },
                child: Text('Submit Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return ListTile(
      title: Text('Scheduled Time'),
      subtitle: Text(_scheduledTime.toString()),
      trailing: Icon(Icons.calendar_today),
      onTap: () {
        DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            onConfirm: (date) {
              setState(() {
                _scheduledTime = date;
              });
            },
            currentTime: _scheduledTime,
            locale: LocaleType.en);
      },
    );
  }

  void _submitContent() {
    // Here you'd send the data (_channelName, _streamUrl, _scheduledTime)
    // to your backend or database.
    print('Channel Name: $_channelName');
    print('Stream URL: $_streamUrl');
    print('Scheduled Time: $_scheduledTime');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Content Submitted')));
  }
}
