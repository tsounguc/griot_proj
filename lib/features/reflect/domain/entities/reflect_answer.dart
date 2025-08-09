import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/utils/type_defs.dart';

class ReflectAnswer extends Equatable {
  const ReflectAnswer({
    required this.text,
    required this.meta,
  });

  final String text;
  final DataMap meta;

  @override
  List<Object?> get props => [text, meta];
}
