import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signalr_flutter/map.dart';
import 'package:signalr_netcore/signalr_client.dart';

class StreamManager extends StatefulWidget {
  const StreamManager({Key? key}) : super(key: key);

  @override
  _StreamManager createState() => _StreamManager();
}

class _StreamManager extends State<StreamManager> {
  late HubConnection hubConnection;

  late List<dynamic> data;

  @override
  void initState() {
    super.initState();
    data = [];
    initSignalR();
    //driverUpdate();
  }

  void initSignalR() {
    hubConnection = HubConnectionBuilder()
        .withUrl("https://localhost:44339/hubs/stream")
        .withAutomaticReconnect()
        .build();
    print(hubConnection);
    Update();
  }

  void Update() {
    hubConnection.start()?.then((value) => {
          hubConnection
              .stream("RiderStream", <Object>[7.334, 9.123]).listen((event) {
            setState(() {
              data = event as List<dynamic>;
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapPage(),
    );
  }
}
