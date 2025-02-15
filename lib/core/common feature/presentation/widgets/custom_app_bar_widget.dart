import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_visioad_app/core/helper/helper.dart';
import 'package:test_visioad_app/core/styles/app_colors.dart';


class CustomAppBarWidget extends StatelessWidget {
  final double? height;
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomAppBarWidget({
    Key? key,
    this.height,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: height ?? 60.h,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.darkGray.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading
          if (leading != null) ...{
            leading!,
            SizedBox(
              width: Helper.getHorizontalSpace(),
            ),
          },

          // Title
          if (title != null) ...{
            Expanded(
              child: Center(child: title!),
            ),
            SizedBox(
              width: Helper.getHorizontalSpace(),
            ),
          },

          // Actions
          if (actions != null) ...{
            Row(
              children: actions!.map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                  ),
                  child: e,
                );
              }).toList(),
            ),
          }
        ],
      ),
    );
  }
}
