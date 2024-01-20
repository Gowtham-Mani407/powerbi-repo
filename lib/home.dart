import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement/second.dart';

import 'Listprovider.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  static const channel = MethodChannel('com.statemanagement');

  String batterpoint = "0 %";
  @override
  Widget build(BuildContext context) {
    //Build a widget tree while listening to providers. Consumer can be used to listen to providers inside a StatefulWidget or to rebuild as few widgets as possible when a provider updates
    // When the state changes, consumers are notified, and they can update their UI or take other actions accordingly
    return Consumer<listnumprovider>(
      builder: (BuildContext context, providermodel, Widget? child) => Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              onTap: () {
                providermodel.add(); // Add your logic for the first button
              },
              child: Icon(Icons.add),
              label: 'Add',
              backgroundColor: Colors.purpleAccent[100],
            ),
            SpeedDialChild(
              onTap: () {
                providermodel.restart(); // Add your logic for the first button
              },
              child: Icon(Icons.restart_alt),
              label: 'restart',
              backgroundColor: Colors.purpleAccent[100],
            ),
            SpeedDialChild(
              onTap: () {
                //call native code
                print("hello ");
                batterlevel();
              },
              child: Icon(Icons.battery_alert),
              label: 'check battery %',
              backgroundColor: Colors.purpleAccent[100],
            ),
          ],
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Provider Management"),
              Row(
                children: [
                  Icon(Icons.battery_0_bar),
                  Column(
                    children: [
                      Text('😢'),
                      Text(
                        batterpoint,
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          backgroundColor: Colors.purpleAccent[100],
        ),
        body: Container(
          child: Column(
            children: [
              Text(providermodel.num.last.toString()),
              Expanded(
                child: ListView.builder(
                    itemCount: providermodel.num.length,
                    itemBuilder: (context, index) {
                      return Text(providermodel.num[index].toString());
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => second()));
                  },
                  child: Text("Next"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> batterlevel() async {
    print("called");

    final arguments = {'name': 'Redmi'};
    final String batterypercent = await channel.invokeMethod(
        "show_batterylevel",
        arguments); // have to define which method to invoke  that we have written ina android

    // print("batterlevel : $batterypercent");
    setState(() => batterpoint = '$batterypercent %');
  }
}
