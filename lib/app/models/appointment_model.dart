import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  Appointment({
    this.id,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.size = '',
    this.dateRange = '',
    this.description = '',
    this.pictures = const <String>[],
    this.placement = '',
    this.suggestedDate = '',
    this.suggestedTime = '',
    this.appointmentConfirmed = false,
    this.appointmentFinished = false,
    this.isFavorite = false,
    this.gender = 'M',
  });

  factory Appointment.fromFirestore(DocumentSnapshot<dynamic> snapshot) {
    final Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return Appointment(
      name: data!['name'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      appointmentFinished: data['appointment_finished'] as bool?,
      appointmentConfirmed: data['appointment_confirmed'] as bool?,
      isFavorite: data['is_favorite'] as bool?,
      suggestedTime: data['suggested_time'] as String?,
      suggestedDate: data['suggested_date'] as String?,
      placement: data['placement'] as String?,
      id: snapshot.id,
      description: data['description'] as String?,
      dateRange: data['date_range'] as String?,
      size: data['size'] as String?,
      gender: data['gender'] as String?,
      pictures: data['pictures'] != null ? data['pictures'] as List<dynamic>? : <dynamic>[],
    );
  }

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? description;
  final String? placement;
  final String? size;
  final List<dynamic>? pictures;
  final bool? appointmentConfirmed;
  final bool? appointmentFinished;
  final bool? isFavorite;
  final String? dateRange;
  final String? suggestedTime;
  final String? suggestedDate;
  final String? gender;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      if (description != null) 'description': description,
      if (placement != null) 'placement': placement,
      if (size != null) 'size': size,
      'pictures': pictures,
      'gender': gender,
      'date_range': dateRange,
      'appointment_confirmed': appointmentConfirmed,
      'is_favorite': isFavorite,
      'appointment_finished': appointmentFinished,
      'suggested_date': suggestedDate,
      'suggested_time': suggestedTime,
    };
  }
}
