import 'package:flutter/material.dart';
import 'package:shopping_list/app/widgets/video_widgets/video_item_widget.dart';
import 'package:shopping_list/domain/entities/types/story.dart';

class VideoScreenWidget extends StatefulWidget {
  final List<Story>? stories;

  VideoScreenWidget(this.stories);

  @override
  _VideoScreenWidgetState createState() => _VideoScreenWidgetState();
}

class _VideoScreenWidgetState extends State<VideoScreenWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.stories!.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RotatedBox(
        quarterTurns: 1,
        child: TabBarView(
            controller: _tabController,
            children: List.generate(widget.stories!.length, (index) {
              return RotatedBox(
                  quarterTurns: -1,
                  child: VideoItemWidget(widget.stories![index].url, size));
            })));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
