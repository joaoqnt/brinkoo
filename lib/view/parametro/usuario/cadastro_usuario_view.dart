import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/empresa/dropdown_empresa.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/controller/parametro/usuario/cadastro_usuario_controller.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/view/parametro/parametro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroUsuarioView extends StatefulWidget {
  Usuario? usuario;
  CadastroUsuarioView({super.key, this.usuario});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
  final _controller = CadastroUsuarioController();

  @override
  void initState() {
    super.initState();
    //_controller.carregarUsuario(); // ou iniciar limpo
  }

  @override
  Widget build(BuildContext context) {
    _controller.setUsuario(usuario: widget.usuario);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cadastro de Usuário',
        pageBackButton: ParametroView(initialIndex: 1,),
        showBackButton: true,
      ),
      body: Observer(
        builder: (_) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _controller.formKeyUsuario,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      FotoAlterComponent(
                        capturedImageBytes: _controller.usuarioImage,
                        height: 100,
                        width: 100,
                        onAdd: (p0) => _controller.addFoto(p0),
                        imageUrl: (widget.usuario?.urlFoto),
                      ),
                      _buildInput('Login', _controller.tecLogin),
                      _buildInput('Nome', _controller.tecNome),
                      _buildInput('Senha', _controller.tecSenha),
                      DropdownEmpresa(
                        empresaSelected: _controller.empresaSelected,
                        onChanged: (p0) => _controller.setEmpresa(p0),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildPermissoes('Acesso', [
                    _buildCheckbox('Cadastro', _controller.permiteAcessarCadastro, (v) => _controller.permiteAcessarCadastro = v!),
                    _buildCheckbox('Financeiro', _controller.permiteAcessarFinanceiro, (v) => _controller.permiteAcessarFinanceiro = v!),
                    _buildCheckbox('Produto', _controller.permiteAcessarProduto, (v) => _controller.permiteAcessarProduto = v!),
                    _buildCheckbox('Check-in', _controller.permiteAcessarCheckin, (v) => _controller.permiteAcessarCheckin = v!),
                  ]),
                  _buildPermissoes('Cadastro', [
                    _buildCheckbox('Atividade', _controller.permiteCadastrarAtividade, (v) => _controller.permiteCadastrarAtividade = v!),
                    _buildCheckbox('Check-in', _controller.permiteCadastrarCheckin, (v) => _controller.permiteCadastrarCheckin = v!),
                    _buildCheckbox('Criança', _controller.permiteCadastrarCrianca, (v) => _controller.permiteCadastrarCrianca = v!),
                    _buildCheckbox('Responsável', _controller.permiteCadastrarResponsavel, (v) => _controller.permiteCadastrarResponsavel = v!),
                    _buildCheckbox('Natureza', _controller.permiteCadastrarNatureza, (v) => _controller.permiteCadastrarNatureza = v!),
                    _buildCheckbox('Centro Custo', _controller.permiteCadastrarCentroCusto, (v) => _controller.permiteCadastrarCentroCusto = v!),
                    _buildCheckbox('Guarda Volume', _controller.permiteCadastrarGuardaVolume, (v) => _controller.permiteCadastrarGuardaVolume = v!),
                    _buildCheckbox('Parceiro', _controller.permiteCadastrarParceiro, (v) => _controller.permiteCadastrarParceiro = v!),
                    _buildCheckbox('Empresa', _controller.permiteCadastrarEmpresa, (v) => _controller.permiteCadastrarEmpresa = v!),
                    _buildCheckbox('Usuário', _controller.permiteCadastrarUsuario, (v) => _controller.permiteCadastrarUsuario = v!),
                  ]),
                  _buildPermissoes('Atualização', [
                    _buildCheckbox('Atividade', _controller.permiteAtualizarAtividade, (v) => _controller.permiteAtualizarAtividade = v!),
                    _buildCheckbox('Check-in', _controller.permiteAtualizarCheckin, (v) => _controller.permiteAtualizarCheckin = v!),
                    _buildCheckbox('Criança', _controller.permiteAtualizarCrianca, (v) => _controller.permiteAtualizarCrianca = v!),
                    _buildCheckbox('Responsável', _controller.permiteAtualizarResponsavel, (v) => _controller.permiteAtualizarResponsavel = v!),
                    _buildCheckbox('Natureza', _controller.permiteAtualizarNatureza, (v) => _controller.permiteAtualizarNatureza = v!),
                    _buildCheckbox('Centro Custo', _controller.permiteAtualizarCentroCusto, (v) => _controller.permiteAtualizarCentroCusto = v!),
                    _buildCheckbox('Guarda Volume', _controller.permiteAtualizarGuardaVolume, (v) => _controller.permiteAtualizarGuardaVolume = v!),
                    _buildCheckbox('Parceiro', _controller.permiteAtualizarParceiro, (v) => _controller.permiteAtualizarParceiro = v!),
                    _buildCheckbox('Empresa', _controller.permiteAtualizarEmpresa, (v) => _controller.permiteAtualizarEmpresa = v!),
                    _buildCheckbox('Usuário', _controller.permiteAtualizarUsuario, (v) => _controller.permiteAtualizarUsuario = v!),
                  ]),
                  _buildPermissoes('Exclusão', [
                    _buildCheckbox('Atividade', _controller.permiteDeletarAtividade, (v) => _controller.permiteDeletarAtividade = v!),
                    _buildCheckbox('Check-in', _controller.permiteDeletarCheckin, (v) => _controller.permiteDeletarCheckin = v!),
                    _buildCheckbox('Criança', _controller.permiteDeletarCrianca, (v) => _controller.permiteDeletarCrianca = v!),
                    _buildCheckbox('Responsável', _controller.permiteDeletarResponsavel, (v) => _controller.permiteDeletarResponsavel = v!),
                    _buildCheckbox('Natureza', _controller.permiteDeletarNatureza, (v) => _controller.permiteDeletarNatureza = v!),
                    _buildCheckbox('Centro Custo', _controller.permiteDeletarCentroCusto, (v) => _controller.permiteDeletarCentroCusto = v!),
                    _buildCheckbox('Guarda Volume', _controller.permiteDeletarGuardaVolume, (v) => _controller.permiteDeletarGuardaVolume = v!),
                    _buildCheckbox('Parceiro', _controller.permiteDeletarParceiro, (v) => _controller.permiteDeletarParceiro = v!),
                    _buildCheckbox('Empresa', _controller.permiteDeletarEmpresa, (v) => _controller.permiteDeletarEmpresa = v!),
                    _buildCheckbox('Usuário', _controller.permiteDeletarUsuario, (v) => _controller.permiteDeletarUsuario = v!),
                  ]),
                  const SizedBox(height: 24),
                  Center(
                    child: FilledButton(
                      onPressed: () async{
                        if (_controller.formKeyUsuario.currentState!.validate()) {
                          if(widget.usuario != null)
                            await _controller.updateUsuario(context, widget.usuario!);
                          else
                            await _controller.createUsuario(context);
                          //_controller.salvarUsuario(context);
                        }
                      },
                      child: _controller.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Salvar Usuário'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return SizedBox(
      width: 250,
      child: CustomTextFormField(
        labelText: label,
        controller: controller,
        required: true,
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildPermissoes(String titulo, List<Widget> checkboxes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Wrap(
          spacing: 10,
          runSpacing: 0,
          children: checkboxes,
        ),
      ],
    );
  }
}
