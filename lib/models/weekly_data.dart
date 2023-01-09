// utils
import '../utils/get_week.dart';

Map<String, dynamic> map1 = {'zero': 0, 'one': 1, 'two': 2};

class WeeklyData {
  String id;
  int year;
  int month;
  int week;
  var amounts;
  int dailyTarget;

  WeeklyData(
      {this.id = "",
      this.year = 0,
      this.month = 0,
      this.week = 0,
      this.amounts = null,
      this.dailyTarget = 0});

  factory WeeklyData.fromDoc(Map<String, dynamic> doc) {
    Map<String, dynamic> rawAmounts =
        doc.containsKey('amounts') ? doc['amounts'] : {};
    for (int i = 1; i <= 7; i++) {
      if (!rawAmounts.containsKey(i.toString())) {
        rawAmounts[i.toString()] = 0;
      }
    }
    return WeeklyData(
        id: doc['id'],
        year: doc['year'],
        month: doc['month'],
        week: doc['week'],
        amounts: rawAmounts,
        dailyTarget: doc['daily_target']);
  }

  Map<String, dynamic> createNewWeek(
      String id, int year, int month, int week, int target) {
    return {
      'id': id,
      'year': year,
      'month': month,
      'week': week,
      'daily_target': target
    };
  }

  double totalThisWeek() {
    double total = 0;
    amounts.forEach((key, value) {
      total += value;
    });
    return total;
  }

  int percentThisWeek() {
    DateTime today = DateTime.now();
    int thisWeek = getWeek(today);
    double max;
    if (thisWeek == week && today.year == year) {
      max = (dailyTarget * DateTime.now().weekday).toDouble();
    } else {
      max = (dailyTarget * 7).toDouble();
    }
    double total = totalThisWeek();
    return ((total / max) * 100).toInt();
  }
}
