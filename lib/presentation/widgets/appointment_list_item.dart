import 'package:flutter/material.dart';

class AppointmentListItem extends StatelessWidget {
  final String petName;
  final String customerName;
  final String time;
  final VoidCallback onTap;

  const AppointmentListItem({
    super.key,
    required this.petName,
    required this.customerName,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          child: Icon(Icons.pets),
        ),
        title: Text(petName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(customerName),
        trailing: Text(time),
      ),
    );
  }
}
