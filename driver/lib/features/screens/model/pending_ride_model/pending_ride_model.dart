class Ride {
  final String id;
  final String userId;
  final String origin;
  final String destination;
  final String amount;
  final String distance;
  final String time;
  final String tripStatus;
  final String vehicleType;
  final String uid;

  Ride({
    required this.id,
    required this.userId,
    required this.origin,
    required this.destination,
    required this.amount,
    required this.distance,
    required this.time,
    required this.tripStatus,
    required this.vehicleType,
    required this.uid,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['_id'],
      userId: json['user_id'],
      origin: json['origin'],
      destination: json['destination'],
      amount: json['amount'],
      distance: json['distance'],
      time: json['time'],
      tripStatus: json['tripStatus'],
      vehicleType: json['vehicle_type'],
      uid: json['uid'],
    );
  }
}
