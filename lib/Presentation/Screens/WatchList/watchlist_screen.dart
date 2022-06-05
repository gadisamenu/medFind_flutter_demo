import 'package:flutter/material.dart';
import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initialize(context);
    return Scaffold(
      appBar: AppBar(title: const Text("WatchList")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, getProportionateHeight(50), 0, 0),
          child: Container(
            height: double.infinity,
            width: getProportionateWidth(270),
            color: Color.fromRGBO(244, 67, 54, 1),
            child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(10, (index) {
                  return Container(
                    color: Colors.green,
                    height: 100,
                    width: getProportionateWidth(250),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
