import 'package:equatable/equatable.dart';
import 'package:tago/app.dart';

class AuthUserState extends Equatable {
  final String? errorMessage;
  final bool isLoading;
  final bool? isSuccess;

  const AuthUserState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        errorMessage,
        isLoading,
        errorMessage,
      ];
}
