import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_visioad_app/core/common%20feature/presentation/widgets/cached_image_widget.dart';
import 'package:test_visioad_app/core/helper/helper.dart';
import 'package:test_visioad_app/core/styles/app_colors.dart';
import 'package:test_visioad_app/core/util/constant/app_constants.dart';
import 'package:test_visioad_app/features/stories/data/data_sources/local_db.dart';
import 'package:test_visioad_app/features/stories/data/entities/story_model.dart';


class StoryListItemWidget extends StatefulWidget {
  final StoryModel model;
  const StoryListItemWidget({super.key, required this.model});
  @override
  State<StoryListItemWidget> createState() =>
      _StoryListItemWidgetState();
}

class _StoryListItemWidgetState extends State<StoryListItemWidget> {
  String? smallImageUrl;
  String? bigImageUrl;
  late List <DatabaseStories> storiesdb = [];

  late final StoriesServices _storiesService;


  @override
  void dispose(){
    _storiesService.close();
    super.initState();
  }

  @override
  void initState() {
    _storiesService = StoriesServices();
    _storiesService.open();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    if (widget.model.multimedia != null &&
        widget.model.multimedia!.isNotEmpty) {
      smallImageUrl = widget.model.multimedia!.last.url;
    }

    // Big image for view and zoom it
    if (widget.model.multimedia != null &&
        widget.model.multimedia!.isNotEmpty) {
      bigImageUrl = widget.model.multimedia!.first.url;
    }
    // _storiesService.createStory(
    //     title:_getTitle(),
    //     abstract:_getAbstract(),
    //     byline:_getAuthor(),
    //     publishedDate: "");




    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circle Avatar

          if (bigImageUrl != null) ...{
            GestureDetector(
              onTap: () {
              },
              child: CachedImageWidget(
                imageUrl: bigImageUrl!,
                radius: 200,
                width: 70.sp,
              ),
            )
          } else ...{
            SizedBox(
              width: 70.sp,
              child: CircleAvatar(
                backgroundColor: AppColors.gray,
                radius: 40,
              ),
            )
          },

          // Space
          SizedBox(
            width: Helper.getVerticalSpace(),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                Text(
                  _getTitle(),
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),

                // Space
                SizedBox(
                  height: Helper.getVerticalSpace(),
                ),

                Text(
                  _getAbstract(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.darkGray),
                ),

                // Space
                SizedBox(
                  height: 5.h,
                ),

                // Author
                Text(
                  _getAuthor(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.darkGray),
                  softWrap: true,
                ),
              ],
            ),
          ),

          // Space
          SizedBox(
            width: Helper.getVerticalSpace(),
          ),

          // Arrow icon
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/story_details_page",
                arguments: widget.model,
              );
            },
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20.sp,
            ),
          ),

        ],
      ),
    );
  }

  // Title
  String _getTitle() {
    if (widget.model.title != null && widget.model.title!.isNotEmpty) {
      return widget.model.title!;
    } else {
      return defaultStr;
    }
  }

  // Title
  String _getAbstract() {
    if (widget.model.title != null && widget.model.title!.isNotEmpty) {
      return widget.model.title!;
    } else {
      return defaultStr;
    }
  }

  // Author
  String _getAuthor() {
    if (widget.model.byline != null && widget.model.byline!.isNotEmpty) {
      return widget.model.byline!;
    } else {
      return defaultStr;
    }
  }




}
