import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') @JsonKey(name: 'accessToken') String accessToken,
    @Default('') @JsonKey(name: 'refreshToken') String refreshToken,
    @Default('') @JsonKey(name: 'id') int id,
    @Default('') @JsonKey(name: 'username') String username,
    @Default('') @JsonKey(name: 'email') String email,
    @Default('') @JsonKey(name: 'firstName') String firstName,
    @Default('') @JsonKey(name: 'lastName') String lastName,
    @Default('') @JsonKey(name: 'gender') String gender,
    @Default('') @JsonKey(name: 'image') String image,
    @Default('') @JsonKey(name: 'error') String error,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}