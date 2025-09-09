import 'package:intl/intl.dart';

class DateHelperUtil {
  /// Formata para 'dd/MM/yyyy'
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Formata para 'dd-MM-yyyy HH:mm:ss'
  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(date);
  }

  /// Converte de String 'yyyy-MM-dd' para 'dd/MM/yyyy'
  static String convertFromIso(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return formatDate(date);
    } catch (e) {
      return isoDate;
    }
  }

  /// Converte de String 'dd/MM/yyyy' para 'yyyy-MM-dd'
  static String convertToIso(String brDate) {
    try {
      final parts = brDate.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final date = DateTime(year, month, day);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return brDate;
    }
  }

  /// Valida se a string está no formato 'dd/MM/yyyy'
  static bool isValidBrDate(String value) {
    try {
      final parts = value.split('/');
      if (parts.length != 3) return false;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      DateTime date = DateTime(year, month, day);
      return date.day == day && date.month == month && date.year == year;
    } catch (e) {
      return false;
    }
  }

  /// Obtém data atual formatada como 'dd/MM/yyyy'
  static String todayBr() {
    return formatDate(DateTime.now());
  }

  /// Converte uma string no formato 'dd/MM/yyyy' para um objeto DateTime
  static DateTime? parseBrDateToDateTime(String brDate) {
    try {
      final parts = brDate.split('/');
      if (parts.length != 3) return null;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }
}
