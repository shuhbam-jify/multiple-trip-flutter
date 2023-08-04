class BookingHistory {
  int? code;
  String? message;
  List<Bookings>? bookings;

  BookingHistory({this.code, this.message, this.bookings});

  BookingHistory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bookings {
  String? bookingId;
  String? bookingDate;
  String? amount;
  String? waitingCharges;
  String? status;

  String? driverName;
  String? driverEmail;
  String? driverMobileNumber;
  String? driverProfilePhoto;
  String? driverRating;
  PickupLocation? pickupLocation;
  List<PickupLocation>? dropLocation;
  String? distance;
  String? timing;
  String? driverLat;
  String? driverLong;

  Bookings({
    this.bookingId,
    this.bookingDate,
    this.amount,
    this.status,
    this.driverName,
    this.driverEmail,
    this.driverMobileNumber,
    this.driverProfilePhoto,
    this.driverRating,
    this.pickupLocation,
    this.dropLocation,
    this.distance,
    this.timing,
    this.driverLat,
    this.driverLong,
  });

  Bookings.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingDate = json['booking_date'];
    amount = json['amount'];
    amount = json['waiting_charges'];
    status = json['status'];
    driverName = json['driver_name'];
    driverEmail = json['driver_email'];
    driverMobileNumber = json['driver_mobile_number'] ?? json['driver_mobile'];
    driverProfilePhoto = json['driver_profile_photo'] ?? json['profile_photo'];
    distance = json['distance'];
    timing = json['timing'];

    pickupLocation = json['pickup_location'] != null
        ? new PickupLocation.fromJson(json['pickup_location'])
        : null;
    if (json['drop_location'] != null) {
      dropLocation = <PickupLocation>[];
      if (pickupLocation != null) {
        dropLocation!.add(pickupLocation!);
      }
      json['drop_location'].forEach((v) {
        dropLocation!.add(new PickupLocation.fromJson(v));
      });
      driverLat = json['driver_lat'];
      driverLong = json['driver_long'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_date'] = this.bookingDate;
    data['amount'] = this.amount;
    data['status'] = this.status;
    if (this.pickupLocation != null) {
      data['pickup_location'] = this.pickupLocation!.toJson();
    }
    if (this.dropLocation != null) {
      data['drop_location'] =
          this.dropLocation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PickupLocation {
  String? lat;
  String? long;
  String? address;

  PickupLocation({this.lat, this.long, this.address});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    return data;
  }
}
