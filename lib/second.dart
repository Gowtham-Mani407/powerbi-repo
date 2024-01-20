import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Listprovider.dart';

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  Widget build(BuildContext context) {
    return Consumer<listnumprovider>(
      builder: (BuildContext context, providermodel, Widget? child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            providermodel.add();
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Provider Management"),
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
            ],
          ),
        ),
      ),
    );
  }
}
