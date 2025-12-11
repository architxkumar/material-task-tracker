import 'package:flutter/material.dart';

class TimeLabel extends StatelessWidget {
  final String label;
  final DateTime? dateTime;

  const TimeLabel({super.key, required this.label, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.0,
      children: [
        const Icon(
          Icons.access_time,
          size: 16.0,
        ),
        Text(
          '$label: ${dateTime?.month}/${dateTime?.day}/${dateTime?.year} ${dateTime?.hour}:${dateTime?.minute.toString().padLeft(2, '0')}',
          style: TextTheme.of(context).bodyMedium,
        ),
      ],
    );
  }
}