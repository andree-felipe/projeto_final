// ignore_for_file: annotate_overrides, unused_element

import 'dart:io';

import 'package:projeto_final/core/services/auth/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';

class AuthFirebaseService implements AuthService {
  static AppUser? _currentUser;

  static final _userStream = Stream<AppUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toAppUser(user);
      controller.add(_currentUser);
    }
  });

  AppUser? get currentUser {
    return _currentUser;
  }

  Stream<AppUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    String exclusiveCode,
    String permissionType,
    File? image,
  ) async {
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if(credential.user != null) {
      // Upload da foto do usuário
      final imageName = '${credential.user!.uid}.jpg';
      final imageURL = await _uploadUserImage(image, imageName);

      // Atualizar atributos do usuário
      await credential.user?.updateDisplayName(name);
      await credential.user?.updatePhotoURL(imageURL);

      // Fazer login do usuário
      await login(email, password);

      // Salvar usuário no banco de dados
      _currentUser = _toAppUser(credential.user!, exclusiveCode, permissionType, name, imageURL);
    }
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> _saveAppUser(AppUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'code': user.exclusiveCode,
      'userType': user.permissionType,
      'imageURL': user.imageURL,
    });
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if(image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('users_images').child(imageName);

    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  static AppUser _toAppUser(User user, [String? name, String? imageURL, String? exclusiveCode, String? permissionType]) {
    return AppUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      exclusiveCode: exclusiveCode ?? '',
      permissionType: permissionType ?? '',
      imageURL: imageURL ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
