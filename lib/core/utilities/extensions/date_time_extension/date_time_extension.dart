extension DateTimeExtensions on DateTime {
  int dateSinceEpoch() {
    DateTime dateTime = DateTime(year, month, day, hour, minute);
    return dateTime.millisecondsSinceEpoch;
  }
}
