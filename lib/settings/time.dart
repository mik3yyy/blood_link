import 'package:flutter/material.dart';

class Time {
  static List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static List<String> daysInMonth = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];

  static List<String> years =
      List.generate(50, (index) => (DateTime.now().year - index).toString());
  static int getMonthIndex(String month) {
    int index = 1;
    for (int i = 0; i < months.length; i++) {
      if (months[i] == month) {
        index = i;
      }
    }
    return index;
  }
}
