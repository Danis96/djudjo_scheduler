import 'package:intl/intl.dart';

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

  String returnDateMonthForHomeCard() {
    final List<String> dateParts = split(' - ');
    final DateTime startDate = DateFormat('dd.MM.yyyy').parse(dateParts[0]);
    final String startMonthName = DateFormat.MMMM().format(startDate);
    // Assuming both dates have the same month, you can return the month name of the start date
    return startMonthName;
  }

  int returnDatetimeFormattedForGrouping() {
    return int.parse(split('.')[1]) ;
  }

}
