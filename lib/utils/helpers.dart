import 'dart:convert';
import 'dart:math';
import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/models/transaction/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'extensions.dart';

String checkDataNullOrEmpty(
  data,
  whenNullString,
) {
  if (data != null) {
    if (data.toString() != "") {
      return data;
    } else {
      return whenNullString;
    }
  } else {
    return whenNullString;
  }
}

String getPaymentIcon(TransactionModel data) {
  if (data.payment_method == "QRIS" &&
      (data.invoice == null ||
          DateExt.checkIsExpired(data.invoice!.expired_in!))) {
    return "assets/icons/ic_close.svg";
  }

  switch (data.payment_status) {
    case "pending":
      return "assets/icons/ic_pending.svg";
    case "paid":
      return "assets/icons/ic_success.svg";
    default:
      return "assets/icons/ic_close.svg";
  }
}

String getPaymentString(TransactionModel data) {
  if (data.payment_method == "QRIS" &&
      (data.invoice == null ||
          DateExt.checkIsExpired(data.invoice!.expired_in!))) {
    return "Pembayaran Expired";
  }

  return {
        "pending": "Menunggu Pembayaran",
        "paid": "Pembayaran Berhasil"
      }[data.payment_status] ??
      "Pembayaran Gagal";
}

String getPaymentStringSimple(TransactionModel data) {
  if (data.payment_method == "QRIS" &&
      (data.invoice == null ||
          DateExt.checkIsExpired(data.invoice!.expired_in!))) {
    return "EXPIRED";
  }

  return {"pending": "PENDING", "paid": "PAID"}[data.payment_status] ??
      "FAILED";
}

Color getPaymentColor(TransactionModel data) {
  final ThemeController _theme = Get.find(tag: "ThemeController");
  if (data.payment_method == "QRIS" &&
      (data.invoice == null ||
          DateExt.checkIsExpired(data.invoice!.expired_in!))) {
    return _theme.error[1];
  }

  switch (data.payment_status) {
    case "pending":
      return _theme.warning[1];
    case "paid":
      return _theme.success[1];
    default:
      return _theme.error[1];
  }
}

double calculateDistance(lat1, long1, lat2, long2) {
  var p =
      0.017453292519943295; //conversion factor from radians to decimal degrees, exactly math.pi/180
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((long2 - long1) * p)) / 2;
  var radiusOfEarth = 6371;
  var total = radiusOfEarth * 2 * asin(sqrt(a));

  return total;
}

String getNameFromStatus(String status) {
  if (status == "all") {
    return "Semua";
  } else if (status == "unconfirm") {
    return "Belum Dikonfirmasi";
  } else if (status == "waiting") {
    return "Menunggu Jemputan";
  } else if (status == "done") {
    return "Selesai";
  } else if (status == "cancel") {
    return "Dibatalkan";
  } else {
    return "Semua";
  }
}

launchURL(_url) async {
  final Uri url = Uri.parse(_url);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $_url');
  }
}

List<String> parseStringToList(String text) {
  var _data = json.decode(text).cast<String>().toList();
  return _data;
}

Alignment getGradientRotate(num degree) {
  degree -= 90;
  final x = cos(degree * pi / 180);
  final y = sin(degree * pi / 180);
  final xAbs = x.abs();
  final yAbs = y.abs();

  if ((0.0 < xAbs && xAbs < 1.0) || (0.0 < yAbs && yAbs < 1.0)) {
    final magnification = (1 / xAbs) < (1 / yAbs) ? (1 / xAbs) : (1 / yAbs);
    return Alignment(x, y) * magnification;
  } else {
    return Alignment(x, y);
  }
}

openMap(address) async {
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$address';
  if (await canLaunchUrl(Uri.parse(googleUrl))) {
    await launchUrl(Uri.parse(googleUrl));
  } else {
    throw 'Could not open the map.';
  }
}

String getExtensionFromFile(String file) {
  return file.split("/").last.split(".").last;
}

String getGreetingByHour() {
  var _hour = DateTime.now();

  if (_hour.hour >= 4 && _hour.hour < 12) {
    return "Good Morning";
  } else if (_hour.hour >= 12 && _hour.hour <= 18) {
    return "Good Afternoon";
  } else if (_hour.hour > 18 && _hour.hour < 4) {
    return "Good Evening";
  } else if (_hour.hour == 0) {
    return "Good Evening";
  } else {
    return "Good Morning";
  }
}

String getDateAutoName(String _startDate, String _endDate) {
  if (_startDate.substring(5, 7) == _endDate.substring(5, 7)) {
    if (_startDate.substring(8, 10) == _endDate.substring(8, 10)) {
      return "${DateExt.reformat(_startDate, "yyyy-MM-dd", "d MMM yyyy")}";
    } else {
      return "${DateExt.reformat(_startDate, "yyyy-MM-dd", "d")} - ${DateExt.reformat(_endDate, "yyyy-MM-dd", "d MMM yyyy")}";
    }
  } else {
    return "${DateExt.reformat(_startDate, "yyyy-MM-dd", "d MMM")} - ${DateExt.reformat(_endDate, "yyyy-MM-dd", "d MMM yyyy")}";
  }
}

openDialog(context, child) {
  FocusScope.of(context).unfocus();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxWidth: OtherExt().getWidth(context),
    ),
    builder: (context) {
      return child;
    },
  );
}
