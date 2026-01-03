import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String id;
  final String name;
  final String description;
  final String instructions;
  final List<String> benefits;
  final int defaultBpm;
  final int minBpm;
  final int maxBpm;

  const Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.instructions,
    required this.benefits,
    this.defaultBpm = 60,
    this.minBpm = 40,
    this.maxBpm = 180,
  });

  @override
  List<Object?> get props => [id, name];
}
