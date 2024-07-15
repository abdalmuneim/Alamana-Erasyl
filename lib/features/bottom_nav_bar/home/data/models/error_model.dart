// To parse this JSON data, do
//
//     final errorModel = errorModelFromMap(jsonString);

import 'dart:convert';

ErrorModel errorModelFromMap(String str) =>
    ErrorModel.fromMap(json.decode(str));

String errorModelToMap(ErrorModel data) => json.encode(data.toMap());

class ErrorModel {
  ErrorModel({
    this.error,
  });

  final ErrorModelError? error;

  ErrorModel copyWith({
    ErrorModelError? error,
  }) =>
      ErrorModel(
        error: error ?? this.error,
      );

  factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
        error: json["error"] == null
            ? null
            : ErrorModelError.fromMap(json["error"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error?.toMap(),
      };
}

class ErrorModelError {
  ErrorModelError({
    this.code,
    this.message,
    this.errors,
    this.status,
  });

  final int? code;
  final String? message;
  final List<ErrorElement>? errors;
  final String? status;

  ErrorModelError copyWith({
    int? code,
    String? message,
    List<ErrorElement>? errors,
    String? status,
  }) =>
      ErrorModelError(
        code: code ?? this.code,
        message: message ?? this.message,
        errors: errors ?? this.errors,
        status: status ?? this.status,
      );

  factory ErrorModelError.fromMap(Map<String, dynamic> json) => ErrorModelError(
        code: json["code"],
        message: json["message"],
        errors: json["errors"] == null
            ? []
            : List<ErrorElement>.from(
                json["errors"]!.map((x) => ErrorElement.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "errors": errors == null
            ? []
            : List<dynamic>.from(errors!.map((x) => x.toMap())),
        "status": status,
      };
}

class ErrorElement {
  ErrorElement({
    this.message,
    this.domain,
    this.reason,
  });

  final String? message;
  final String? domain;
  final String? reason;

  ErrorElement copyWith({
    String? message,
    String? domain,
    String? reason,
  }) =>
      ErrorElement(
        message: message ?? this.message,
        domain: domain ?? this.domain,
        reason: reason ?? this.reason,
      );

  factory ErrorElement.fromMap(Map<String, dynamic> json) => ErrorElement(
        message: json["message"],
        domain: json["domain"],
        reason: json["reason"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "domain": domain,
        "reason": reason,
      };
}
