import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/custom_input_fields.dart';
import 'package:pawfect_care/db_helper.dart';

class ResetPasswordEmailPage extends StatefulWidget {
  const ResetPasswordEmailPage({super.key});

  @override
  State<ResetPasswordEmailPage> createState() => _ResetPasswordEmailPageState();
}

class _ResetPasswordEmailPageState extends State<ResetPasswordEmailPage> {
  final _email = TextEditingController();
  String? _error;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _sendToResetPasswordPage() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final email = _email.text.trim();
    if (email.isEmpty) {
      setState(() {
        _loading = false;
        _error = "Please enter your email";
      });
      return;
    }

    final row = await DBHelper.getUserByEmail(email);
    if (row == null) {
      setState(() {
        _loading = false;
        _error = "No user with this email";
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _loading = false;
    });

    // Navigate to reset page with the user's id
    Navigator.pushNamed(context, '/reset', arguments: row['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteBgColor,
        foregroundColor: blackBgColor,
        title: const Text(
          "Forgot Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: whiteBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/icon-1.png'),
                width: 250,
                height: 250,
              ),
              CustomInputField(
                hint: "Email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _email,
              ),
              const SizedBox(height: 8),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _sendToResetPasswordPage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: blueButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    _loading ? "Please wait..." : "Reset Password",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
