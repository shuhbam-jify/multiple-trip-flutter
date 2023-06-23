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
  String? status;
  PickupLocation? pickupLocation;
  List<PickupLocation>? dropLocation;

  Bookings(
      {this.bookingId,
      this.bookingDate,
      this.amount,
      this.status,
      this.pickupLocation,
      this.dropLocation});

  Bookings.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingDate = json['booking_date'];
    amount = json['amount'];
    status = json['status'];
    pickupLocation = json['pickup_location'] != null
        ? new PickupLocation.fromJson(json['pickup_location'])
        : null;
    if (json['drop_location'] != null) {
      dropLocation = <PickupLocation>[];
      json['drop_location'].forEach((v) {
        dropLocation!.add(new PickupLocation.fromJson(v));
      });
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
