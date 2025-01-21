
import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericResponse<T> {
  GenericResponse([
    this.status,
    this.message,
    this.errors,
    this.data,
  ]);

  factory GenericResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$GenericResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$GenericResponseToJson(this, toJsonT);

  //deserialize
  // final json = response.toJson((user) => user.toJson());
  @JsonKey(defaultValue: 0)
  final int? status;

  @JsonKey(defaultValue: '')
  final String? message;


  @JsonKey(defaultValue: null)
  final List<Object?>? errors;

  @JsonKey(defaultValue: null)
  final T? data;
}
