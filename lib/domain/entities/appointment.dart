import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String id;
  final String petId;
  final String customerId;
  final String petName;
  final String customerName;
  final DateTime appointmentDate;
  final String reasonForVisit;
  final String status; // Ví dụ: 'Scheduled', 'Completed', 'Cancelled'

  const Appointment({
    required this.id,
    required this.petId,
    required this.customerId,
    required this.petName,
    required this.customerName,
    required this.appointmentDate,
    required this.reasonForVisit,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        petId,
        customerId,
        petName,
        customerName,
        appointmentDate,
        reasonForVisit,
        status,
      ];
}
