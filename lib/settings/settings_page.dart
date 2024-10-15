import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 19, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 19, 30),
        title: Text('Settings',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Device Options'),
          _buildListTile('Set Sleep Timer', Icons.timer, () {
            // Action for sleep timer
          }),
          _buildListTile('Theme', Icons.color_lens, () {
            // Action for theme setting
          }),
          _buildSectionHeader('Audio Options'),
          _buildSwitchTile(
            'Auto-Play on App Launch',
            true, // Default value; will later be managed with real state
            (bool value) {
              // Toggle action for auto-play
            },
          ),
          _buildSwitchTile(
            'Enable Dynamic Stream',
            true, // Default value
            (bool value) {
              // Toggle action for dynamic stream
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Dynamic streaming allows your phone to request a lower quality signal when on mobile data',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            'Allow Push Notifications',
            false, // Default value
            (bool value) {
              // Toggle action for push notifications
            },
          ),
          _buildSectionHeader('More From Us'),
          _buildListTile('Privacy Policy', Icons.privacy_tip, () {
            // Action for privacy policy
          }),
          _buildAppVersionTile('v23.5.11'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
      leading: Icon(icon, color: Colors.white),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
      String title, bool currentValue, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      value: currentValue,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }

  Widget _buildAppVersionTile(String version) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('App Version', style: TextStyle(fontSize: 16, color: Colors.white)),
          Text(version, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
