import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_visioad_app/core/common%20feature/presentation/pages/background_page.dart';
import 'package:test_visioad_app/core/common%20feature/presentation/widgets/arrow_back_button_widget.dart';
import 'package:test_visioad_app/core/common%20feature/presentation/widgets/cached_image_widget.dart';
import 'package:test_visioad_app/core/common%20feature/presentation/widgets/custom_app_bar_widget.dart';
import 'package:test_visioad_app/core/helper/helper.dart';
import 'package:test_visioad_app/core/styles/app_colors.dart';
import 'package:test_visioad_app/core/util/constant/app_constants.dart';
import 'package:test_visioad_app/features/stories/data/entities/story_model.dart';

class StoryDetailsPage extends StatefulWidget {
  final StoryModel model;

  const StoryDetailsPage({Key? key, required this.model}) : super(key: key);

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  String? imageUrl;
  String? imageCaption;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // I put it here because it is not updated when apply search because they don't enter the initState again
    // so I should but it here to update it when chane list item

    // Check if somethings happened and do not return media
    // If everything seems to be in order we will display the image
    // else display placeholder instead

    // Big image for view and zoom it
    if (widget.model.multimedia != null &&
        widget.model.multimedia!.isNotEmpty) {
      imageUrl = widget.model.multimedia!.first.url;
      imageCaption = widget.model.multimedia!.last.caption;
    }

    return BackgroundPage(
      child: Column(
        children: [
          // Custom App Bar
          CustomAppBarWidget(
            title: Text(
              "${widget.model.section ?? defaultStr}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            leading: ArrowBackButtonWidget(),
          ),

          // Details
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title, abstract attribute and published date
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: Helper.getHorizontalSpace(),
                          ),

                          // Title
                          Text(
                            widget.model.title ?? defaultStr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                          ),

                          // Space
                          SizedBox(
                            height: Helper.getHorizontalSpace() / 2,
                          ),

                          // Title
                          Text(
                            widget.model.abstract ?? defaultStr,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          // Space
                          SizedBox(
                            height: Helper.getHorizontalSpace() * 2,
                          ),

                          // Caption
                          Text(
                            widget.model.byline ?? defaultStr,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                            textAlign: TextAlign.start,
                          ),

                          // Space
                          SizedBox(
                            height: 3.h,
                          ),

                          // Published Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 15,
                                color: AppColors.gray,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Flexible(
                                child: Text(
                                  _buildPublishDate(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: AppColors.darkGray),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          // Space
                          SizedBox(
                            height: Helper.getHorizontalSpace(),
                          ),
                        ],
                      )),

                  // Image
                  GestureDetector(
                    onTap: () {
                      if (imageUrl != null) {
                      }
                    },
                    child: Stack(
                      children: [
                        CachedImageWidget(
                          imageUrl: imageUrl ?? defaultStr,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? ScreenUtil().screenHeight * 0.4
                              : ScreenUtil().screenWidth * 0.4,
                          width: ScreenUtil().screenWidth,
                        ),

                        // Shadow
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppColors.primaryColor.withOpacity(0.7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.7, 0.9],
                              ),
                            ),
                          ),
                        ),

                        // Caption
                        // Display Caption when image not valid
                        if (imageUrl == null || imageUrl == "")
                          Positioned(
                            bottom: 10.h,
                            left: 10.w,
                            right: 10.w,
                            child: Text(
                              _buildCaption(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Adx keywords attribute
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Helper.getHorizontalSpace(),
                          ),

                          // Adx keywords


                          // Space
                          SizedBox(
                            height: Helper.getHorizontalSpace() * 3,
                          ),



                          // Space
                          SizedBox(
                            height: Helper.getHorizontalSpace(),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Caption
  String _buildCaption() {
    if (imageCaption == null || imageCaption == "") {
      return defaultStr;
    }
    return imageCaption!;
  }

  // Publish Date
  String _buildPublishDate() {
    if (widget.model.publishedDate == null ||
        widget.model.publishedDate == "") {
      return defaultStr;
    }
    return Helper.formatDate(widget.model.publishedDate!);
  }
}
