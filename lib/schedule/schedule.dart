import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // For caching images

//const Color bgcolor = Color.fromARGB(255, 10, 19, 30);

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _selectedDayIndex = 1; // Default selected day index (Monday)

  final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final List<String> dates = [
    '13 Oct',
    '14 Oct',
    '15 Oct',
    '16 Oct',
    '17 Oct',
    '18 Oct',
    '19 Oct'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 19, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 19, 30),
        title: Text("Schedule",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          Expanded(child: _buildScheduleList()),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      height: 65,
      color: const Color.fromARGB(255, 10, 19, 30),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedDayIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = index;
              });
            },
            child: Container(
              height: 65,
              width: 70,
              margin: EdgeInsets.only(
                  left: 8, right: index == days.length - 1 ? 8 : 0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    dates[index],
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleList() {
    List<Map<String, String>> schedule = [
      {
        'title': 'Restoring Lives',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOwRConBYl2t6L8QMOAQqa5FDmPB_bg7EnGA&s',
        'time': '1:00am - 2:00am',
      },
      {
        'title': 'Turning Point',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOwRConBYl2t6L8QMOAQqa5FDmPB_bg7EnGA&s',
        'time': '2:00am - 2:30am',
      },
      {
        'title': 'Restart',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOwRConBYl2t6L8QMOAQqa5FDmPB_bg7EnGA&s',
        'time': '2:30am - 3:00am',
      },
      {
        'title': 'Overcoming Crisis',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOwRConBYl2t6L8QMOAQqa5FDmPB_bg7EnGA&s',
        'time': '3:00am - 3:30am',
      },
      {
        'title': 'Challenge of the Cross',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOwRConBYl2t6L8QMOAQqa5FDmPB_bg7EnGA&s',
        'time': '3:30am - 4:00am',
      },
      {
        'title': 'Spiritual Warfare',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOwRConBYl2t6L8QMOAQqa5FDmPB_bg7EnGA&s',
        'time': '4:00am - 4:30am',
      },
    ];

    return ListView.builder(
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height:90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScheduleItem(schedule[index]),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScheduleItem(Map<String, String> item) {
    String imageUrl = item['image'] ?? 'https://example.com/image2.png';
    return ListTile(
      leading: imageUrl.isNotEmpty
          ? CachedNetworkImage(
            
              fit: BoxFit.fill,
              imageUrl: item['image']!,
              width: 70,
              height: 70,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Container(
              width: 50,
              height: 50,
              color: Colors.grey[700],
              child: Icon(Icons.image_not_supported, color: Colors.white),
            ),
      title: Text(item['title'] ?? '', style: TextStyle(color: Colors.white,fontSize: 20)),
      subtitle:
          Text(item['time'] ?? '', style: TextStyle(color: Colors.white60)),
      onTap: () {
        // Navigate to details or play the selected show
      },
    );
  }
}
