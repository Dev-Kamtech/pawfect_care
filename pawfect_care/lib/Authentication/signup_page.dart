import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/custom_input_fields.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/session.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  String? _error;
  bool _loading = false;

  void _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    if (_name.text.isEmpty ||
        _email.text.isEmpty ||
        _phone.text.isEmpty ||
        _password.text.isEmpty) {
      setState(() {
        _loading = false;
        _error = "Please fill all fields";
      });
      return;
    }
    final id = await DBHelper.registerUser(
      name: _name.text,
      email: _email.text,
      phone: _phone.text,
      password: _password.text,
    );
    Session.currentUserId = id;
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/role');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteBgColor,
        foregroundColor: blackBgColor,
        title: const Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteBgColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage("assets/icon-1.png"),
                height: 180,
                width: 180,
              ),
              const Text(
                "Welcome 👋",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("Please fill the form to continue."),
              const SizedBox(height: 20),

              CustomInputField(
                hint: "Full Name",
                icon: Icons.person,
                controller: _name,
                obscureText: false,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 12),
              CustomInputField(
                hint: "Email",
                icon: Icons.email,
                controller: _email,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomInputField(
                hint: "Phone Number",
                icon: Icons.phone,
                controller: _phone,
                obscureText: false,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              CustomInputField(
                hint: "Password",
                icon: Icons.lock,
                controller: _password,
                obscureText: _obscure,
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueButtonColor,
                  ),
                  child: Text(
                    _loading ? "Please wait..." : "Create Account",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: blueTextColor,
                        fontWeight: FontWeight.bold,
                      ),
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
