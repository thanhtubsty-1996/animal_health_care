import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animal_health_app/domain/entities/appointment.dart';

class MedicalExaminationScreen extends StatefulWidget {
  const MedicalExaminationScreen({super.key});

  @override
  State<MedicalExaminationScreen> createState() => _MedicalExaminationScreenState();
}

class _MedicalExaminationScreenState extends State<MedicalExaminationScreen> {
  late Future<List<Appointment>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = _getAppointments();
  }

  Future<List<Appointment>> _getAppointments() async {
    // Dữ liệu giả
    return [
      Appointment(id: '1', customerId: '1', petId: '1', customerName: 'Nguyễn Văn A', petName: 'Mèo Tom', appointmentDate: DateTime.now(), reasonForVisit: 'Kiểm tra sức khỏe định kỳ', status: 'Đã hoàn thành'),
      Appointment(id: '2', customerId: '2', petId: '2', customerName: 'Trần Thị B', petName: 'Chó Jerry', appointmentDate: DateTime.now().add(const Duration(days: 1)), reasonForVisit: 'Tiêm phòng', status: 'Đã lên lịch'),
      Appointment(id: '3', customerId: '3', petId: '3', customerName: 'Lê Văn C', petName: 'Vẹt Spike', appointmentDate: DateTime.now().subtract(const Duration(days: 1)), reasonForVisit: 'Bị thương ở cánh', status: 'Đã hủy'),
    ];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Đã hoàn thành':
        return Colors.green;
      case 'Đã hủy':
        return Colors.red;
      case 'Đã lên lịch':
      default:
        return Colors.blue;
    }
  }

  IconData _getStatusIcon(String status) {
     switch (status) {
      case 'Đã hoàn thành':
        return Icons.check_circle_outline;
      case 'Đã hủy':
        return Icons.cancel_outlined;
      case 'Đã lên lịch':
      default:
        return Icons.watch_later_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch khám bệnh'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Appointment>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có lịch khám nào.'));
          }

          final appointments = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: appointments.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Card(
                 elevation: 2,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                 child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DateFormat('dd', 'vi_VN').format(appointment.appointmentDate),
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('MMM', 'vi_VN').format(appointment.appointmentDate).toUpperCase(),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  title: Text(
                    '${appointment.petName} (Chủ: ${appointment.customerName})',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(appointment.reasonForVisit),
                  trailing: Chip(
                    avatar: Icon(_getStatusIcon(appointment.status), size: 16, color: Colors.white),
                    label: Text(appointment.status, style: const TextStyle(color: Colors.white)),
                    backgroundColor: _getStatusColor(appointment.status),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onTap: () {
                    // Điều hướng đến chi tiết cuộc hẹn trong tương lai
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
