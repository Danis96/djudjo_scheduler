import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringAdditions on String {
  String returnSplittedTime() {
    return split('(')[1].split(')')[0];
  }

  String returnTimeForHomeCard() {
    return split('-')[0] + ' h ' + ' - ' + split('-')[1] + ' h ';
  }

  String returnDateDayForHomeCard() {
    return split('-')[0].split('.')[0];
  }

  String returnDateMonthForHomeSeparator() {
    final List<String> dateParts = split('-');
    final DateTime startDate = DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]));
    final String startMonthName = DateFormat.MMMM().format(startDate);
    // // Assuming both dates have the same month, you can return the month name of the start date
    return startMonthName;
  }

  String returnDateMonthForHomeCard() {
    final DateTime startDate = DateFormat('dd.MM.yyyy').parse(this);
    final String startMonthName = DateFormat.MMMM().format(startDate);
    // // Assuming both dates have the same month, you can return the month name of the start date
    return startMonthName;
  }

  String returnDatetimeFormattedForGrouping() {
    // if contains - that means it has range (2 dates)
    if (contains('-')) {
      final String s = split(' - ')[0].split('.')[2] + '-' + split(' - ')[0].split('.')[1];
      return s;
    } else {
      final String s = split('.')[2] + '-' + split('.')[1];
      return s;
    }
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: this);
    await launchUrl(launchUri);
  }

  Future<void> emailTo() async {
    final Uri launchUri = Uri(scheme: 'mailto', path: this);
    await launchUrl(launchUri);
  }

  int returnTimeRangeHours(int i) => int.parse(split('-')[i].split(':')[0]);

  int returnTimeRangeMinutes(int i) => int.parse(split('-')[i].split(':')[1]);
}
