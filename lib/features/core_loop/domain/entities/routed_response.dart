import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/utils/type_defs.dart';

class RoutedResponse extends Equatable {
  const RoutedResponse({
    required this.text,
    required this.role,
    required this.meta,
  });

  final String text;
  final String role;
  final DataMap meta;

  @override
  List<Object?> get props => [text, role, meta];
}
