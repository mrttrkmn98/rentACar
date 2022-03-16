import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/types/story.dart';
import 'package:shopping_list/domain/repositories/story_repository.dart';

class AddToStoryList extends UseCase<void, AddToStoryListParams> {
  final StoryRepository _storyRepository;

  AddToStoryList(this._storyRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(AddToStoryListParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _storyRepository.addToStoryList(params!.story);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}

class AddToStoryListParams {
  final Story story;

  AddToStoryListParams(this.story);
}
