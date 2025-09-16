import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// display error message
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(title: Text(message)),
  );
}

void logout() {
  FirebaseAuth.instance.signOut();
}
