import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/datamodels/user_model.dart';
import 'package:reddit/repos/auth_repos.dart';
import 'package:reddit/typdefs.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(authrepo: ref.watch(authRepoProvider), ref: ref));

class AuthController extends StateNotifier<bool> {
  final AuthRepos _authrepo;
  final Ref _ref;

  AuthController({required AuthRepos authrepo, required Ref ref})
      : _authrepo = authrepo,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authrepo.authStateChanges;

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void signInGoogle(BuildContext context) async {
    state = true;
    final user = await _authrepo.signInGoogle();
    state = false;
    user.fold((l) => showSnackBar(context, l.message),
        (r) => _ref.read(userProvider.notifier).update((state) => r));
  }
}
