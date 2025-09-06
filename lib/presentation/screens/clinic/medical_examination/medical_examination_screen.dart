
import 'package:flutter/material.dart';

/// Màn hình chính cho quy trình Khám bệnh.
class MedicalExaminationScreen extends StatelessWidget {
  const MedicalExaminationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(
        title: Text('Khám bệnh'),
      ),
      body: Center(
        child: Text('Medical Examination Feature'),
      ),
    );
  }
}
