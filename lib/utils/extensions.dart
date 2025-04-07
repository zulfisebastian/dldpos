import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OtherExt {
  getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

class StringExt {
  static String findPhone(noHP) {
    var result = "";
    if (noHP.length < 4) {
      return "";
    } else {
      var kode = noHP.substring(0, 4);
      switch (kode) {
        case "0811":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0812":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0813":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0821":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0822":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0823":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0851":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0852":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0853":
          result = "assets/images/img_logo_telkomsel.png";
          break;
        case "0814":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0815":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0816":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0854":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0855":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0856":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0857":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0858":
          result = "assets/images/img_logo_im3.png";
          break;
        case "0881":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0882":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0883":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0884":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0885":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0886":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0887":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0888":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0889":
          result = "assets/images/img_logo_smartfren.png";
          break;
        case "0817":
          result = "assets/images/img_logo_xl.png";
          break;
        case "0818":
          result = "assets/images/img_logo_xl.png";
          break;
        case "0819":
          result = "assets/images/img_logo_xl.png";
          break;
        case "0859":
          result = "assets/images/img_logo_xl.png";
          break;
        case "0877":
          result = "assets/images/img_logo_xl.png";
          break;
        case "0878":
          result = "assets/images/img_logo_xl.png";
          break;
        case "0879":
          result = "assets/images/img_logo_xl.png";
          break;
        case "0895":
          result = "assets/images/img_logo_3.png";
          break;
        case "0896":
          result = "assets/images/img_logo_3.png";
          break;
        case "0897":
          result = "assets/images/img_logo_3.png";
          break;
        case "0898":
          result = "assets/images/img_logo_3.png";
          break;
        case "0899":
          result = "assets/images/img_logo_3.png";
          break;
        case "0832":
          result = "assets/images/img_logo_axis.png";
          break;
        case "0833":
          result = "assets/images/img_logo_axis.png";
          break;
        case "0838":
          result = "assets/images/img_logo_axis.png";
          break;
        default:
          result = "";
      }
      return result;
    }
  }

  static String getPostpaidPhone(code) {
    switch (code) {
      case "im3":
        return "ISATP";
      case "telkomsel":
        return "HALO";
      case "axis":
        return "AXIS";
      case "3":
        return "THREE";
      case "xl":
        return "XPLOR";
      case "smartfren":
        return "SMART";
      default:
        return "HALO";
    }
  }

  static String getProviderPhone(code) {
    switch (code) {
      case "im3":
        return "INDOSAT";
      case "telkomsel":
        return "Telkomsel";
      case "axis":
        return "AXIS";
      case "3":
        return "Three";
      case "xl":
        return "XL";
      case "smartfren":
        return "SmartFren";
      default:
        return "Telkomsel";
    }
  }

  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  static String formatRupiah(number, prefix, suffix) {
    var _formattedNumber = NumberFormat("#,##0", "id_ID").format(number);
    return "$prefix$_formattedNumber$suffix";
  }

  static String hideMiddleCode(String code) {
    try {
      return "${code.substring(0, 3)}****${code.substring(7)}";
    } catch (er) {
      return "";
    }
  }

  static String thousandFormatter(number) {
    var _formattedNumber = NumberFormat("#,##0", "id_ID").format(number);
    return "$_formattedNumber";
  }

  static String getInitialTwoName(String name) {
    var _splitText = name.split(" ");
    if (_splitText.length > 1) {
      return "${_splitText[0].substring(0, 1)}${_splitText[1].substring(0, 1)}";
    } else {
      return name.substring(0, 2).toUpperCase();
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class DateExt {
  static String reformat(
    String date,
    String realFormat,
    String expectedFormat,
  ) {
    var _result = DateFormat(expectedFormat, "ID").format(
      DateFormat(realFormat).parse(date),
    );
    return _result;
  }

  static String reformatToLocal(
    String date,
    String realFormat,
    String expectedFormat,
  ) {
    var dateValue = new DateFormat(realFormat).parseUTC(date).toLocal();
    String _result = DateFormat(expectedFormat).format(dateValue);
    return _result;
  }

  static checkIsExpired(String date) {
    DateTime targetDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(date).add(Duration(hours: 7));
    DateTime now = DateTime.now();

    return now.isAfter(targetDate);
  }

  static calculateDiffDate(String date) {
    DateTime a = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);

    final birthday = DateFormat("yyyy-MM-dd HH:mm:ss").parse(a.toString());
    final today = DateTime.now();

    Duration difference = today.difference(birthday);

    int week = difference.inDays > 7 ? difference.inDays ~/ 7 : 0;
    int month = (difference.inDays % 365) ~/ 30;
    int year = difference.inDays ~/ 365;
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;
    if (year > 0) {
      return "${year} tahun lalu";
    }
    if (month > 0) {
      return "${month} bulan lalu";
    }
    if (week > 0) {
      return "${week} minggu lalu";
    }
    if (days > 0) {
      return "${days} hari lalu";
    }
    if (hours > 1) {
      return "${hours} jam lalu";
    }
    if (minutes > 1) {
      return "${minutes} menit lalu";
    }
    if (seconds > 0) {
      return "${seconds} detik lalu";
    }
    return "beberapa detik lalu";
  }

  static calculateAge(String _tgl) {
    var age = "";
    DateTime today = DateTime.now();
    DateTime tgl = DateTime.parse(_tgl);
    final year = today.year - tgl.year;
    final mth = today.month - tgl.month;
    if (mth < 0) {
      age = "0";
    } else {
      age = year.toString();
    }
    return age;
  }

  static String calculatePeriode(
    String startDate,
    String endDate,
  ) {
    var _startYear = startDate.substring(0, 4);
    var _endYear = endDate.substring(0, 4);

    var _startMonth = startDate.substring(5, 7);
    var _endMonth = endDate.substring(5, 7);

    if (startDate == endDate) {
      return reformat(startDate, "yyyy-MM-dd", "dd MMM yyyy");
    } else {
      if (_startYear == _endYear) {
        if (_startMonth == _endMonth) {
          return reformat(startDate, "yyyy-MM-dd", "dd") +
              " - " +
              reformat(endDate, "yyyy-MM-dd", "dd") +
              " " +
              reformat(startDate, "yyyy-MM-dd", "MMM yyyy");
        }

        return reformat(startDate, "yyyy-MM-dd", "dd MM") +
            " - " +
            reformat(endDate, "yyyy-MM-dd", "dd MM") +
            " " +
            reformat(startDate, "yyyy-MM-dd", "yyyy");
      } else {
        return reformat(startDate, "yyyy-MM-dd", "dd MM yyyy") +
            " - " +
            reformat(endDate, "yyyy-MM-dd", "dd MM yyyy");
      }
    }
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension RGBAColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromRGBA(String string) {
    var _list = string.replaceAll("rgba(", "").replaceAll(")", "").trim();
    var _listColor = _list.split(",");
    return Color.fromARGB(
      int.parse(_listColor[3].replaceAll(".", "").toString()),
      int.parse(_listColor[0].toString()),
      int.parse(_listColor[1].toString()),
      int.parse(_listColor[2].toString()),
    );
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
