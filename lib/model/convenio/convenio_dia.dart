class ConvenioDia {
  int? convenio;
  int? dia;
  double? percConvenio;
  double? percEmpresa;

  ConvenioDia({this.convenio, this.dia, this.percConvenio, this.percEmpresa});

  ConvenioDia.fromJson(Map<String, dynamic> json) {
    convenio = json['convenio'];
    dia = json['dia'];
    percConvenio = json['perc_convenio'];
    percEmpresa = json['perc_empresa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['convenio'] = this.convenio;
    data['dia'] = this.dia;
    data['perc_convenio'] = this.percConvenio;
    data['perc_empresa'] = this.percEmpresa;
    return data;
  }
}
