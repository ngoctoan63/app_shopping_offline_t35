extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String doubleFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}
