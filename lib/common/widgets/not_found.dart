import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final String message;

  const NotFoundWidget({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("images/error.png"),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
