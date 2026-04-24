import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/busca_cnpj.dart';
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
  TextEditingController tecNumero = TextEditingController();
  TextEditingController tecInscricaoEstadual = TextEditingController();
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  List<Parceiro> parceiros = ObservableList.of([]);
  @observable
  bool hasMore = true;
  int _offset = 0;
  final int _limit = 50;

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
  bool isAltering = false;

  @observable
  Uint8List? parceiroImage;

  @observable
  Parceiro? parceiroSelected;

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
  Future<List<Parceiro>> getParceiros({bool reset = false}) async {
    isLoading = true;

    if (reset) {
      _offset = 0;
      hasMore = true;
      parceiros.clear();
    }

    try {
      if (!hasMore) {
        isLoading = false;
        return parceiros;
      }

      Map<String, dynamic> filters = {
        'limit': _limit,
        'offset': _offset,
      };
      if (tecPesquisa.text.isNotEmpty) {
        filters['nome'] = tecPesquisa.text;
      }

      final novosParceiros = await _parceiroRepository.getAll(filters: filters);

      if (novosParceiros.isEmpty || novosParceiros.length < _limit) {
        hasMore = false; // não tem mais páginas
      }

      // Se for reset, já limpou antes; se não, adiciona
      parceiros.addAll(novosParceiros);

      _offset += _limit;

    } catch (e) {
      print(e);
    }

    isLoading = false;
    return parceiros;
  }

  @action
  Future createParceiro(BuildContext context) async {
    isAltering = true;
    try {
      final parceiro = _buildParceiro();
      print(jsonEncode(parceiro.toJson()));
      await _parceiroRepository.create(parceiro.toJson());
      if(parceiroImage != null) {
        await uploadImages(parceiro);
      }
      CustomSnackBar.success(context, "Parceiro cadastrado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar parceiro");
    }
    getParceiros(reset: true);
    isAltering = false;
  }

  @action
  Future updateParceiro(BuildContext context) async {
    isAltering = true;
    try {
      final parceiro = _buildParceiro(id: parceiroSelected?.id);
      print(jsonEncode(parceiro.toJson()));
      await _parceiroRepository.update(parceiroSelected?.id!, parceiro.toJson());
      if(parceiroImage != null) {
        await uploadImages(parceiro);
      }
      CustomSnackBar.success(context, "Parceiro atualizado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar parceiro");
    }
    getParceiros(reset: true);
    isAltering = false;
  }

  Parceiro _buildParceiro({int? id}) {
    return Parceiro(
      id: id,
      nome: tecDescricao.text,
      pessoaFisica: pessoaFisica,
      cpfCnpj: UtilBrasilFields.removeCaracteres(tecCpfCnpj.text),
      celular: UtilBrasilFields.removeCaracteres(tecTelefone.text),
      email: tecEmail.text,
      cep: UtilBrasilFields.removeCaracteres(tecCep.text),
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
      numero: tecNumero.text,
      urlImage: "https://brinkoo.com.br/images/${Singleton.instance.tenant}/parceiro/${UtilBrasilFields.removeCaracteres(tecCpfCnpj.text)}.png",
    );
  }

  @action
  void setParceiro({Parceiro? parceiro}) {
    if (parceiro == null) {
      clearAll();
      return;
    }

    if (parceiro != parceiroSelected) {
      parceiroSelected = parceiro;

      tecDescricao.text = parceiro.nome ?? '';

      try {
        if (parceiro.pessoaFisica == true) {
          tecCpfCnpj.text = UtilBrasilFields.obterCpf(parceiro.cpfCnpj?.toString() ?? '');
        } else {
          tecCpfCnpj.text = UtilBrasilFields.obterCnpj(parceiro.cpfCnpj?.toString() ?? '');
        }
      } catch (e) {
        tecCpfCnpj.text = parceiro.cpfCnpj?.toString() ?? '';
      }

      tecCodigo.text = parceiro.id?.toString() ?? '';
      tecEmail.text = parceiro.email ?? '';

      try {
        tecCep.text = UtilBrasilFields.obterCep(parceiro.cep ?? '');
      } catch (e) {
        tecCep.text = parceiro.cep ?? '';
      }

      try {
        tecTelefone.text = UtilBrasilFields.obterTelefone(parceiro.celular?.toString() ?? '');
      } catch (e) {
        if (parceiro.celular != null) {
          tecTelefone.text = parceiro.celular!.toString();
        }
      }

      tecCidade.text = parceiro.cidade ?? '';
      tecEstado.text = parceiro.estado ?? '';
      tecBairro.text = parceiro.bairro ?? '';
      tecEndereco.text = parceiro.endereco ?? '';
      tecInscricaoEstadual.text = parceiro.inscricaoEstadual ?? '';
      tecNumero.text = parceiro.numero ?? '';

      pessoaFisica = parceiro.pessoaFisica ?? true;
      cliente = parceiro.cliente ?? false;
      fornecedor = parceiro.fornecedor ?? false;
      funcionario = parceiro.funcionario ?? false;
      transportador = parceiro.transportador ?? false;
      agenciaBancaria = parceiro.agenciaBancaria ?? false;
    } else {
      clearAll();
    }
  }

  @action
  void clearAll() {
    parceiroSelected = null;

    tecDescricao.clear();
    tecCpfCnpj.clear();
    tecCodigo.clear();
    tecEmail.clear();
    tecCep.clear();
    tecTelefone.clear();
    tecCidade.clear();
    tecEstado.clear();
    tecBairro.clear();
    tecEndereco.clear();
    tecInscricaoEstadual.clear();
    tecNumero.clear();

    pessoaFisica = true;
    cliente = false;
    fornecedor = false;
    funcionario = false;
    transportador = false;
    agenciaBancaria = false;
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

  setDataByCnpj() async{
    try{
      final _cnpjRepository = GenericRepository<BuscaCnpj>(
        endpoint: "opencnpj/${UtilBrasilFields.removeCaracteres(tecCpfCnpj.text)}",
        fromJson: (p0) => BuscaCnpj.fromJson(p0),
      );
      BuscaCnpj buscaCnpj = await _cnpjRepository.get();

      tecBairro.text = buscaCnpj.bairro??'';
      tecCidade.text = buscaCnpj.municipio??'';
      tecEstado.text = buscaCnpj.uf??'';
      tecEndereco.text = buscaCnpj.logradouro??'';
      tecDescricao.text = buscaCnpj.nome??'';
      tecEmail.text = buscaCnpj.email??'';
      try{
        tecCep.text = buscaCnpj.cep??'';
      } catch(e){
        tecCep.text = buscaCnpj.cep??'';
      }

      try{
        tecTelefone.text = UtilBrasilFields.obterTelefone("${UtilBrasilFields.removeCaracteres(buscaCnpj.telefone!)}");
      } catch(e){

      }

    } catch(e){
      print(e);
    }
  }

}
