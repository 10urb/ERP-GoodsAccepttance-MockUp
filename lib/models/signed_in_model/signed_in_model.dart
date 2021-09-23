import 'package:json_annotation/json_annotation.dart';

part 'signed_in_model.g.dart';

@JsonSerializable()
class SignedInModel {
  String? token;
  LoginUser? loginUser;

  SignedInModel({this.token, this.loginUser});

  factory SignedInModel.fromJson(Map<String, dynamic> json) =>
      _$SignedInModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignedInModelToJson(this);
}

@JsonSerializable()
class LoginUser {
  int? id;
  String? name;
  String? surname;
  dynamic image;
  String? firstFireLink;
  dynamic organizasyonId;
  int? workYear;
  String? ipAddress;
  String? hostName;
  dynamic sicilId;
  String? branch;
  int? organizationSchemaId;

  LoginUser({
    this.id,
    this.name,
    this.surname,
    this.image,
    this.firstFireLink,
    this.organizasyonId,
    this.workYear,
    this.ipAddress,
    this.hostName,
    this.sicilId,
    this.branch,
    this.organizationSchemaId,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);
}
