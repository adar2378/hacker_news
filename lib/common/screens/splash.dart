import 'package:flutter/material.dart';
import 'package:hacker_news/routes/routes.dart';
import 'package:hacker_news/styles/colors.dart';
import 'package:hacker_news/styles/font_styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 4000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: HNColors.primaryColor,
        body: Stack(
          children: <Widget>[
            Center(
              child: ScaleTransition(
                  scale: _animation,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 20,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "images/android_logo.png",
                              height: 100,
                              // color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Hacker News",
                          style: FontStyles.title2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
