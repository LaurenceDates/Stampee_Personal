import 'package:flutter/material.dart';
import 'package:stampee_personal/component/validator.dart';
import 'package:stampee_personal/component/auth.dart';

class EmailSignInTab extends StatefulWidget {
  const EmailSignInTab({Key? key}) : super(key: key);

  @override
  _EmailSignInTabState createState() => _EmailSignInTabState();
}

class _EmailSignInTabState extends State<EmailSignInTab> {
  String _email = '';
  String _password = '';
  bool _emailValid = false;
  bool _passwordValid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (String _value) {
                  _email = _value;
                  setState(() {
                    _emailValid = Validator.email(_email);
                  });
                },
              ),
              Row(children: _emailValidText()),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                onChanged: (String _value) {
                  _password = _value;
                  setState(() {
                    _passwordValid = Validator.password(_password);
                  });
                },
              ),
              Row(children: _passwordValidText()),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _emailValid && _passwordValid
              ? () {
                  _signIn(context, _email, _password);
                }
              : null,
          child: Text('Sign IN!'),
        ),
      ],
    );
  }

  List<Widget> _emailValidText() {
    if (_emailValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text("Good")];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text("Email seems to be WRONG"),
      ];
    }
  }

  List<Widget> _passwordValidText() {
    if (_passwordValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text("Good")];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text("Password seems to be wrong."),
      ];
    }
  }

  _signIn(context, _email, _password) async {
    EmailSignInResult _result = await AuthComponent.emailSignIn(_email, _password);
    switch (_result) {
      case EmailSignInResult.success:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt),
                    Text("SignIn Successful"),
                  ],
                ),
                content: Text("SignIn Successful"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Text("Return")),
                ],
              );
            });
        break;
      case EmailSignInResult.noUser:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text("SignIn Failed"),
                  ],
                ),
                content: Text("No User for that Email"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                      },
                      child: Text("Return")),
                ],
              );
            });
        break;
      case EmailSignInResult.wrongPassword:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text("SignIn Failed"),
                  ],
                ),
                content: Text("Password is Wrong"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Return")),
                ],
              );
            });
        break;
      default:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text("SignIn Failed"),
                  ],
                ),
                content: Text("Unexpected Error Happened. Please check your Internet connection and try again."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Return")),
                ],
              );
            });
    }
  }
}

class EmailSignUpTab extends StatefulWidget {
  const EmailSignUpTab({Key? key}) : super(key: key);

  @override
  _EmailSignUpTabState createState() => _EmailSignUpTabState();
}

class _EmailSignUpTabState extends State<EmailSignUpTab> {
  String _email = '';
  String _password1 = '';
  String _password2 = '';
  bool _emailValid = false;
  bool _passwordValid = false;
  bool _passwordMatch = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (String _value) {
                  _email = _value;
                  setState(() {
                    _emailValid = Validator.email(_email);
                  });
                },
              ),
              Row(children: _emailValidText()),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                onChanged: (String _value) {
                  _password1 = _value;
                  setState(() {
                    _passwordValid = Validator.password(_password1);
                  });
                },
              ),
              Row(children: _passwordValidText()),
              TextField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                ),
                onChanged: (String _value) {
                  _password2 = _value;
                  setState(() {
                    if (_password1 == _password2) {
                      _passwordMatch = true;
                    } else {
                      _passwordMatch = false;
                    }
                  });
                },
              ),
              Row(children: _passwordConfirmText()),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _emailValid && _passwordValid && _passwordMatch
              ? () {
                  _signUp(context, _email, _password1);
                }
              : null,
          child: Text('Sign UP!'),
        ),
      ],
    );
  }

  List<Widget> _emailValidText() {
    if (_emailValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text("Good")];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text("Email seems to be WRONG"),
      ];
    }
  }

  List<Widget> _passwordValidText() {
    if (_passwordValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text("Good")];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text("Password is TOO WEAK. It should be at least 6 letters long and contain both numbers and letters."),
      ];
    }
  }

  List<Widget> _passwordConfirmText() {
    if (_passwordMatch) {
      return [Icon(Icons.sentiment_satisfied_alt), Text("Good")];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text("Password does NOT match."),
      ];
    }
  }

  _signUp(context, _email, _password) async {
    EmailSignUpResult _result = await AuthComponent.emailSignUp(_email, _password);
    switch (_result) {
      case EmailSignUpResult.success:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt),
                    Text("SignUp Successful"),
                  ],
                ),
                content: Text("SignUp Successful"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Text("Return")),
                ],
              );
            });
        break;
      case EmailSignUpResult.alreadyRegistered:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text("SignUp Failed"),
                  ],
                ),
                content: Text(
                    "This Email Address is already registered. Please try to sign in with it, or register with another Email."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Return")),
                ],
              );
            });
        break;
      case EmailSignUpResult.weakPassword:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text("SignUp Failed"),
                  ],
                ),
                content: Text(
                    "Your registration was Rejected, because your password is TOO WEAK. Please try again with another password."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Return")),
                ],
              );
            });
        break;
      default:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text("SignIn Failed"),
                  ],
                ),
                content: Text("Unexpected Error Happened. Please check your Internet connection and try again."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Return")),
                ],
              );
            });
    }
  }
}
