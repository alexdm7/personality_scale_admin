import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AboutUsScreen.dart';
import 'SurveyResults.dart';

final _fireBase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  final bool showImageAnimation;
  const AuthScreen({super.key,this.showImageAnimation = false});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isAuthenticate = false;

  void _submit() async {
    // تأكد من صحة المدخلات
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isAuthenticate = true;
    });

    try {
      // تسجيل الدخول باستخدام Firebase
      final userCredentials = await _fireBase.signInWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SurveyResultsScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'حدث خطأ غير متوقع')),
      );
    } finally {
      setState(() {
        _isAuthenticate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/logo1.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(label: Text('الايميل')),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty || !value.contains('@')) {
                                return 'يرجى إدخال البريد الإلكتروني بشكل صحيح';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(label: Text('كلمة السر')),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'يجب أن تكون كلمة السر 6 أحرف على الأقل';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticate)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticate)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                              ),
                              child: Text('دخول'),
                            ),
                          if (!_isAuthenticate)
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AboutUsScreen(),
                                  ),
                                );
                              },
                              child: const Text('من نحن؟'),
                            ),
                        ],
                      ),
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
