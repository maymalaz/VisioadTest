import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_visioad_app/core/common%20feature/presentation/pages/background_page.dart';
import 'package:test_visioad_app/core/common%20feature/presentation/widgets/app_loader.dart';
import 'package:test_visioad_app/core/helper/helper.dart';
import 'package:test_visioad_app/core/styles/app_colors.dart';
import 'package:test_visioad_app/features/stories/data/entities/section_stories_enum.dart';
import 'package:test_visioad_app/features/stories/data/entities/stories_param.dart';
import 'package:test_visioad_app/features/stories/data/entities/story_model.dart';
import 'package:test_visioad_app/features/stories/presentation/providers/stories_providers.dart';
import 'package:test_visioad_app/features/stories/presentation/widgets/story_list_item_widget.dart';

import '../../data/data_sources/local_db.dart';

class StoriesPage extends ConsumerStatefulWidget {
  static const String routeName = 'DashboardScreen';

  const StoriesPage({super.key});

  @override
  ConsumerState<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends ConsumerState<StoriesPage> {
  late List<DatabaseStories> storiesdb = [];
  late List<StoryModel> storiestoList = [];

  // Key for scaffold to open drawer
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // Refresh controller for list view
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // Selected story section
  StorySectionEnum selectedStorySection = StorySectionEnum.home;
  StorySectionEnum tempStorySection = StorySectionEnum.home;

  // Grid/List View
  bool isListView = true;

  OutlineInputBorder defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: AppColors.gray, width: 1),
  );

  late final StoriesServices _storiesService;

  @override
  void dispose() {
    _storiesService.close();
    super.initState();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getStories();
    });
    _storiesService = StoriesServices();
    _storiesService.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      scaffoldKey: _key,
      child: Expanded(
        child: Column(
          children: [
            // Space
            SizedBox(
              height: Helper.getVerticalSpace(),
            ),

            FutureBuilder<List<DatabaseStories>>(
              future: _storiesService.getAllTheSorties(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    storiesdb = snapshot.data!;

                    return Container();

                  default:
                    return Container();
                }
              },
            ),
            // Stories, Loading and Error Widget
            Consumer(builder: (_, ref, __) {
              // ref.watch for rebuilding widgets on state changes
              final storiesState = ref.watch(storiesStateNotifierProvider);

              return Expanded(
                child: storiesState.maybeMap(
                  initial: (value) {
                    return const AppLoader();
                  },
                  loading: (value) {
                    return const AppLoader();
                  },
                  success: (value) {
                    return _buildListStories(
                      context,
                      value.stories,
                    );
                  },
                  orElse: () {
                    return const Text("UnSupported Widget");
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

// Stories grid view, Loading and Error Widget
  _buildListStories(BuildContext context, List<StoryModel> stories) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: const WaterDropHeader(
        waterDropColor: AppColors.primaryColor,
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: null,
      child: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          _storiesService.createStory(
              title: stories[index].title.toString(),
              abstract: stories[index].abstract.toString(),
              byline: stories[index].byline.toString(),
              publishedDate: stories[index].publishedDate.toString());

          storiesdb.forEach((element) {
            storiestoList.add(StoryModel(title:element.title, abstract:element.abstract,byline: element.byline,publishedDate:element.publishedDate) );

          });
          bool internet_checker= true;
          Future<bool> checkConnectivity() async {
            var connectivityResult = await Connectivity().checkConnectivity();
            if (connectivityResult == ConnectivityResult.mobile) {
              print('Connected to Mobile Network');
              internet_checker= true;
            } else if (connectivityResult == ConnectivityResult.wifi) {
              print('Connected to WiFi');
              internet_checker= true;


            } else {
              print('No Internet Connection');
              internet_checker= false;

            }
            return internet_checker;

          }
          if( checkConnectivity()==true){
            return StoryListItemWidget(model: stories[index]);

          }
          else
            return StoryListItemWidget(model: stories[index]);
            // return StoryListItemWidget(model: storiestoList[index]);


        },
      ),
    );
  }

  // Refresh method called when pull down list
  void _onRefresh() async {
    _getStories();
  }

  // Build actions in app bar
  List<Widget> _buildActions() {
    return [
      // List view
      CircleAvatar(
        backgroundColor: isListView
            ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)
            : AppColors.transparent,
        radius: 15.sp,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              isListView = true;
            });
          },
          icon: Icon(
            Icons.format_list_bulleted,
            color: isListView
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).iconTheme.color,
            size: 20.sp,
          ),
        ),
      ),

      // Grid view
      CircleAvatar(
        backgroundColor: !isListView
            ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)
            : AppColors.transparent,
        radius: 15.sp,
        child: Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                isListView = false;
              });
            },
            icon: Icon(
              Icons.grid_view_rounded,
              color: !isListView
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).iconTheme.color,
              size: 20.sp,
            ),
          ),
        ),
      ),
    ];
  }

  // Get all stories
  void _getStories() {
    // ref is an object interact with provider
    //ref.read for accessing state without causing rebuilds
    ref.read(storiesStateNotifierProvider.notifier).getStories(
          StoriesParams(selectedStorySection.section),
        );
  }
  
  

 
}

