import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {

  late bool _loading;
  late double _progressValue;

  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text("Sample Code"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: _loading ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: _progressValue,
                ),
                SizedBox(height: 35,),
                Text(
                  '${(_progressValue * 100).round()}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 35,),
              ],
            )
            : Text(
              "Press button to download",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _loading = true;
              _updateProgress();
            });
          },
        ),
      )
    );
  }

  void _updateProgress() {
    const second = Duration(seconds: 1);
    Timer.periodic(second, (timer) {
      setState(() {
        _progressValue += 0.1;

        if (_progressValue.toStringAsFixed(1) == "1.0") {
          _loading = false;
          timer.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }

}
