import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_forma_pagamento_controller.g.dart';

class CadastroFormaPagamentoController = _CadastroFormaPagamentoController with _$CadastroFormaPagamentoController;

abstract class _CadastroFormaPagamentoController with Store {
  TextEditingController tecDescricao = TextEditingController();
  TextEditingController tecNumeroParcelas = TextEditingController();
  TextEditingController tecCodigo = TextEditingController();

  final formKeyFormaPagamento = GlobalKey<FormState>();

  final _formaPagamentoRepository = GenericRepository(
    endpoint: "forma_pagamento",
    fromJson: (p0) => FormaPagamento.fromJson(p0),
  );

  @observable
  bool isLoading = false;

  @observable
  bool isAtivo = true;

  @action
  Future createFormaPagamento(BuildContext context) async {
    isLoading = true;
    try {
      final forma = _buildFormaPagamento();
      print(jsonEncode(forma.toJson()));
      await _formaPagamentoRepository.create(forma.toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateFormaPagamento(BuildContext context, FormaPagamento forma) async {
    isLoading = true;
    try {
      final updated = _buildFormaPagamento(formaPagamento: forma);
      print(jsonEncode(updated.toJson()));
      await _formaPagamentoRepository.update(forma.id, updated.toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
  }

  FormaPagamento _buildFormaPagamento({FormaPagamento? formaPagamento}) {
    return FormaPagamento(
      id: formaPagamento?.id,
      descricao: tecDescricao.text.trim(),
      numeroParcelas: int.tryParse(tecNumeroParcelas.text) ?? 1,
      ativo: isAtivo,
    );
  }

  @action
  void setFormaPagamento({FormaPagamento? formaPagamento}) {
    if (formaPagamento != null) {
      tecDescricao.text = formaPagamento.descricao ?? '';
      tecNumeroParcelas.text = formaPagamento.numeroParcelas?.toString() ?? '1';
      tecCodigo.text = formaPagamento.id?.toString() ?? '';
      isAtivo = formaPagamento.ativo ?? true;
    }
  }

  @action
  setAtivo(bool value){
    isAtivo = value;
  }
}
