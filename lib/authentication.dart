import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthState();
}

class _AuthState extends State<Authentication> {
  final PageController _controller = PageController();
  final _logEmailController = TextEditingController();
  final _signEmailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _signPassController = TextEditingController();
  final _logPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String? _errorMessage;
  bool _obscureLogPass = true;
  bool _obscureSignPass = true;
  bool _obscureConfirmPass = true;

  void _loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _logEmailController.text,
        password: _logPassController.text,
      );
      setState(() => _errorMessage = null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        setState(() => _errorMessage = 'Wrong password!');
      } else {
        setState(() => _errorMessage = e.message);
      }
    }
  }

  void _signupUser() async {
    if (_signPassController.text != _confirmPassController.text) {
      setState(() => _errorMessage = 'Your password not match!');
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _signEmailController.text,
        password: _signPassController.text,
      );
      // username belum disimpen
      setState(() => _errorMessage = null);
      _controller.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: PageView(
      controller: _controller,
      //physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            Text(
              'Log In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Access your account to keep exploring.',
              style: TextStyle(fontSize: 11),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _logEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Type your email here',
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _logPassController,
              obscureText: _obscureLogPass,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: _errorMessage ?? 'Type your password',
                  hintStyle: TextStyle(
                      color: _errorMessage != null ? Colors.red : Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _obscureLogPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color:
                            _errorMessage != null ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        setState(() => _obscureLogPass = !_obscureLogPass);
                      })),
              onChanged: (_) {
                if (_errorMessage != null) setState(() => _errorMessage = null);
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
                onPressed: _loginUser,
                child: Text(
                  'Log in',
                  style: TextStyle(fontSize: 12),
                ))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Create an account to start your journey.',
              style: TextStyle(fontSize: 11),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _signEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Type your email here',
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Type your username here',
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _signPassController,
              obscureText: _obscureSignPass,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: _errorMessage ?? 'Type your password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _obscureSignPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _obscureSignPass = !_obscureSignPass);
                      })),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmPassController,
              obscureText: _obscureConfirmPass,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: _errorMessage ?? 'Type your password',
                  hintStyle: TextStyle(
                      color: _errorMessage != null ? Colors.red : Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color:
                            _errorMessage != null ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        setState(
                            () => _obscureConfirmPass = !_obscureConfirmPass);
                      })),
              onChanged: (_) {
                if (_errorMessage != null) setState(() => _errorMessage = null);
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
                onPressed: _signupUser,
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 12),
                ))
          ]),
        )
      ],
    )));
  }
}
