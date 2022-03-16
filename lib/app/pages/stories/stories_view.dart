import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/stories/stories_controller.dart';
import 'package:shopping_list/app/widgets/video_widgets/video_screen_widget.dart';
import 'package:shopping_list/data/repositories/data_stories_repository.dart';

class StoriesView extends View {
  @override
  State<StatefulWidget> createState() {
    return _StoriesViewState(StoriesController(DataStoriesRepository()));
  }
}

class _StoriesViewState extends ViewState<StoriesView, StoriesController> {
  _StoriesViewState(StoriesController controller) : super(controller);

  @override
  Widget get view {
    return ControlledWidgetBuilder<StoriesController>(
        builder: (context, controller) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
          backgroundColor: kBackgroundColor,
          key: globalKey,
          body: controller.stories == null
              ? Container(
                  color: kprimaryColor.withOpacity(0.5),
                  width: size.width,
                  height: size.height,
                  child: Center(
                      child: CircularProgressIndicator(color: kprimaryColor)))
              : controller.stories!.isEmpty
                  ? Container(
                      color: kprimaryColor,
                      width: size.width,
                      height: size.height,
                      child: Center())
                  : VideoScreenWidget(controller.stories));
    });
  }
}
