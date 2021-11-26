import 'package:equatable/equatable.dart';

class ProductionCompanyModel extends Equatable {
    ProductionCompanyModel({
        required this.name,
        required this.id,
        required this.logoPath,
        required this.originCountry,
    });

    String name;
    int id;
    String logoPath;
    String originCountry;

    factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) => ProductionCompanyModel(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
        "origin_country": originCountry,
    };

    @override
    List<Object> get props => [name, id, logoPath, originCountry];
}