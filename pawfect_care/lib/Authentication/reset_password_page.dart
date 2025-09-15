import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/custom_input_fields.dart';
import 'package:pawfect_care/db_helper.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _hide = true;
  String? _error;
  int? _userId;

  @override
  void initState() {
    super.initState();
    // live updates for the rules while typing
    _password.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Widget _rule(String text, bool ok) {
    return Row(
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.cancel,
          color: ok ? Colors.green : Colors.pinkAccent,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Future<void> _reset() async {
    final p = _password.text;
    final c = _confirm.text;

    setState(() => _error = null);

    if (p.isEmpty || c.isEmpty) {
      setState(() => _error = "Please fill both fields");
      return;
    }
    if (p != c) {
      setState(() => _error = "Passwords do not match");
      return;
    }
    if (p.length < 8) {
      setState(() => _error = "Password must be at least 8 characters");
      return;
    }
    if (!RegExp(r'[0-9]').hasMatch(p) ||
        !RegExp(r'[A-Z]').hasMatch(p) ||
        !RegExp(r'[a-z]').hasMatch(p)) {
      setState(() => _error = "Use upper, lower, and a number");
      return;
    }
    if (_userId == null) {
      setState(() => _error = "Invalid reset session");
      return;
    }

    await DBHelper.updateUserPassword(_userId!, p);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Password updated')));
    Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    // read id once
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int && _userId == null) _userId = args;

    final p = _password.text;
    final okLen = p.length >= 8;
    final okNum = RegExp(r'[0-9]').hasMatch(p);
    final okUp = RegExp(r'[A-Z]').hasMatch(p);
    final okLo = RegExp(r'[a-z]').hasMatch(p);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteBgColor,
        foregroundColor: blackBgColor,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteBgColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Image(
              image: AssetImage('assets/icon-1.png'),
              width: 250,
              height: 250,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _rule("At least 8 characters", okLen)),
                const SizedBox(width: 16),
                Expanded(child: _rule("Contains a number", okNum)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _rule("An uppercase letter", okUp)),
                const SizedBox(width: 16),
                Expanded(child: _rule("A lowercase letter", okLo)),
              ],
            ),

            const SizedBox(height: 24),

            CustomInputField(
              hint: "New Password",
              icon: Icons.lock_outline,
              controller: _password,
              obscureText: _hide,
              suffixIcon: Icon(_hide ? Icons.visibility_off : Icons.visibility),
              onSuffixTap: () => setState(() => _hide = !_hide),
            ),
            const SizedBox(height: 12),
            CustomInputField(
              hint: "Confirm Password",
              icon: Icons.lock_outline,
              controller: _confirm,
              obscureText: _hide,
              suffixIcon: Icon(_hide ? Icons.visibility_off : Icons.visibility),
              onSuffixTap: () => setState(() => _hide = !_hide),
            ),

            const SizedBox(height: 8),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: blueButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
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
    );
  }
}
