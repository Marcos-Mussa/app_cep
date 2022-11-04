import 'package:cep_app/models/endereco_models.dart';

abstrac class CepRepository {
  Future <EnderecoModels> getCep(String cep);
}