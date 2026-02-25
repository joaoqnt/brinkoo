import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../model/crianca.dart';
import '../model/empresa.dart';

class FichaCadastralPdf {
  static const PdfColor primaryColor = PdfColor.fromInt(0xFF2C3E50);
  static const PdfColor accentColor = PdfColor.fromInt(0xFF3498DB);
  static const PdfColor textColor = PdfColor.fromInt(0xFF34495E);
  static const PdfColor lightGray = PdfColor.fromInt(0xFFECF0F1);
  static const PdfColor mediumGray = PdfColor.fromInt(0xFFBDC3C7);

  static Future<Uint8List> gerar(Crianca crianca) async {
    final pdf = pw.Document();
    final empresa = Singleton.instance.usuario?.empresa;

    // Carrega imagem da URL (Flutter Web compatível)
    pw.ImageProvider? foto;
    if (crianca.urlImage != null && crianca.urlImage!.isNotEmpty) {
      try {
        foto = await networkImage(crianca.urlImage!);
      } catch (e) {
        foto = null;
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildCabecalho(empresa),
        footer: (context) => _buildRodape(),
        build: (context) => [
          pw.SizedBox(height: 20),

          /// TÍTULO PRINCIPAL - Minimalista
          pw.Center(
            child: pw.Text(
              "FICHA CADASTRAL",
              style: pw.TextStyle(
                fontSize: 25,
                letterSpacing: 1.5,
                color: primaryColor,
              ),
            ),
          ),

          pw.SizedBox(height: 15),

          /// LINHA DIVISÓRIA SUTIL
          pw.Container(
            height: 1,
            color: mediumGray,
            margin: const pw.EdgeInsets.symmetric(vertical: 10),
          ),

          /// DADOS DA CRIANÇA COM FOTO - Layout balanceado
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              /// DADOS DA CRIANÇA
              pw.Expanded(
                flex: 3,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _secaoTitulo("Dados Pessoais"),
                    pw.SizedBox(height: 15),
                    _campoClean("Nome completo", crianca.nome),
                    pw.SizedBox(height: 8),
                    _campoClean("Sexo", crianca.sexo == "M" ? "Masculino" : "Feminino"),
                    pw.SizedBox(height: 8),
                    _campoClean("Data de nascimento", DateHelperUtil.formatDate(crianca.dataNascimento!)),
                    pw.SizedBox(height: 8),
                    _campoClean("Grupo sanguíneo", crianca.grupoSanguineo),
                  ],
                ),
              ),

              pw.SizedBox(width: 30),

              /// FOTO - Circular e elegante
              pw.Container(
                width: 140,
                height: 140,
                decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.circle,
                  border: pw.Border.all(color: accentColor, width: 1),
                  color: foto == null ? lightGray : null,
                  image: foto != null
                      ? pw.DecorationImage(
                    image: foto,
                    fit: pw.BoxFit.cover,
                  )
                      : null,
                ),
                child: foto == null
                    ? pw.Center(
                  child: pw.Text(
                    "SEM\nFOTO",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      color: mediumGray,
                      fontSize: 12,
                    ),
                  ),
                )
                    : null,
              ),
            ],
          ),

          pw.SizedBox(height: 30),

          /// INFORMAÇÕES ADICIONAIS - Cards minimalistas
          _secaoTitulo("Informações Complementares"),
          pw.SizedBox(height: 15),

          _infoCard("Alergias", crianca.alergias),
          pw.SizedBox(height: 10),
          _infoCard("Necessidades Especiais", crianca.necessidadesEspeciais),
          pw.SizedBox(height: 10),
          _infoCard("Observações", crianca.observacoes),
          pw.SizedBox(height: 10),
          _infoCard("Atividades Permitidas", _formatarAtividades(crianca.atividades)),

          pw.SizedBox(height: 30),

          /// RESPONSÁVEIS - Grid layout
          _secaoTitulo("Responsáveis"),
          pw.SizedBox(height: 15),

          if (crianca.responsaveis != null &&
              crianca.responsaveis!.isNotEmpty)
            pw.Wrap(
              spacing: 15,
              runSpacing: 15,
              children: crianca.responsaveis!.map((r) {
                return _responsavelCard(r);
              }).toList(),
            )
          else
            pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: lightGray),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Center(
                child: pw.Text(
                  "Nenhum responsável cadastrado",
                  style: pw.TextStyle(
                    color: mediumGray,
                    fontStyle: pw.FontStyle.italic,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildCabecalho(Empresa? empresa) {
    if (empresa == null) return pw.SizedBox();

    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                empresa.descricao ?? "Empresa",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              pw.SizedBox(height: 3),
              if (empresa.cnpj != null)
                pw.Text(
                  UtilBrasilFields.obterCnpj(empresa.cnpj!),
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey500,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildRodape() {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 15),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            "Documento gerado em ${DateHelperUtil.formatDateTime(DateTime.now())}",
            style: pw.TextStyle(
              fontSize: 7,
              color: mediumGray,
            ),
          ),
          pw.Text(
            "Brinkoo",
            style: pw.TextStyle(
              fontSize: 7,
              color: mediumGray,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _secaoTitulo(String titulo) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          titulo.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1.5,
            color: accentColor,
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Container(
          width: 40,
          height: 2,
          color: accentColor,
        ),
      ],
    );
  }

  static pw.Widget _campoClean(String rotulo, String? valor) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          rotulo.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 8,
            color: PdfColors.grey700,
            letterSpacing: 0.5,
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          valor?.isNotEmpty == true ? valor! : "Não informado",
          style: pw.TextStyle(
            fontSize: 11,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  static pw.Widget _infoCard(String titulo, String? valor) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        color: lightGray,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            titulo.toUpperCase(),
            style: pw.TextStyle(
              fontSize: 9,
              color: PdfColors.grey700,
              letterSpacing: 0.5,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            valor?.isNotEmpty == true ? valor! : "Não informado",
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _responsavelCard(dynamic responsavel) {
    return pw.Container(
      width: 200,
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: lightGray),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            responsavel.nome ?? "Responsável",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: primaryColor,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            "Telefone",
            style: pw.TextStyle(
              fontSize: 7,
              color: PdfColors.grey700,
              letterSpacing: 0.5,
            ),
          ),
          pw.Text(
            UtilBrasilFields.obterTelefone(responsavel.celular),
            style: pw.TextStyle(
              fontSize: 10,
              color: primaryColor,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            "E-mail",
            style: pw.TextStyle(
              fontSize: 7,
              color: PdfColors.grey700,
              letterSpacing: 0.5,
            ),
          ),
          pw.Text(
            responsavel.email ?? "",
            style: pw.TextStyle(
              fontSize: 10,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatarAtividades(List<Atividade>? atividades) {
    if (atividades == null || atividades.isEmpty) return "Nenhuma atividade cadastrada";

    return atividades.map((a) => a.descricao).join(", ");
  }

  static Future<void> imprimir(Crianca crianca) async {
    final pdfData = await gerar(crianca);

    await Printing.sharePdf(
      bytes: pdfData,
      filename: 'ficha_${crianca.nome?.toLowerCase().replaceAll(' ', '_') ?? 'crianca'}.pdf',
    );
  }
}