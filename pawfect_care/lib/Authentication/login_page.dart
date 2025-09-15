import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/custom_input_fields.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/session.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _error;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _doLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final email = _emailController.text.trim();
    final pass = _passwordController.text;

    if (email.isEmpty || pass.isEmpty) {
      setState(() {
        _loading = false;
        _error = "Please enter email and password";
      });
      return;
    }

    final row = await DBHelper.login(email, pass);

    if (row == null) {
      setState(() {
        _loading = false;
        _error = "Invalid email or password";
      });
      return;
    }

    Session.currentUserId = row['id'] as int?;
    Session.currentRole = (row['role'] ?? '') as String;

    if (!mounted) return;

    final role = Session.currentRole;
    if (role!.isEmpty) {
      Navigator.pushReplacementNamed(context, '/role');
    } else if (role == 'Pet Owner') {
      Navigator.pushReplacementNamed(context, '/owner');
    } else if (role == 'Veterinarian') {
      Navigator.pushReplacementNamed(context, '/vet');
    } else {
      Navigator.pushReplacementNamed(context, '/shelter');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteBgColor,
        foregroundColor: blackBgColor,
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/icon-1.png'),
                width: 180,
                height: 180,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Log in to your PawfectCare account"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // EMAIL
              CustomInputField(
                hint: "Email",
                icon: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // PASSWORD
              CustomInputField(
                hint: "Password",
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                controller: _passwordController,
                suffixIcon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onSuffixTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),

              const SizedBox(height: 12),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot');
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ],
              ),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _doLogin,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: blueButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    _loading ? "Please wait..." : "Login",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
