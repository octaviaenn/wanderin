import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wanderin/persona.dart';

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
  int _currentPage = 0;

  void _loginUser() async {
    // NANTI DIHAPUS
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Persona()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _logEmailController.text,
        password: _logPassController.text,
      );
      setState(() => _errorMessage = null);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Persona()),
      );
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
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Persona()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    }
  }

  Future<void> signInGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Persona()),
      );
    } catch (e) {
      print("Google sign-in error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3ECE4),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                //physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          //padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Access your account to keep exploring.',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: TextField(
                            controller: _logEmailController,
                            decoration: InputDecoration(
                              hintText: 'Type your email here',
                              filled: true,
                              fillColor: Color(0xFFF8F2E9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Password',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: TextField(
                            controller: _logPassController,
                            obscureText: _obscureLogPass,
                            decoration: InputDecoration(
                              hintText:
                                  _errorMessage ?? 'Type your password here',
                              hintStyle: TextStyle(
                                color: _errorMessage != null
                                    ? Colors.red
                                    : Color(0xFFF2B2B2B),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF8F2E9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureLogPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _errorMessage != null
                                      ? Colors.red
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscureLogPass = !_obscureLogPass,
                                  );
                                },
                              ),
                            ),
                            onChanged: (_) {
                              if (_errorMessage != null)
                                setState(() => _errorMessage = null);
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _loginUser,
                            child: Text(
                              'Log in',
                              //style: TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF48B6AC),
                              foregroundColor: Color(0xFFFF3ECE4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(color: Colors.black, thickness: 1, height: 24),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => signInGoogle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Log In with Google',
                                  style: TextStyle(
                                    fontSize: 15,
                                    //color: Colors.black
                                  ),
                                ),
                                Image.asset(
                                  'assets/google-icon.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Color(0xFFF48B6AC),
                              backgroundColor: Color(0xFFFF3ECE4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Color(0xFFF48B6AC),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          //padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Create an account to start your journey.',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: TextField(
                            controller: _signEmailController,
                            decoration: InputDecoration(
                              hintText: 'Type your email here',
                              filled: true,
                              fillColor: Color(0xFFF8F2E9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Username',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'Type your username here',
                              filled: true,
                              fillColor: Color(0xFFF8F2E9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Password',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: TextField(
                            controller: _signPassController,
                            obscureText: _obscureSignPass,
                            decoration: InputDecoration(
                              hintText:
                                  _errorMessage ?? 'Type your password here',
                              hintStyle: TextStyle(
                                color: _errorMessage != null
                                    ? Colors.red
                                    : Color(0xFFF2B2B2B),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF8F2E9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureSignPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscureSignPass = !_obscureSignPass,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: TextField(
                            controller: _confirmPassController,
                            obscureText: _obscureConfirmPass,
                            decoration: InputDecoration(
                              hintText: _errorMessage ??
                                  'Type your password again here',
                              hintStyle: TextStyle(
                                color: _errorMessage != null
                                    ? Colors.red
                                    : Color(0xFFF2B2B2B),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF8F2E9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _errorMessage != null
                                      ? Colors.red
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscureConfirmPass =
                                        !_obscureConfirmPass,
                                  );
                                },
                              ),
                            ),
                            onChanged: (_) {
                              if (_errorMessage != null)
                                setState(() => _errorMessage = null);
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _signupUser,
                            child: Text(
                              'Sign in',
                              //style: TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF48B6AC),
                              foregroundColor: Color(0xFFFF3ECE4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(color: Colors.black, thickness: 1, height: 24),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => signInGoogle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In with Google',
                                  style: TextStyle(
                                    fontSize: 15,
                                    //color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 4),
                                Image.asset(
                                  'assets/google-icon.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Color(0xFFF48B6AC),
                              backgroundColor: Color(0xFFFF3ECE4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Color(0xFFF48B6AC),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Color(0xFF505D7D)
                        : Color(0xFFED7061),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
