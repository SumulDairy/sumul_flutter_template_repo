import 'package:intl/intl.dart';
import 'package:sumul_transport/common/functions.dart';

class OrderTimeWindowResponseModel {
  bool? status;
  String? message;
  List<OrderTimeWindow>? data;

  OrderTimeWindowResponseModel({this.status, this.message, this.data});

  factory OrderTimeWindowResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderTimeWindowResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<OrderTimeWindow>.from(
                json["data"]!.map((x) => OrderTimeWindow.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

// class OrderTimeWindow {
//   String? ordertype;
//   String? start;
//   String? end;
//   String? shift;
//   late final DateTime parsedStartTime;
//   late final DateTime parsedEndTime;
//   OrderTimeWindow({this.ordertype, this.shift, this.start, this.end}) {
//     parsedStartTime = _parseTime(start!);
//     parsedEndTime = _parseTime(end!);
//   }

//   factory OrderTimeWindow.fromJson(Map<String, dynamic> json) =>
//       OrderTimeWindow(
//         ordertype: json["ordertype"],
//         start: json["start"],
//         end: json["end"],
//         shift: json["shift"],
//       );

//   Map<String, dynamic> toJson() => {
//     "ordertype": ordertype,
//     "start": start,
//     "end": end,
//     "shift": shift,
//   };

//   DateTime _parseTime(String timeStr) {
//     final now = DateTime.now();
//     final format = DateFormat.jm(); // e.g., 07:00 AM
//     final time = format.parse(timeStr);
//     return DateTime(now.year, now.month, now.day, time.hour, time.minute);
//   }

//   DateTime get parsedStartTime => _parseTime(start!);
//   DateTime get parsedEndTime => _parseTime(end!);

//   bool isActiveNow() {
//     final now = DateTime.now();
//     final startTime = parsedStartTime;
//     final endTime = parsedEndTime;

//     if (endTime.isBefore(startTime)) {
//       return now.isAfter(startTime) || now.isBefore(endTime);
//     } else {
//       return now.isAfter(startTime) && now.isBefore(endTime);
//     }
//   }
// }

class OrderTimeWindow {
  String? ordertype;
  String? start;
  String? end;
  String? shift;
  DateTime? fixedStartTime;
  DateTime? fixedEndTime;
  OrderTimeWindow({
    this.ordertype,
    this.start,
    this.end,
    this.shift,
    this.fixedStartTime,
    this.fixedEndTime,
  });

  factory OrderTimeWindow.fromJson(Map<String, dynamic> json) =>
      OrderTimeWindow(
        ordertype: json["ordertype"],
        start: json["start"],
        end: json["end"],
        shift: json["shift"],
      );

  Map<String, dynamic> toJson() => {
    "ordertype": ordertype,
    "start": start,
    "end": end,
    "shift": shift,
  };
  // DateTime get parsedStartTime => _parseTime(start);
  // DateTime get parsedEndTime => _parseTime(end);

  DateTime parsedStartTimeWithDate(DateTime baseDate) =>
      _parseTime(start, baseDate: baseDate);

  DateTime parsedEndTimeWithDate(DateTime baseDate) =>
      _parseTime(end, baseDate: baseDate);

  // DateTime _parseTime(String? timeStr, {DateTime? baseDate}) {
  //   try {
  //     final cleaned = (timeStr ?? '12:00 AM')
  //         .replaceAll(RegExp(r'\u00A0'), ' ')
  //         .replaceAll(RegExp(r'\s+'), ' ')
  //         .trim();

  //     final time = DateFormat.jm().parse(cleaned);
  //     final base = baseDate ?? DateTime.now();
  //     return DateTime(base.year, base.month, base.day, time.hour, time.minute);
  //   } catch (e) {
  //     // debugPrint('⚠️ Error parsing time "$timeStr": $e');
  //     return DateTime.now(); // fallback
  //   }
  // }
  DateTime _parseTime(String? timeStr, {DateTime? baseDate}) {
    try {
      if (timeStr == null || timeStr.trim().isEmpty) {
        throw FormatException("Empty or null time string");
      }

      final cleaned = timeStr
          .replaceAll(RegExp(r'[\u00A0\u202F\u2007\u2060]'), ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim()
          .toUpperCase();

      final time = Intl.withLocale(
        'en',
        () => DateFormat.jm().parseLoose(cleaned),
      );

      final base = baseDate ?? DateTime.now();
      return DateTime(base.year, base.month, base.day, time.hour, time.minute);
    } catch (e) {
      AllFunction.safeLog('⚠️ Error parsing time "$timeStr": $e');
      return DateTime.now();
    }
  }

  // /// Used in _findNextShift to clone with modified DateTimes (e.g., for next day)
  // OrderTimeWindow copyWithParsedTimes({
  //   required DateTime startTime,
  //   required DateTime endTime,
  // }) {
  //   return OrderTimeWindow(
  //       ordertype: ordertype,
  //       shift: shift,
  //       start: DateFormat.jm().format(startTime),
  //       end: DateFormat.jm().format(endTime),
  //     )
  //     ..fixedStartTime = startTime
  //     ..fixedEndTime = endTime;
  // }
  /// ✅ Used in _findNextShift to clone with fixed parsed DateTimes

  OrderTimeWindow copyWithParsedTimes({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return OrderTimeWindow(
      ordertype: ordertype,
      shift: shift,
      start: DateFormat.jm().format(startTime),
      end: DateFormat.jm().format(endTime),
      fixedStartTime: startTime,
      fixedEndTime: endTime,
    );
  }
}

class MenuGroup {
  final String titleKey;
  final List<MenuItem> items;
  bool isExpanded;

  MenuGroup({
    required this.titleKey,
    required this.items,
    this.isExpanded = false,
  });
  String get title => titleKey;
}

class MenuItem {
  final String titleKey;
  final String iconPath;
  final bool? isVisible;

  MenuItem({
    required this.titleKey,
    required this.iconPath,
    this.isVisible = true,
  });
  String get title => titleKey;
}
