import 'package:equatable/equatable.dart';

class TimesModel extends Equatable {
  final String? startTime;
  final String? endTime;
  final String? period;
  final bool? status;

  const TimesModel({
    this.startTime,
    this.endTime,
    this.period,
    this.status,
  });

  factory TimesModel.fromJson(Map<String, dynamic> json) => TimesModel(
        startTime: json['startTime'] as String?,
        endTime: json['endTime'] as String?,
        period: json['period'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'startTime': startTime,
        'endTime': endTime,
        'period': period,
        'status': status,
      };

  @override
  List<Object?> get props => [startTime, endTime, period, status];
}
