class Meetup {
  const Meetup({
    this.meetupID,
    this.meetupName,
    this.details,
    this.address,
    this.placeName,
    this.startDate,
    this.endDate,
    this.quota,
    this.registeredCount
});
  final String meetupID;
  final String meetupName;
  final String details;
  final String address;
  final String placeName;
  final DateTime startDate;
  final DateTime endDate;
  final int quota;
  final int registeredCount;

  factory Meetup.fromJson(Map<String, dynamic> json) {
    return Meetup(
      meetupID: json["meetupID"] as String,
      meetupName: json["meetupName"] as String,
      details: json["details"] as String,
      address: json["address"] as String,
      placeName: json["placeName"] as String,
      startDate: json["startDate"] as DateTime,
      endDate: json["endDate"] as DateTime,
      quota: json["quota"] as int,
      registeredCount: json["registeredCount"] as int,
    );
  }
}