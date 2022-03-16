import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/domain/entities/types/story.dart';
import 'package:shopping_list/domain/repositories/story_repository.dart';

class DataStoriesRepository implements StoryRepository {
  static final _instance = DataStoriesRepository._internal();
  DataStoriesRepository._internal();
  factory DataStoriesRepository() => _instance;

  StreamController<List<Story>> _streamController =
      StreamController.broadcast();

  List<Story>? stories;

  @override
  Future<void> addToStoryList(Story story) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('stories')
          .add(story.toJson());

      stories!.add(Story(doc.id, story.url));
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<void> _initStories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('stories').get();

      stories = [];

      snapshot.docs.forEach(
        (doc) {
          stories!.add(Story.fromJson(doc.data(), doc.id));
        },
      );

      _streamController.add(stories!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Stream<List<Story>> getStories() {
    try {
      Future.delayed(Duration(seconds: 1)).then((_) async {
        _initStories();
      });
      return _streamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
