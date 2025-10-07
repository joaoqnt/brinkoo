import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

class ButtonGoogle extends StatelessWidget {
  ButtonGoogle({super.key});

  Future<void>? _initialization;

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    bool _isAuthorized = false;
  }

  Future<void> _ensureInitialized() {
    // The example app uses the parsing of values from google-services.json
    // to provide the serverClientId, otherwise it would be required here.
    return _initialization ??= GoogleSignInPlatform.instance.init(
      const InitParameters(
        clientId: "955911567223-4k5avv2e6ruoijqit5837thm9pqt8sn8.apps.googleusercontent.com",
        serverClientId: "brinkoo",

      ),
    )..catchError((dynamic _) {
      _initialization = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleGoogleSignIn(context),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Image.asset("assets/google_logo.png", fit: BoxFit.cover),
      ),
    );
  }
}
