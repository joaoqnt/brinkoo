import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:flutter/material.dart';

class CheckinValidationService {
  bool validate({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required GlobalKey<FormState> formKeyDialog,
    required bool useFormKeyDialog,
    required Checkin? checkin,
    required Crianca? criancaSelected,
    required Responsavel? responsavelEntradaSelected,
    required Responsavel? responsavelSaidaSelected,
    required List<Responsavel> responsaveisPossiveisCheckout,
    required List<FormaPagamento> formas,
    required String valorLiquidoText,
    required bool hasCriancaImage,
    required bool hasResponsavelEntradaImage,
    required bool hasResponsavelSaidaImage,
  }) {
    final key = useFormKeyDialog ? formKeyDialog : formKey;

    if (!(key.currentState?.validate() ?? false)) {
      return false;
    }

    if (checkin == null) {
      return _validateEntrada(
        context: context,
        criancaSelected: criancaSelected,
        responsavelEntradaSelected: responsavelEntradaSelected,
        responsaveisPossiveisCheckout: responsaveisPossiveisCheckout,
        hasCriancaImage: hasCriancaImage,
        hasResponsavelEntradaImage: hasResponsavelEntradaImage,
      );
    }

    if (checkin.dataSaida == null) {
      return _validateSaida(
        context: context,
        responsavelSaidaSelected: responsavelSaidaSelected,
        formas: formas,
        valorLiquidoText: valorLiquidoText,
        hasResponsavelSaidaImage: hasResponsavelSaidaImage,
      );
    }

    return true;
  }

  bool _validateEntrada({
    required BuildContext context,
    required Crianca? criancaSelected,
    required Responsavel? responsavelEntradaSelected,
    required List<Responsavel> responsaveisPossiveisCheckout,
    required bool hasCriancaImage,
    required bool hasResponsavelEntradaImage,
  }) {
    if (criancaSelected == null) {
      CustomSnackBar.warning(context, 'Selecione uma criança');
      return false;
    }

    if (responsavelEntradaSelected == null) {
      CustomSnackBar.warning(context, 'Selecione um responsável pelo check-in');
      return false;
    }

    if (responsaveisPossiveisCheckout.isEmpty) {
      CustomSnackBar.warning(
        context,
        'Adicione ao menos um responsável pelo check-out',
      );
      return false;
    }

    if (!hasCriancaImage && criancaSelected.urlImage == null) {
      CustomSnackBar.warning(context, 'Adicione uma foto da criança');
      return false;
    }

    if (!hasResponsavelEntradaImage &&
        responsavelEntradaSelected.urlImage == null) {
      CustomSnackBar.warning(
        context,
        'Adicione uma foto do responsável pelo check-in',
      );
      return false;
    }

    return true;
  }

  bool _validateSaida({
    required BuildContext context,
    required Responsavel? responsavelSaidaSelected,
    required List<FormaPagamento> formas,
    required String valorLiquidoText,
    required bool hasResponsavelSaidaImage,
  }) {
    if (responsavelSaidaSelected == null) {
      CustomSnackBar.warning(context, 'Selecione um responsável pelo check-out');
      return false;
    }

    if (!hasResponsavelSaidaImage && responsavelSaidaSelected.urlImage == null) {
      CustomSnackBar.warning(
        context,
        'Adicione uma foto do responsável pelo check-out',
      );
      return false;
    }

    final valorLiquido = _parseCurrency(valorLiquidoText);

    final totalFormas = formas.fold<double>(
      0,
          (total, forma) => total + (forma.valor ?? 0),
    );

    if (totalFormas < valorLiquido) {
      CustomSnackBar.warning(
        context,
        'O total das formas de pagamento é menor que o valor líquido',
      );
      return false;
    }

    if (totalFormas > valorLiquido) {
      CustomSnackBar.warning(
        context,
        'O total das formas de pagamento é maior que o valor líquido',
      );
      return false;
    }

    return true;
  }

  double _parseCurrency(String value) {
    try {
      if (value.isEmpty) return 0;
      return UtilBrasilFields.converterMoedaParaDouble(value);
    } catch (_) {
      return 0;
    }
  }
}