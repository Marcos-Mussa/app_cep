import 'dart:async';
import 'dart:ffi';

import 'package:cep_app/models/endereco_models.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  constHomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModels? enderecoModels;
  bool loading = false;

  final fornKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  Void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar CEP'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: fornKey,
          child: Column(
            children: [
              TextFormField(
                controller: cepEC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'CEP Obrigatorio';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                    final valid = fornKey.currentState?.validate() ?? false;
                    if(valid){
                      try {
                        setState(() {
                          loading = true;
                        });
                      final endereco = await cepRepository.getCep(cepEC.text);
                      setState(() {
                        loading = false;
                        enderecoModels = endereco;
                      });
                      } catch (e) {
                        setState(() {
                          loading = false;
                          enderecoModels = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao buscar endereco')),
                        );
                      }
                  }
                },
                child: const Text('Buscar'),
              )
              Visibility(
                visible: loading,
                child: const CircularProgressIndicator(),
              )
              Visibility(
                visible: enderecoModels != null,
                child: Text(
                  '$(enderecoModels?.logradouro) $(enderecoModels?.complemento) $(enderecoModels?.cep)', 
                ),
              )
              )
            ],
          ),
        ),
    ));
  }
}
