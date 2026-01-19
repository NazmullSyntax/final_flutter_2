import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_home_page.dart';
import 'otp_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool _isPasswordVisible = false;

  // Controllers for input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  // ------------------ LOGIN FUNCTION ------------------
  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage('Fill all fields');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainHomePage()),
      );
    } catch (e) {
      showMessage(e.toString());
    }
  }

  // ------------------ REGISTER FLOW ------------------
  Future<void> registerFlow() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = nameController.text.trim();
    final rawPhone = phoneController.text.trim(); // user types 018xxxxxxx
    final phone = "+88$rawPhone"; // internally +88018xxxxxxx

    if (email.isEmpty ||
        password.isEmpty ||
        fullName.isEmpty ||
        rawPhone.isEmpty) {
      showMessage('Fill all fields');
      return;
    }

    // check if phone already exists in Firestore
    final existing = await _firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();
    if (existing.docs.isNotEmpty) {
      showMessage("Phone number already registered!");
      return;
    }

    // Send OTP & open OTP screen
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted:
          (PhoneAuthCredential credential) {}, // test mode auto verify
      verificationFailed: (FirebaseAuthException e) {
        showMessage(e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              verificationId: verificationId,
              onVerified: () => createAccount(email, password, fullName, phone),
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // ------------------ CREATE ACCOUNT AFTER OTP ------------------
  Future<void> createAccount(
      String email, String password, String name, String phone) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCred.user!.uid).set({
        'email': email,
        'name': name,
        'phone': phone,
      });

      showMessage("Account created! Please login now.");

      // ----------------- Clear all fields -----------------
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      phoneController.clear();

      setState(() {
        isLogin = true; // switch to login screen
      });
    } catch (e) {
      showMessage(e.toString());
    }
  }

  // ------------------ SHOW SNACKBAR ------------------
  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                isLogin ? 'Login' : 'Create Account',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isLogin
                    ? 'Sign in to your account'
                    : 'Register to create new account',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              if (!isLogin) ...[
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF2E7D32)),
                  Expanded(
                    child: Text(
                      isLogin
                          ? 'Keep me logged in'
                          : 'I agree to terms and conditions',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    isLogin ? loginUser() : registerFlow();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                  ),
                  child: Text(
                    isLogin ? 'Login' : 'Register',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                  child: Text('or', style: TextStyle(color: Colors.grey))),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_translate),
                  label: const Text('Continue with Google'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      isLogin
                          ? "Don't have an account?"
                          : "Already have an account?",
                      style: const TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: toggleAuthMode,
                    child: Text(
                      isLogin ? 'Register' : 'Login',
                      style: const TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold),
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
}
