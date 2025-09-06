import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:brinquedoteca_flutter/utils/take_photo.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_crianca_controller.g.dart';

class CadastroCriancaController = _CadastroCriancaController with _$CadastroCriancaController;

abstract class _CadastroCriancaController with Store {
  TextEditingController tecNomeCrianca = TextEditingController();
  TextEditingController tecDataCrianca = TextEditingController();
  TextEditingController tecGrupoSanguineoCrianca = TextEditingController();
  TextEditingController tecAlergiaCrianca = TextEditingController();
  TextEditingController tecObservacaoCrianca = TextEditingController();
  final formKeyCrianca = GlobalKey<FormState>();
  final _criancaRepository = GenericRepository(
      endpoint: "criancas",
      fromJson:(p0) => Crianca.fromJson(p0),
  );
  Map<String,String> sexos = {
    "M":"Masculino",
    "F":"Feminino",
    "O":"Outros",
  };

  List<String> tiposRelacionamento = [
    'Mae',
    'Pai',
    'Avó',
    'Avô',
    'Bisavó',
    'Bisavô',
    'Madrasta',
    'Padrasto',
    'Irmã',
    'Irmão',
    'Tia',
    'Tio',
    'Prima',
    'Baba',
    'Professora',
    'Outro'
  ];

  Map<Responsavel,String?> relacionamentoSelected = {};

  @observable
  Uint8List? criancaImage;

  @observable
  List<Responsavel> responsaveis = ObservableList.of([]);
  @observable
  List<CadastroResponsavelController> responsaveisController = ObservableList.of([]);
  @observable
  bool isLoading = false;
  @observable
  Crianca? criancaSelected;
  Map<String,String>  sexoCrianca = {"M":"Masculino"};

  @action
  Future<void> addFoto(Uint8List imageBytes) async {
    criancaImage = imageBytes;
  }

  @action
  addResponsavel({Responsavel? responsavel}){
    Responsavel responsavelTmp = responsavel??Responsavel();
    CadastroResponsavelController controller = CadastroResponsavelController();
    responsaveis.add(responsavelTmp);
    print(responsaveis.length);
    responsaveisController.add(controller);
    if(responsavel != null){
      controller.setResponsavel(responsavel: responsavel);
      if(responsavel.parentesco != null) {
        setRelacionamento(responsavel, responsavel.parentesco!);
      }
    }
  }

  @action
  removeResponsavel(Responsavel responsavel, CadastroResponsavelController responsavelController){
    responsaveis.remove(responsavel);
    responsaveisController.remove(responsavelController);
  }

  bool validate(BuildContext context) {
    // 1. Verifica se há ao menos um responsável
    if (responsaveis.isEmpty) {
      CustomSnackBar.warning(context, "Obrigatório ao menos um responsável da criança");
      return false;
    }

    // 2. Verifica se a imagem da criança está presente
    if (criancaImage == null && criancaSelected?.urlImage == null) {
      CustomSnackBar.warning(context, "Imagem da criança é obrigatória");
      return false;
    }

    // 3. Valida o form da criança
    final isFormCriancaValid = formKeyCrianca.currentState?.validate() ?? false;

    // 4. Valida os formKeys dos responsáveis contidos em responsaveisController
    bool areResponsaveisControllerFormsValid = true;
    for (int i = 0; i < responsaveisController.length; i++) {
      final controller = responsaveisController[i];
      final responsavel = responsaveis[i];
      final isValid = controller.formKeyResponsavel.currentState?.validate() ?? false;
      if (!isValid) {
        areResponsaveisControllerFormsValid = false;
      } else {
        areResponsaveisControllerFormsValid = controller.validate(context,responsavel: responsavel);
      }
    }



    // 6. Retorna resultado final
    return isFormCriancaValid && areResponsaveisControllerFormsValid;
  }



  @action
  Future createCrianca(BuildContext context) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildCrianca().toJson()));
      Crianca crianca = await _criancaRepository.create(_buildCrianca().toJson());
      await _uploadImages(crianca);
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateCrianca(BuildContext context, Crianca crianca) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildCrianca(crianca:crianca).toJson()));
      Crianca criancaTmp = await _criancaRepository.update(crianca.id,_buildCrianca(crianca:crianca).toJson());
      await _uploadImages(crianca);
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
  }

  _uploadImages(Crianca crianca) async{
    if(criancaImage != null){
      await _criancaRepository.uploadFile(
        pathField: "criança",
        filename: '${crianca.id}.png',
        fileBytes: criancaImage!,
      );
    }
    for(int i = 0; i < responsaveis.length; i++){
      final responsavel = responsaveis[i];
      final controller = responsaveisController[i];
      if(controller.responsavelImage != null) {
        await controller.uploadImages(responsavel);
      }
    }
  }

  _alterResponsaveis(){
    List<Responsavel>  responsaveisTmp = [];
    for(int i = 0; i < responsaveisController.length; i++){
      final responsavel = responsaveis[i];
      final controller = responsaveisController[i];
      responsavel.nome = controller.tecNome.text;
      responsavel.documento = UtilBrasilFields.removeCaracteres(controller.tecDocumento.text);
      responsavel.celular = controller.tecTelefone.text;
      responsavel.email = controller.tecEmail.text;
      responsavel.cidade = controller.tecCidade.text;
      responsavel.bairro = controller.tecBairro.text;
      responsavel.endereco = controller.tecEndereco.text;
      responsavel.estado = controller.tecEstado.text;
      responsavel.parentesco = relacionamentoSelected[responsavel];
      responsavel.urlImage = "https://brinkoo.com.br/images/${Singleton.instance.tenant}/responsavel/"
          "${UtilBrasilFields.removeCaracteres(controller.tecDocumento.text)}.png";
      responsaveisTmp.add(responsavel);
    }
    responsaveis = responsaveisTmp;
  }

  Crianca _buildCrianca({Crianca? crianca}){
    _alterResponsaveis();
    Crianca criancaTmp = Crianca(
      id: crianca?.id,
      nome: tecNomeCrianca.text,
      alergias: tecAlergiaCrianca.text,
      dataCadastro: DateTime.now(),
      dataImagem: DateTime.now(),
      dataNascimento: DateHelperUtil.parseBrDateToDateTime(tecDataCrianca.text),
      grupoSanguineo: tecGrupoSanguineoCrianca.text,
      sexo: sexoCrianca.keys.firstOrNull,
      observacoes: tecObservacaoCrianca.text,
      responsaveis: responsaveis,
      urlImage: crianca?.urlImage
    );
    return criancaTmp;
  }

  void setSexoCrianca(String? value) {
    if (value != null && sexos.containsKey(value)) {
      sexoCrianca.clear(); // limpa valores anteriores
      sexoCrianca[value] = sexos[value]!; // adiciona o novo
    }
  }

  void setRelacionamento(Responsavel responsavel,String relacionamento){
    relacionamentoSelected[responsavel] = relacionamento;
  }

  @action
  void setCrianca({Crianca? crianca}){
    if(crianca != null){
      tecNomeCrianca.text = crianca.nome??'';
      if(crianca.dataNascimento != null)
        tecDataCrianca.text = DateHelperUtil.formatDate(crianca.dataNascimento!);
      tecGrupoSanguineoCrianca.text = crianca.grupoSanguineo??'';
      tecAlergiaCrianca.text = crianca.alergias??'';
      tecObservacaoCrianca.text = crianca.observacoes??'';
      criancaSelected = crianca;
      crianca.responsaveis?.forEach((element) {
        addResponsavel(responsavel: element);
      });
    }
  }
}
