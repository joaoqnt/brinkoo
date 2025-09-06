// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_parceiro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroParceiroController on _CadastroParceiroController, Store {
  late final _$pessoaFisicaAtom = Atom(
    name: '_CadastroParceiroController.pessoaFisica',
    context: context,
  );

  @override
  bool get pessoaFisica {
    _$pessoaFisicaAtom.reportRead();
    return super.pessoaFisica;
  }

  @override
  set pessoaFisica(bool value) {
    _$pessoaFisicaAtom.reportWrite(value, super.pessoaFisica, () {
      super.pessoaFisica = value;
    });
  }

  late final _$clienteAtom = Atom(
    name: '_CadastroParceiroController.cliente',
    context: context,
  );

  @override
  bool get cliente {
    _$clienteAtom.reportRead();
    return super.cliente;
  }

  @override
  set cliente(bool value) {
    _$clienteAtom.reportWrite(value, super.cliente, () {
      super.cliente = value;
    });
  }

  late final _$fornecedorAtom = Atom(
    name: '_CadastroParceiroController.fornecedor',
    context: context,
  );

  @override
  bool get fornecedor {
    _$fornecedorAtom.reportRead();
    return super.fornecedor;
  }

  @override
  set fornecedor(bool value) {
    _$fornecedorAtom.reportWrite(value, super.fornecedor, () {
      super.fornecedor = value;
    });
  }

  late final _$funcionarioAtom = Atom(
    name: '_CadastroParceiroController.funcionario',
    context: context,
  );

  @override
  bool get funcionario {
    _$funcionarioAtom.reportRead();
    return super.funcionario;
  }

  @override
  set funcionario(bool value) {
    _$funcionarioAtom.reportWrite(value, super.funcionario, () {
      super.funcionario = value;
    });
  }

  late final _$transportadorAtom = Atom(
    name: '_CadastroParceiroController.transportador',
    context: context,
  );

  @override
  bool get transportador {
    _$transportadorAtom.reportRead();
    return super.transportador;
  }

  @override
  set transportador(bool value) {
    _$transportadorAtom.reportWrite(value, super.transportador, () {
      super.transportador = value;
    });
  }

  late final _$agenciaBancariaAtom = Atom(
    name: '_CadastroParceiroController.agenciaBancaria',
    context: context,
  );

  @override
  bool get agenciaBancaria {
    _$agenciaBancariaAtom.reportRead();
    return super.agenciaBancaria;
  }

  @override
  set agenciaBancaria(bool value) {
    _$agenciaBancariaAtom.reportWrite(value, super.agenciaBancaria, () {
      super.agenciaBancaria = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_CadastroParceiroController.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$parceiroImageAtom = Atom(
    name: '_CadastroParceiroController.parceiroImage',
    context: context,
  );

  @override
  Uint8List? get parceiroImage {
    _$parceiroImageAtom.reportRead();
    return super.parceiroImage;
  }

  @override
  set parceiroImage(Uint8List? value) {
    _$parceiroImageAtom.reportWrite(value, super.parceiroImage, () {
      super.parceiroImage = value;
    });
  }

  late final _$createParceiroAsyncAction = AsyncAction(
    '_CadastroParceiroController.createParceiro',
    context: context,
  );

  @override
  Future<dynamic> createParceiro(BuildContext context) {
    return _$createParceiroAsyncAction.run(() => super.createParceiro(context));
  }

  late final _$updateParceiroAsyncAction = AsyncAction(
    '_CadastroParceiroController.updateParceiro',
    context: context,
  );

  @override
  Future<dynamic> updateParceiro(
    BuildContext context,
    Parceiro parceiroOriginal,
  ) {
    return _$updateParceiroAsyncAction.run(
      () => super.updateParceiro(context, parceiroOriginal),
    );
  }

  late final _$_CadastroParceiroControllerActionController = ActionController(
    name: '_CadastroParceiroController',
    context: context,
  );

  @override
  void setPessoaFisica(bool value) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.setPessoaFisica');
    try {
      return super.setPessoaFisica(value);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCliente(bool value) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.setCliente');
    try {
      return super.setCliente(value);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFornecedor(bool value) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.setFornecedor');
    try {
      return super.setFornecedor(value);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFuncionario(bool value) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.setFuncionario');
    try {
      return super.setFuncionario(value);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTransportador(bool value) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.setTransportador');
    try {
      return super.setTransportador(value);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgenciaBancaria(bool value) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.setAgenciaBancaria');
    try {
      return super.setAgenciaBancaria(value);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setParceiro({Parceiro? parceiro}) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.setParceiro');
    try {
      return super.setParceiro(parceiro: parceiro);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addFoto(Uint8List p0) {
    final _$actionInfo = _$_CadastroParceiroControllerActionController
        .startAction(name: '_CadastroParceiroController.addFoto');
    try {
      return super.addFoto(p0);
    } finally {
      _$_CadastroParceiroControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pessoaFisica: ${pessoaFisica},
cliente: ${cliente},
fornecedor: ${fornecedor},
funcionario: ${funcionario},
transportador: ${transportador},
agenciaBancaria: ${agenciaBancaria},
isLoading: ${isLoading},
parceiroImage: ${parceiroImage}
    ''';
  }
}
