import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/stories/stories_presenter.dart';
import 'package:shopping_list/domain/entities/types/story.dart';
import 'package:shopping_list/domain/repositories/story_repository.dart';

class StoriesController extends Controller {
  final StoryPresenter _presenter;

  StoriesController(
    StoryRepository _storyRepository,
  ) : _presenter = StoryPresenter(
          _storyRepository,
        );

  List<Story>? stories;

  @override
  void initListeners() {
    _presenter.getStoryListOnNext = (List<Story> response) {
      stories = response;
      refreshUI();
    };
    _presenter.getStoryListOnError = (e) {};
  }

  @override
  void onInitState() {
    _presenter.getStoryList();
    refreshUI();
    super.onInitState();
  }

  void closePage() {
    Navigator.of(getContext()).pop();
  }
}
