import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            _buildStatColumn("Posts", "520"),
            _buildStatColumn("Followers", "28.5K"),
            _buildStatColumn("Following", "134"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: Colors.purpleAccent,
            ),
          ),
        ],
      ),
    );
  }
}