import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/types/story.dart';
import 'package:shopping_list/domain/repositories/story_repository.dart';

class GetStoryList extends UseCase<List<Story>, void> {
  final StoryRepository _storyRepository;
  final StreamController<List<Story>> _controller;

  GetStoryList(this._storyRepository)
      : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<Story>?>> buildUseCaseStream(void params) async {
    try {
      _storyRepository.getStories().listen((List<Story>? stories) {
        _controller.add(stories!);
      });
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
