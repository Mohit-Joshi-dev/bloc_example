import 'package:bloc_example/main.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 4), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (_) => HomePage()));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constrains) {
        if (constrains.maxWidth < 1400) {
          return Container(
            width: constrains.maxWidth,
            constraints: BoxConstraints(minWidth: 500),
            color: Colors.blue.shade50,
            child: Scaffold(
              appBar: AppBar(),
              backgroundColor: Colors.blue.shade300,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: RiveAnimation.network(
                        'https://public.rive.app/community/runtime-files/696-1361-now-loader-2.riv',
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Container(
                    //   height: 200,
                    //   // width: ,
                    //   child: RiveAnimation.network(
                    //     'https://public.rive.app/community/runtime-files/699-1369-simple-loader.riv',
                    //     fit: BoxFit.cover,
                    //   ),
                    // )
                    SizedBox(height: 50),
                    Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: RiveAnimation.asset(
                          'assets/flare/new_file.riv',
                          fit: BoxFit.fitWidth,
                        ))
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
    // Scaffold(
    //     backgroundColor: Colors.blue,
    // body:
  }
}
