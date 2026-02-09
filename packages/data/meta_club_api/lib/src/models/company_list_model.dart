import 'package:equatable/equatable.dart';

class CompanyListModel extends Equatable {
  final bool? result;
  final String? message;
  final List<Company>? companyList;

  const CompanyListModel({this.result, this.message, this.companyList});

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
        result: json["result"],
        message: json["message"],
        companyList: json["data"] == null ? [] : List<Company>.from(json["data"]!.map((x) => Company.fromJson(x))),
      );

  @override
  List<Object?> get props => [
        result,
        message,
      ];

  Map<String, dynamic> toJson() =>
      {"result": result, "message": message, "data": companyList?.map((e) => e.toJson()).toList()};
}

class Company extends Equatable {
  final int? id;
  final String? companyName;
  final String? subdomain;
  final String? url;
  final String? logo;
  final String? appName;
  final String? fontFamily;
  final Map<String, dynamic>? colors;

  const Company(
      {this.id, this.companyName, this.subdomain, this.url, this.logo, this.appName, this.fontFamily, this.colors});

  Company copyWith({Map<String, dynamic>? colors,String? fontFamily}) {
    return Company(
        id: id,
        companyName: companyName,
        subdomain: subdomain,
        url: url,
        logo: logo,
        appName: appName,
        fontFamily: fontFamily ?? this.fontFamily,
        colors: colors ?? this.colors);
  }

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        companyName: json["company_name"],
        subdomain: json["subdomain"],
        url: json["url"],
        logo: json["logo_url"],
        appName: json["app_name"],
        colors: json["branding"],
        fontFamily: json["font_family"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "subdomain": subdomain,
        "url": url,
        "branding": colors,
        "logo_url": logo,
        "app_name": appName,
        "font_family": fontFamily
      };

  @override
  List<Object?> get props => [id, companyName, subdomain, url, logo, appName, fontFamily, colors];
}
