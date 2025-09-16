import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social/components/my_button.dart';
import 'package:minimal_social/components/my_textfield.dart';
import 'package:minimal_social/helpers/helpers_functions.dart';
// import 'package:minimal_social/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              // app name
              const Text("M I N I M A L", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 50),

              // username textfield
              MyTextfield(
                controller: usernameController,
                obscureText: false,
                hintText: "User name",
              ),
              const SizedBox(height: 10),

              // email textfield
              MyTextfield(
                controller: emailController,
                obscureText: false,
                hintText: "Email",
              ),
              const SizedBox(height: 10),

              //password textfield
              MyTextfield(
                controller: passwordController,
                obscureText: true,
                hintText: "Password",
              ),
              const SizedBox(height: 10),

              //confirm password textfield
              MyTextfield(
                controller: confirmPwController,
                obscureText: true,
                hintText: "Confirm Password",
              ),
              const SizedBox(height: 30),

              // register/save button
              MyButton(onTap: registerUser, text: "Register"),
              const SizedBox(height: 25),

              // don't have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);
      displayMessageToUser("Passwords don't match", context);
    } else {
      // try creating user
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        // create a user documnent to firestore
        createUserDocument(userCredential);

        // usernameController.text = "";
        // emailController.text = "";
        // passwordController.text = "";
        // confirmPwController.text = "";

        if (context.mounted) Navigator.pop(context);
        displayMessageToUser("User was registered", context);
      } on FirebaseAuthException catch (error) {
        Navigator.pop(context);
        displayMessageToUser(error.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
            'email': userCredential.user!.email,
            'username': usernameController.text,
          });
    }
  }
}
