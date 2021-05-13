import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'Trip.dart';

class Tip_2 extends StatefulWidget {
  @override
  _Tip_2State createState() => _Tip_2State();

  // Setting to true will force the tab to never be disposed. This could be dangerous.
  @override
  bool get wantKeepAlive => true;
}

class _Tip_2State extends State<Tip_2> {
  List<Trip> tripItems = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().subtract(Duration(days: 360));

  calculateTipTwoTrip() {
    tripItems = [];
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.once().then((snapshot) {
      List tempItems = snapshot.value;
      tempItems.forEach((value) {
        Trip tripItem = Trip.fromJson(value);
        if (tripItem.tpep_pickup_datetime.isAfter(endDate) &&
            tripItem.tpep_pickup_datetime.isBefore(startDate)) {
          tripItems.add(tripItem);
        }
      });
      tripItems.sort((a, b) => a.trip_distance.compareTo(b.trip_distance));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Center(
              child: GestureDetector(
            child: Text(
              "End: " + DateFormat('yyyy-MM-dd').format(startDate),
              style: TextStyle(fontSize: 20),
            ),
            onTap: () => _startDateSelector(context),
          )),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: GestureDetector(
              child: Text(
                "Start: " + DateFormat('yyyy-MM-dd').format(endDate),
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => _endDateSelector(context),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () => calculateTipTwoTrip(),
          child: Text("Tıkla"),
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
          ),
        ),
        tripItems.length > 1
            ? SizedBox(
                height: 350,
                child: ListView.builder(
                  itemBuilder: (context, index) => tripElement(context, index),
                  itemCount: 5,
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget tripElement(BuildContext context, index) {
    Trip currentItem = tripItems[index];
    print(currentItem.trip_distance);
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
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  _startDateSelector(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: startDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    ))!;
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  _endDateSelector(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: endDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    ))!;
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }
}
