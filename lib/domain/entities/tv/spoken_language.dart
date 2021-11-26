import 'package:equatable/equatable.dart';

class SpokenLanguage extends Equatable {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  @override
  List<Object> get props => [
        iso6391,
        name,
      ];
}
