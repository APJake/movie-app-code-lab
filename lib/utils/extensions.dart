extension NumberExtensions on int {
  String toSeparatedString([String separator = ",", int divide = 100]) {
    int num = this;
    List<int> parts = [];
    do {
      // if (value.isNotEmpty) value += ",";
      parts.add(num % divide);
      num = num ~/ divide;
    } while ((num / divide) > 0);

    return parts.reversed.join(separator);
  }
}
