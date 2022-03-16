import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/types/story.dart';
import 'package:shopping_list/domain/repositories/story_repository.dart';
import 'package:shopping_list/domain/usecases/get_story_list.dart';

class StoryPresenter extends Presenter {
  late Function getStoryListOnNext;
  late Function getStoryListOnError;

  final GetStoryList _getStoryList;

  StoryPresenter(
    StoryRepository _storyRepository,
  ) : _getStoryList = GetStoryList(_storyRepository);

  void getStoryList() {
    _getStoryList.execute(_GetStoryListObserver(this));
  }

  @override
  void dispose() {
    _getStoryList.dispose();
  }
}

class _GetStoryListObserver extends Observer<List<Story>> {
  final StoryPresenter _presenter;

  _GetStoryListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getStoryListOnError(e);
  }

  @override
  void onNext(List<Story>? response) {
    _presenter.getStoryListOnNext(response);
  }
}
