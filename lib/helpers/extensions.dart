// Dart Extensions"
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateTimeExtension on DateTime {
  String asString() {
    initializeDateFormatting('id', null);
    var dateFormat = DateFormat.yMMMMd('id');
    return dateFormat.format(this);
  }

  String asFormatDate() {
    initializeDateFormatting('id', null);
    var dateFormat = DateFormat.yMMMd('id');
    return dateFormat.format(this);
  }

  String asFormatTime() {
    initializeDateFormatting('id', null);
    var dateFormat = DateFormat("HH:mm", 'id_ID');
    return dateFormat.format(this);
  }

  String asFormatTimeAMPM() {
    TimeOfDay _time = TimeOfDay(hour: this.hour, minute: this.minute);
    String time =
        '${_time.hourOfPeriod.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
    return _time.period == DayPeriod.am ? '$time AM' : '$time PM';
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  String asFormatDBDate() {
    var dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(this);
  }

  String asFormatDBTime() {
    var dateFormat = DateFormat('HH:mm:ss');
    return dateFormat.format(this);
  }

  String asFormatDBDateTime() {
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(this);
  }

  // sample format : yyyy-MM-dd | HH:mm:ss
  String format(String pattern) {
    var dateFormat = DateFormat(pattern);
    return dateFormat.format(this);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  bool isBefore(TimeOfDay other) {
    if (this.hour < other.hour) return true;
    if (this.hour == other.hour) {
      if (this.minute < other.minute) return true;
    }
    return false;
  }

  bool isAfter(TimeOfDay other) {
    if (this.hour > other.hour) return true;
    if (this.hour == other.hour) {
      if (this.minute > other.minute) return true;
    }
    return false;
  }

  String encode() {
    int hour = this.hour;
    int minute = this.minute;
    return '$hour:$minute';
  }

  String formatAMPM() {
    String time =
        '${this.hourOfPeriod.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}';
    return this.period == DayPeriod.am ? '$time AM' : '$time PM';
  }

  String format24() {
    return '${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}';
  }
}

extension IntExtension on int {
  // int toInt() => this;

  DateTime toDateTime() {
    return new DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }
}

extension BoolExtension on bool {
  // bool toBool() => this;
}

extension DurationExtension on Duration {
  String toHHNNSS() {
    String hh = this.inHours.toString().padLeft(2, "0");
    String nn = this.inMinutes.remainder(60).toString().padLeft(2, "0");
    String ss = this.inSeconds.remainder(60).toString().padLeft(2, "0");
    return '$hh:$nn:$ss';
  }
}

extension StringExtension on String {
  // double toDouble() => double.parse(this);
  // int toInt() => int.parse(this);
  // bool toBool() => this == '1';
  // DateTime toDateTime() => this == null ? null : DateTime.parse(this);

  String getInitial() => this.isNotEmpty
      ? this.trim().split(' ').map((e) => e[0]).take(2).join()
      : '';

  String separateBySpace() =>
      this.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");

  bool isEmail() => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(this);
  bool isNotEmail() => !RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(this);

  String formatPhoneNumber() => this.isEmpty
      ? ''
      : this.replaceAllMapped(RegExp(r'(\d{2})(\d{3})(\d{4})(\d+)'),
          (Match m) => "(${m[1]}) ${m[2]}-${m[3]}-${m[4]}");

  String formatPSTNNumber() => this.isEmpty
      ? ''
      : this.replaceAllMapped(RegExp(r'(\d{4})(\d{3})(\d{3})(\d+)'),
          (Match m) => "(${m[1]}) ${m[2]} ${m[3]} ${m[4]}");

  // String lang(List<String>? args) {
  //   if (args == null || args.isEmpty) return this;
  //   args.forEach((String str) => this.replaceFirst(RegExp(r'{}'), this));
  //   return this;
  // }
}

extension DoubleExtension on double {
  // double toDouble() => this;

  String toIDR() {
    var f = NumberFormat("#,##0.##", "id_idr");
    return "Rp ${f.format(this)},-";
  }

  String toUSD() {
    var f = NumberFormat("#,##0.##", "en_us");
    return "USD ${f.format(this)}";
  }
}

extension DynamicExtension on dynamic {
  // double toDouble() => this is String ? double.parse(this) : this;
  // int toInt() => this is String ? int.parse(this) : this;
  // bool toBool() => this is String
  //     ? int.parse(this) == 1
  //     : this is int
  //         ? this == 1
  //         : false;
  // DateTime toDateTime() => this == null ? null : DateTime.parse(this);
}
