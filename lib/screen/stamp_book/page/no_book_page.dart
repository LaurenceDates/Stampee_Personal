import 'package:flutter/material.dart';

class NoBookPage extends StatelessWidget {
  const NoBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('No Stamp Book was found!'),
        Divider(),
        OutlinedButton(
            child: Text('Make New Stamp Book!'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/NewBookScreen');
            }),
      ],
    );
  }
}
