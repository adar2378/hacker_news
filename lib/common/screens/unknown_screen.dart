import 'package:flutter/material.dart';
import 'package:hacker_news/common/widgets/not_found.dart';
import 'package:hacker_news/routes/routes.dart';

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                Routes.home,
              );
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: NotFoundWidget(
          message: "Unknown Page",
        ),
      ),
    );
  }
}
