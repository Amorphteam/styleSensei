import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:style_sensei/screens/splash/splash_screen.dart';
import 'package:style_sensei/utils/user_controller.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("assets/logo/logo.png",
                      width: 200, height: 200),
                ),
                Positioned(
                  top: 100,
                  right: 20,
                  child: Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login with google",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "It's testing screen",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: TextButton(
                onPressed: () async {
                  try {
                    final user = await UserController.loginWithGoogle();
                    if (user != null && mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SplashScreen()));
                    }

                  } on FirebaseAuthException catch (error){
                    debugPrint(error.message);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? "Something went wrong",)));
                  } catch (error){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString(),)));
                  }
                },
                child: Text(
                  'Login With google',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        // Add other text styling properties if needed
                      ),
                )),
          ),
        ],
      ),
    );
  }
}
