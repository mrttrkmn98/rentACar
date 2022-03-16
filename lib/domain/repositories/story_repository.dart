import 'package:shopping_list/domain/entities/types/story.dart';

abstract class StoryRepository {
  Future<void> addToStoryList(Story story);
  Stream<List<Story>> getStories();
}
