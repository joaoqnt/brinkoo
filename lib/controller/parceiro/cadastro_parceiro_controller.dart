import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/endereco_via_cep.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_parceiro_controller.g.dart';

class CadastroParceiroController = _CadastroParceiroController with _$CadastroParceiroController;

abstract class _CadastroParceiroController with Store {
  final _parceiroRepository = GenericRepository(
    endpoint: "parceiros",
    fromJson: (p0) => Parceiro.fromJson(p0),
  );

  final formKeyParceiro = GlobalKey<FormState>();

  // TextEditingControllers
  TextEditingController tecDescricao = TextEditingController();
  TextEditingController tecCpfCnpj = TextEditingController();
  TextEditingController tecTelefone = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecCep = TextEditingController();
  TextEditingController tecCidade = TextEditingController();
  TextEditingController tecEstado = TextEditingController();
  TextEditingController tecBairro = TextEditingController();
  TextEditingController tecEndereco = TextEditingController();
  TextEditingController tecCodigo = TextEditingController();
  TextEditingController tecInscricaoEstadual = TextEditingController();

  @observable
  bool pessoaFisica = true;

  @observable
  bool cliente = false;

  @observable
  bool fornecedor = false;

  @observable
  bool funcionario = false;

  @observable
  bool transportador = false;

  @observable
  bool agenciaBancaria = false;

  @observable
  bool isLoading = false;

  @observable
  Uint8List? parceiroImage;

  @action
  void setPessoaFisica(bool value) => pessoaFisica = value;

  @action
  void setCliente(bool value) => cliente = value;

  @action
  void setFornecedor(bool value) => fornecedor = value;

  @action
  void setFuncionario(bool value) => funcionario = value;

  @action
  void setTransportador(bool value) => transportador = value;

  @action
  void setAgenciaBancaria(bool value) => agenciaBancaria = value;

  @action
  Future createParceiro(BuildContext context) async {
    isLoading = true;
    try {
      final parceiro = _buildParceiro();
      print(jsonEncode(parceiro.toJson()));
      await _parceiroRepository.create(parceiro.toJson());
      if(parceiroImage != null)
        await uploadImages(parceiro);
      CustomSnackBar.success(context, "Parceiro cadastrado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar parceiro");
    }
    isLoading = false;
  }

  @action
  Future updateParceiro(BuildContext context, Parceiro parceiroOriginal) async {
    isLoading = true;
    try {
      final parceiro = _buildParceiro(id: parceiroOriginal.id);
      print(jsonEncode(parceiro.toJson()));
      await _parceiroRepository.update(parceiroOriginal.id!, parceiro.toJson());
      if(parceiroImage != null)
        await uploadImages(parceiro);
      CustomSnackBar.success(context, "Parceiro atualizado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar parceiro");
    }
    isLoading = false;
  }

  Parceiro _buildParceiro({int? id}) {
    return Parceiro(
      id: id,
      nome: tecDescricao.text,
      pessoaFisica: pessoaFisica,
      cpfCnpj: UtilBrasilFields.removeCaracteres(tecCpfCnpj.text),
      telefone: UtilBrasilFields.removeCaracteres(tecTelefone.text),
      email: tecEmail.text,
      cep: tecCep.text,
      cidade: tecCidade.text,
      estado: tecEstado.text,
      bairro: tecBairro.text,
      endereco: tecEndereco.text,
      cliente: cliente,
      fornecedor: fornecedor,
      funcionario: funcionario,
      transportador: transportador,
      agenciaBancaria: agenciaBancaria,
      inscricaoEstadual: tecInscricaoEstadual.text,
      urlImage: "https://brinkoo.com.br/images/${Singleton.instance.tenant}/parceiro/${UtilBrasilFields.removeCaracteres(tecCpfCnpj.text)}.png",
    );
  }

  @action
  void setParceiro({Parceiro? parceiro}) {
    if (parceiro != null) {
      tecDescricao.text = parceiro.nome ?? '';
      tecCpfCnpj.text = parceiro.cpfCnpj?.toString() ?? '';
      tecCodigo.text = parceiro.id?.toString() ?? '';
      tecTelefone.text = parceiro.telefone?.toString() ?? '';
      tecEmail.text = parceiro.email ?? '';
      tecCep.text = parceiro.cep ?? '';
      tecCidade.text = parceiro.cidade ?? '';
      tecEstado.text = parceiro.estado ?? '';
      tecBairro.text = parceiro.bairro ?? '';
      tecEndereco.text = parceiro.endereco ?? '';
      tecInscricaoEstadual.text = parceiro.inscricaoEstadual ?? '';
      pessoaFisica = parceiro.pessoaFisica ?? true;
      cliente = parceiro.cliente ?? false;
      fornecedor = parceiro.fornecedor ?? false;
      funcionario = parceiro.funcionario ?? false;
      transportador = parceiro.transportador ?? false;
      agenciaBancaria = parceiro.agenciaBancaria ?? false;
    }
  }

  uploadImages(Parceiro parceiro) async{
    await _parceiroRepository.uploadFile(
      pathField: "parceiro",
      filename: '${UtilBrasilFields.removeCaracteres(tecCpfCnpj.text)}.png',
      fileBytes: parceiroImage!,
    );
  }

  @action
  addFoto(Uint8List p0){
    parceiroImage = p0;
  }

  setEnderecoByCep() async{
    final _cepRepository = GenericRepository<EnderecoViaCep>(
      endpoint: "viacep/${UtilBrasilFields.removeCaracteres(tecCep.text)}",
      fromJson: (p0) => EnderecoViaCep.fromJson(p0),
    );
    EnderecoViaCep enderecoViaCep = await _cepRepository.get();
    tecBairro.text = enderecoViaCep.bairro??'';
    tecCidade.text = enderecoViaCep.localidade??'';
    tecEstado.text = enderecoViaCep.uf??'';
    tecEndereco.text = enderecoViaCep.logradouro??'';
  }

}
