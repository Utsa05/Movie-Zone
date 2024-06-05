import 'package:equatable/equatable.dart';
import 'package:movie_zone/enums/app-error-type.dart';

class AppError extends Equatable {
  final String message;
  final AppErrorType errorType;

  const AppError({required this.message, required this.errorType});
  @override
  List<Object?> get props => [errorType];
}
