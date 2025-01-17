import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../data/models/setting/currencies_model.dart';
import '../widgets/custom_text.dart';
import 'constraints.dart';

class Utils {
  static final _selectedDate = DateTime.now();

  static final _initialTime = TimeOfDay.now();

  static String convertToSlug(String input) {
    return input.toLowerCase().replaceAll(RegExp(r'[^a-zA-Z\d]+'), '-');
  }

  static Size mediaQuery(BuildContext context) => MediaQuery.of(context).size;

  static List<TextInputFormatter> inputFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}$'))
  ];

  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static String obfuscateEmail(String email) {
    final emailParts = email.split('@');
    if (emailParts.length != 2) return email;

    final username = emailParts[0];
    final domain = emailParts[1];

    if (username.length <= 4) {
      return email;
    }

    final visibleStart = username.substring(0, 4);
    final visibleEnd = username[username.length - 1];
    final hiddenStars = '*' * (username.length - 5);

    return '$visibleStart$hiddenStars$visibleEnd@$domain';
  }


  static String convertCurrency(var price, BuildContext context, CurrenciesModel c,
      [int radix = 1]) {
    String afterPrice = 'right';
    String afterPriceWithSpace = 'after_price_with_space';
    if (c.status == 1 && (c.currencyPosition.toLowerCase() == afterPrice)) {
      if (price is double) {
        // debugPrint('double-price $price');
        final result = price * c.currencyRate;
        return '${result.toStringAsFixed(radix)}${c.currencyIcon}';
      }
      if (price is String) {
        // debugPrint('String-price $price');
        final r = double.tryParse(price) ?? 0.0;
        final p = r * c.currencyRate;
        return '${p.toStringAsFixed(radix)}${c.currencyIcon}';
      }
      if (price is int) {
        // debugPrint('int-price $price');
        final p = price * c.currencyRate;
        return '${p.toStringAsFixed(radix)}${c.currencyIcon}';
      } else {
        // debugPrint('other-price $price');
        return '${price * c.currencyRate.toStringAsFixed(radix)}${c.currencyIcon}';
      }
    } else {
      if (price is double) {
        final result = price * c.currencyRate;
        return '${c.currencyIcon}${result.toStringAsFixed(radix)}';
      }
      if (price is String) {
        final r = double.tryParse(price) ?? 0.0;
        final p = r * c.currencyRate;
        return '${c.currencyIcon}${p.toStringAsFixed(radix)}';
      }
      if (price is int) {
        // debugPrint('int-price $price');
        final p = price * c.currencyRate;
        return '${c.currencyIcon}${p.toStringAsFixed(radix)}';
      }
      return '${c.currencyIcon}${price * c.currencyRate.toStringAsFixed(radix)}';
    }
  }

  static String imageContent(BuildContext context, String key) {
    // final webSetting = context.read<AppSettingCubit>().settingModel;
    // if (webSetting != null && webSetting.imageContent![key] != null) {
    //   return RemoteUrls.imageUrl(webSetting.imageContent![key]!);
    // } else {
    return key;
    //}
  }

  static Uri tokenWithCode(String url, String token, String langCode) {
    return Uri.parse(url)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
  }

  static Uri tokenWithQuery(String url, String token, String langCode,
      {Map<String, dynamic>? extraParams}) {
    final baseUri = Uri.parse(url);
    final queryParams = {
      'token': token,
      'lang_code': langCode,
      ...extraParams!,
    };
    return baseUri.replace(queryParameters: queryParams);
  }

  static Uri tokenWithCodeAndPage(
      String url, String token, String langCode, String page) {
    return Uri.parse(url).replace(
        queryParameters: {'token': token, 'lang_code': langCode, 'page': page});
  }

  static Future<String?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static Future<List<String?>> pickMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<String> imageList = [];
    final List<XFile?> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      for (var i in images) {
        imageList.add(i!.path.toString());
      }
      debugPrint('picked images: ${imageList.length}');
      return imageList;
    }
    return [];
  }

  static String timeWithData(String data, [bool timeAndDate = true]) {
    if (timeAndDate) {
      DateTime dateTime = DateTime.parse(data);
      String formattedDate =
          DateFormat('h:mm a - MMM d, yyyy').format(dateTime);
      return formattedDate;
    } else {
      DateTime dateTime = DateTime.parse(data);
      String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
      return formattedDate;
    }
  }

  static List<dynamic> parseJsonToString(String? text, [bool isTags = true]) {
    List tags = [];

    if (text != null && text.isNotEmpty && text.toLowerCase() != 'null') {
      try {
        List<dynamic> parsedJson = jsonDecode(text.replaceAll('&quot;', '"'));
        if (isTags) {
          tags = parsedJson.map((tag) => tag['value']).toList();
          //print('values-tag $tags');
        } else {
          tags = parsedJson.map((tag) => tag).toList();
          //print('list-tag $tags');
        }
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    }

    return tags;
  }

  static String convertToAgo(String? time) {
    Duration diff = DateTime.now().difference(DateTime.parse(time!));
    try {
      if (diff.inDays >= 1) {
        return '${diff.inDays} days ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} hours ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} minutes ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} seconds ago';
      } else {
        return 'Just Now';
      }
    } catch (e) {
      return '';
    }
  }

  static Widget verticalSpace(double size) {
    return SizedBox(height: size.h);
  }

  static Widget horizontalSpace(double size) {
    return SizedBox(width: size.w);
  }

  static double hSize(double size) {
    return size.w;
  }

  static double vSize(double size) {
    return size.h;
  }

  static EdgeInsets symmetric({double h = 16.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius.sp;
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets all({double value = 0.0}) {
    return EdgeInsets.all(value.dm);
  }

  static EdgeInsets only(
      {double left = 0.0,
      double top = 0.0,
      double right = 0.0,
      double bottom = 0.0}) {
    return EdgeInsets.only(
        left: left.w, top: top.h, right: right.w, bottom: bottom.h);
  }

  static double vPadding({double size = 20.0}) {
    return size.h;
  }

  static double hPadding({double size = 20.0}) {
    return size.w;
  }

  static double toDouble(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static double toInt(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050),
      );

  static Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: _initialTime);

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static loadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    showCustomDialog(
      context,
      child: Container(
        height: Utils.vSize(120.0),
        padding: Utils.all(value: 20.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: primaryColor),
              Utils.horizontalSpace(15.0),
              const CustomText(text: 'Please wait a moment')
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.of(context).pop(true);
    }
  }

  static Future showCustomDialog(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
    Color bgColor = whiteColor,
    EdgeInsets? padding,
    double? radius,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        final p = padding ?? Utils.symmetric();
        final r = radius ?? 6.0;
        return Dialog(
          backgroundColor: bgColor,
          insetPadding: p,
          shape: RoundedRectangleBorder(
            borderRadius: Utils.borderRadius(r: Utils.radius(r)),
          ),
          child: child,
        );
      },
    );
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(errorMsg, style: const TextStyle(color: Colors.red)),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = whiteColor, int time = 1000]) {
    final snackBar = SnackBar(
        duration: Duration(milliseconds: time),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void serviceUnAvailable(BuildContext context, String msg,
      [Color textColor = Colors.white]) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 500),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSnackBarWithAction(
      BuildContext context, String msg, VoidCallback onPress,
      [Color textColor = primaryColor]) {
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: 'Active',
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
