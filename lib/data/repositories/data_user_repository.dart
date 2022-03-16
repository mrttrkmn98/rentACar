import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_list/domain/entities/user.dart' as ent;
import 'package:shopping_list/domain/repositories/user_repository.dart';

class DataUserRepository implements UserRepository {
  static final _instance = DataUserRepository._internal();
  DataUserRepository._internal();
  factory DataUserRepository() => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late ent.User _currentUser;

  @override
  ent.User get currentUser => _currentUser;

  @override
  Future<void> initializeRepository() async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      print('Authenticated Uid:  ' + uid);

      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(uid).get();
      _currentUser = ent.User.fromJson(snapshot);

      print(_currentUser.firstName);
      print(_currentUser.email);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
