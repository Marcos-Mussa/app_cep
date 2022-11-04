import 'dart:convert';
import 'dart:core';
import 'dart:html';
import 'dart:io';

class EnderecoModels {
  final String cep;
  final String logradouro;
  final String complemento;

  EnderecoModels({
    required this.cep,
    required this.logradouro,
    required this.complemento,
  });

  Map<String.dynamic> toMap() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
    };
  }

  factory EnderecoModels.fromMap(Map<String, dynamic> map) {
    return EnderecoModels(
      cep: map['cep'] ?? '',
      logradouro: map['logradouro'] ?? '',
      complemento: map['complemento'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModels.fromJson(String json) =>
      EnderecoModels.fromMap(json.decode(source));
}
