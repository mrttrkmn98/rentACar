import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/authentication_repository.dart';

class DataAuthenticationRepository implements AuthenticationRepository {
  static final _instance = DataAuthenticationRepository._internal();
  DataAuthenticationRepository._internal();
  factory DataAuthenticationRepository() => _instance;

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> registerWithEmail(
      String firstName, String lastName, String email, String password) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      _firestore.collection('users').doc(user.user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'rentedCars': <Car>[],
      });
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      _firebaseAuth.signOut();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
