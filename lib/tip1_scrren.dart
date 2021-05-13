import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'Trip.dart';

class Tip_1 extends StatefulWidget {
  @override
  _Tip_1State createState() => _Tip_1State();

  // Setting to true will force the tab to never be disposed. This could be dangerous.
  @override
  bool get wantKeepAlive => true;
}

class _Tip_1State extends State<Tip_1> {
  List<Trip> tripItems = [];

  calculateTipOneTrip() {
    tripItems = [];
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.once().then((snapshot) {
      List tempItems = snapshot.value;
      tempItems.forEach((value) {
        tripItems.add(Trip.fromJson(value));
      });
      tripItems.sort((a, b) => b.trip_distance.compareTo(a.trip_distance));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () => calculateTipOneTrip(),
              child: Text("Tıkla"),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              )),
        ),
        tripItems.length > 1
            ? SizedBox(
                height: 450,
                child: ListView.builder(
                  itemBuilder: (context, index) => tripElement(context, index),
                  itemCount: 20,
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget tripElement(BuildContext context, index) {
    Trip currentItem = tripItems[index];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 6,
        child: ListTile(
          leading: Icon(
            Icons.local_taxi,
            color: Colors.teal,
            size: 40,
          ),
          title: Text(
            currentItem.trip_distance.toString(),
            style: TextStyle(fontSize: 18),
          ),
          subtitle:
              Text(DateFormat.yMMMd().format(currentItem.tpep_pickup_datetime)),
        ),
      ),
    );
  }
}
