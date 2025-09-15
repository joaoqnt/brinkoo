import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/model/convenio.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_convenio_controller.g.dart';

class CadastroConvenioController = _CadastroConvenioController with _$CadastroConvenioController;

abstract class _CadastroConvenioController with Store {
  TextEditingController tecDescricao = TextEditingController();
  TextEditingController tecCodigo = TextEditingController();
  TextEditingController tecDataExpiracao = TextEditingController();
  TextEditingController tecDiaVencimento = TextEditingController();
  TextEditingController tecMaxVisita = TextEditingController();
  TextEditingController tecMinDiaVencimento = TextEditingController();
  TextEditingController tecObservacao = TextEditingController();
  TextEditingController tecPercConvenio = TextEditingController();
  TextEditingController tecPercEmpresa = TextEditingController();
  TextEditingController tecValorConvenio = TextEditingController();
  TextEditingController tecValorEmpresa = TextEditingController();
  TextEditingController tecQtdVisita = TextEditingController();
  final formKeyConvenio = GlobalKey<FormState>();
  final _convenioRepository = GenericRepository(
      endpoint: "convenios",
      fromJson:(p0) => Convenio.fromJson(p0),
  );
  Parceiro? parceiroSelected;
  Empresa? empresaSelected;
  Natureza? naturezaSelected;
  CentroCusto? centroCustoSelected;
  @observable
  bool isLoading = false;
  @observable
  bool isAtivo = true;


  @action
  Future createConvenio(BuildContext context) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildConvenio().toJson()));
      await _convenioRepository.create(_buildConvenio().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateConvenio(BuildContext context, Convenio convenio) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildConvenio(convenio:convenio).toJson()));
      await _convenioRepository.update(convenio.id,_buildConvenio(convenio:convenio).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
  }

  Convenio _buildConvenio({Convenio? convenio}){
    Convenio convenioTmp = Convenio(
      id: convenio?.id,
      descricao: tecDescricao.text,
      parceiro: parceiroSelected,
      empresa: empresaSelected,
      natureza: naturezaSelected,
      centroCusto: centroCustoSelected,
      ativo: isAtivo,
      dataExpiracao: DateHelperUtil.parseBrDateToDateTime(tecDataExpiracao.text),
      diaVencimento: int.tryParse(tecDiaVencimento.text),
      maxVisita: int.tryParse(tecMaxVisita.text),
      minDiaVencimento: int.tryParse(tecMinDiaVencimento.text),
      observacao: tecObservacao.text,
      percConvenio: UtilBrasilFields.converterMoedaParaDouble(tecPercConvenio.text),
      percEmpresa: UtilBrasilFields.converterMoedaParaDouble(tecPercEmpresa.text),
      valorConvenio: UtilBrasilFields.converterMoedaParaDouble(tecValorConvenio.text),
      valorEmpresa: UtilBrasilFields.converterMoedaParaDouble(tecValorEmpresa.text),
      qtdVisita: int.tryParse(tecQtdVisita.text)
    );
    return convenioTmp;
  }

  @action
  void setConvenio({Convenio? convenio}) {
    if (convenio != null) {
      tecCodigo.text = convenio.id?.toString() ?? '';
      tecDescricao.text = convenio.descricao ?? '';
      tecDataExpiracao.text = convenio.dataExpiracao != null
          ? DateHelperUtil.formatDate(convenio.dataExpiracao!)
          : '';
      tecDiaVencimento.text = convenio.diaVencimento?.toString() ?? '';
      tecMaxVisita.text = convenio.maxVisita?.toString() ?? '';
      tecMinDiaVencimento.text = convenio.minDiaVencimento?.toString() ?? '';
      tecObservacao.text = convenio.observacao ?? '';
      tecPercConvenio.text = convenio.percConvenio != null
          ? UtilBrasilFields.obterReal(convenio.percConvenio!)
          : '';
      tecPercEmpresa.text = convenio.percEmpresa != null
          ? UtilBrasilFields.obterReal(convenio.percEmpresa!)
          : '';
      tecValorConvenio.text = convenio.valorConvenio != null
          ? UtilBrasilFields.obterReal(convenio.valorConvenio!)
          : '';
      tecValorEmpresa.text = convenio.valorEmpresa != null
          ? UtilBrasilFields.obterReal(convenio.valorEmpresa!)
          : '';
      tecQtdVisita.text = convenio.qtdVisita?.toString() ?? '';

      parceiroSelected = convenio.parceiro;
      empresaSelected = convenio.empresa;
      naturezaSelected = convenio.natureza;
      centroCustoSelected = convenio.centroCusto;
      isAtivo = convenio.ativo ?? true;
    }
  }

  setEmpresa({Empresa? empresa}){
    empresaSelected = empresa;
  }

  setNatureza({Natureza? natureza}){
    naturezaSelected = natureza;
  }

  setCentroCusto({CentroCusto? centrocusto}){
    centroCustoSelected = centrocusto;
  }
}
