import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/controller/authController.dart';

class GoogleSignIN extends ConsumerWidget {
  const GoogleSignIN({super.key});

  void signInGoogle(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => {signInGoogle(ref, context)},
      icon: Image.asset("assets/images/google.png", width: 35),
      label: const Text("Continue with Google", style: TextStyle(fontSize: 18)),
    );
  }
}
