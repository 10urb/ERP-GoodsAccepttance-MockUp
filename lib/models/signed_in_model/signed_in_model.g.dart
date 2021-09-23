// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedInModel _$SignedInModelFromJson(Map<String, dynamic> json) =>
    SignedInModel(
      token: json['token'] as String?,
      loginUser: json['loginUser'] == null
          ? null
          : LoginUser.fromJson(json['loginUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignedInModelToJson(SignedInModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'loginUser': instance.loginUser,
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
      id: json['id'] as int?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      image: json['image'],
      firstFireLink: json['firstFireLink'] as String?,
      organizasyonId: json['organizasyonId'],
      workYear: json['workYear'] as int?,
      ipAddress: json['ipAddress'] as String?,
      hostName: json['hostName'] as String?,
      sicilId: json['sicilId'],
      branch: json['branch'] as String?,
      organizationSchemaId: json['organizationSchemaId'] as int?,
    );

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'image': instance.image,
      'firstFireLink': instance.firstFireLink,
      'organizasyonId': instance.organizasyonId,
      'workYear': instance.workYear,
      'ipAddress': instance.ipAddress,
      'hostName': instance.hostName,
      'sicilId': instance.sicilId,
      'branch': instance.branch,
      'organizationSchemaId': instance.organizationSchemaId,
    };
