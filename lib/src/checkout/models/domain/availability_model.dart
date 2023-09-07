import 'package:equatable/equatable.dart';

class AvailabilityModel extends Equatable {
  final String? date;
  final List<dynamic>? times;

  const AvailabilityModel({this.date, this.times});

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      date: json['date'] as String?,
      times: json['times'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'times': times,
      };

  @override
  List<Object?> get props => [date, times];
}
