class Trip {
  var DOLocationID;
  var RatecodeID;
  var fare_amount;
  var congestion_surcharge;
  var tpep_dropoff_datetime;
  var VendorID;
  var passenger_count;
  var tolls_amount;
  var improvement_surcharge;
  var trip_distance;
  var payment_type;
  var store_and_fwd_flag;
  var total_amount;
  var extra;
  var tip_amount;
  var mta_tax;
  var PULocationID;
  var tpep_pickup_datetime;


  Trip.fromJson(Map data) {
        DOLocationID = data["DOLocationID"];
        RatecodeID = data["RatecodeID"];
        fare_amount = data["fare_amount"];
        congestion_surcharge = data["congestion_surcharge"];
        tpep_dropoff_datetime = DateTime.fromMillisecondsSinceEpoch(data["tpep_dropoff_datetime"] * 1000);
        VendorID = data["VendorID"];
        passenger_count = data["passenger_count"];
        tolls_amount = data["tolls_amount"];
        improvement_surcharge = data["improvement_surcharge"];
        trip_distance = data["trip_distance"];
        payment_type = data["payment_type"];
        store_and_fwd_flag = data["store_and_fwd_flag"];
        total_amount = data["total_amount"];
        extra = data["extra"];
        tip_amount = data["tip_amount"];
        mta_tax = data["mta_tax"];
        PULocationID = data["PULocationID"];
        tpep_pickup_datetime =  DateTime.fromMillisecondsSinceEpoch(data["tpep_pickup_datetime"] * 1000);
    }

  }
