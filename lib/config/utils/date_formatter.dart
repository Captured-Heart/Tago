import 'package:tago/app.dart';

String dateFormatted() {
  var now = DateTime.now();

  var formatter = DateFormat("EEE, d MMMM, yyyy");
  String formatted = formatter.format(now);

  return formatted;
}

String dateFormatted2(String dateTime) {
  var now = DateTime.tryParse(dateTime);

  var formatter = DateFormat("d MMM");
  String formatted = formatter.format(now!);

  return formatted;
}

String dateFormattedWithYYYY(String dateTime) {
  var now = DateTime.tryParse(dateTime);

  var formatter = DateFormat("d MMMM, yyyy");
  String formatted = formatter.format(now!);

  return formatted;
}

String dateFormatted3(DateTime dateTime) {
  var now = dateTime;

  var formatter = DateFormat("d MMMM, yyyy");
  String formatted = formatter.format(now);

  return formatted;
}

String dateFormattedWithSlash(DateTime dateTime) {
  var now = dateTime;

  var formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(now);

  return formatted;
}

String timeFormatted(TimeOfDay time) {
  var now = DateTime.now();

  var formatter = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat().add_jm().format(formatter);
}

String getDayOfWeek(String dateString) {
  DateTime date = DateFormat("yyyy-MM-dd").parse(dateString);
  String dayOfWeek = DateFormat('EEE').format(date);

  return dayOfWeek;
}
