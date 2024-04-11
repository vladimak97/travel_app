import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Create an instance of FirebaseAuth.
final _firebase = FirebaseAuth.instance;

// Create a stateful widget for authentication screen.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}
// State class for the authentication screen.
class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  //Variables to track login state and user input.
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  // Function to handle form submission.
  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    try {
      if (_isLogin) {
        // ignore: unused_local_variable
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      } else {
        // ignore: unused_local_variable
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      }
    } on FirebaseAuthException catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  // Build method for the authentication screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 110,
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/logo.ico'),
                  radius: 50,
                ),
              ),
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
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Adres mailowy',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Proszę wpisać prawidłowy adres e-mail.';
                              }
                              return null;
                            },
                            onSaved: (value) => _enteredEmail = value!,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Hasło',
                            ),
                            obscureText: true,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Hasło musi mieć conajmniej 6 znaków.';
                              }
                              return null;
                            },
                            onSaved: (value) => _enteredPassword = value!,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(
                                _isLogin ? 'Zaloguj się' : 'Zarejestruj się'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(
                                () {
                                  _isLogin = !_isLogin;
                                },
                              );
                            },
                            child:
                                Text(_isLogin ? 'Nowe konto' : 'Mam już konto'),
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
