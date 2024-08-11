class TripDetails {
  final String id;
  final String driverId;
  final String userId;
  final String origin;
  final String destination;
  final String amount;
  final String distance;
  final String time;
  final String otp;
  final String vehicleNo;
  final String vehicleType;
  final String tripStatus;
  final String uid;

  TripDetails({
    required this.id,
    required this.driverId,
    required this.userId,
    required this.origin,
    required this.destination,
    required this.amount,
    required this.distance,
    required this.time,
    required this.otp,
    required this.vehicleNo,
    required this.vehicleType,
    required this.tripStatus,
    required this.uid,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) {
    return TripDetails(
      id: json['_id'],
      driverId: json['driver_id'],
      userId: json['user_id'],
      origin: json['origin'],
      destination: json['destination'],
      amount: json['amount'],
      distance: json['distance'],
      time: json['time'],
      otp: json['otp'],
      vehicleNo: json['vehicle_no'],
      vehicleType: json['vehicle_type'],
      tripStatus: json['tripStatus'],
      uid: json['uid'],
    );
  }
}
