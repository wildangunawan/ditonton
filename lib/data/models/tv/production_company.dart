import 'package:ditonton/domain/entities/tv/production_company.dart';
import 'package:equatable/equatable.dart';

class ProductionCompanyModel extends Equatable {
  ProductionCompanyModel({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  final String name;
  final int id;
  final String? logoPath;
  final String originCountry;

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) =>
      ProductionCompanyModel(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath,
        "origin_country": originCountry,
      };

  ProductionCompany toEntity() {
    return ProductionCompany(
        id: id, logoPath: logoPath, name: name, originCountry: originCountry);
  }

  @override
  List<Object?> get props => [name, id, logoPath, originCountry];
}
