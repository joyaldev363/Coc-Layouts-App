import 'package:intl/intl.dart';

/// Formatter utility for formatting data types.
class Formatter {
  Formatter._();

  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatCurrency(double amount, {String symbol = '\$'}) {
    final currencyFormatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return currencyFormatter.format(amount);
  }
}
