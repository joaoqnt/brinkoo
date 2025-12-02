import 'package:flutter/widgets.dart';

/// Classe utilitária para manter espaçamentos padronizados em todo o app.
///
/// - [xs] = muito pequeno (4)
/// - [sm] = pequeno (8)
/// - [md] = médio (16)
/// - [lg] = grande (24)
/// - [xl] = muito grande (32)
/// - [xgl] = (40)
class AppSpacing {
  AppSpacing._(); // impede instanciação

  /// 🌿 Espaçamentos verticais
  static const vXs = SizedBox(height: 4);
  static const vSm = SizedBox(height: 8);
  static const vMd = SizedBox(height: 16);
  static const vLg = SizedBox(height: 24);
  static const vXl = SizedBox(height: 32);
  static const vXgl = SizedBox(height: 40);

  /// 🌿 Espaçamentos horizontais
  static const hXs = SizedBox(width: 4);
  static const hSm = SizedBox(width: 8);
  static const hMd = SizedBox(width: 16);
  static const hLg = SizedBox(width: 24);
  static const hXl = SizedBox(width: 32);

  /// 📐 Paddings padrão
  static const paddingXs = EdgeInsets.all(4);
  static const paddingSm = EdgeInsets.all(8);
  static const paddingMd = EdgeInsets.all(16);
  static const paddingLg = EdgeInsets.all(24);
  static const paddingXl = EdgeInsets.all(32);

  /// 📐 Paddings horizontais e verticais separados
  static const paddingH16V8 = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const paddingH24V16 = EdgeInsets.symmetric(horizontal: 24, vertical: 16);
  static const paddingH32V24 = EdgeInsets.symmetric(horizontal: 32, vertical: 24);
}
