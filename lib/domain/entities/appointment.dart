import 'package:equatable/equatable.dart';

enum AppointmentStatus { scheduled, completed, cancelled }

class Appointment extends Equatable {
  final String id;
  final String petId;
  final String customerId;
  final DateTime dateTime;
  final String reason;
  final AppointmentStatus status;

  const Appointment({
    required this.id,
    required this.petId,
    required this.customerId,
    required this.dateTime,
    required this.reason,
    required this.status,
  });

  @override
  List<Object?> get props => [id, petId, customerId, dateTime, reason, status];
}
