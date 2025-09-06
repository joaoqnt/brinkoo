class Parametro {
  int? minutosMaximo;
  int? minutosMinimo;
  int? tolerancia;
  double? valorHoraGuardaVolume;
  double? valorMinutoVisita;

  Parametro(
      {this.minutosMaximo,
        this.minutosMinimo,
        this.tolerancia,
        this.valorHoraGuardaVolume,
        this.valorMinutoVisita});

  Parametro.fromJson(Map<String, dynamic> json) {
    minutosMaximo = json['minutos_maximo'];
    minutosMinimo = json['minutos_minimo'];
    tolerancia = json['tolerancia'];
    valorHoraGuardaVolume = json['valor_hora_guarda_volume'];
    valorMinutoVisita = json['valor_minuto_visita'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minutos_maximo'] = this.minutosMaximo;
    data['minutos_minimo'] = this.minutosMinimo;
    data['tolerancia'] = this.tolerancia;
    data['valor_hora_guarda_volume'] = this.valorHoraGuardaVolume;
    data['valor_minuto_visita'] = this.valorMinutoVisita;
    return data;
  }
}
