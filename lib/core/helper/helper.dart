import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Helper {
  // Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  // Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  // Format date to standard format
  static formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
