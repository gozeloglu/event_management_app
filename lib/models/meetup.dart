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
  final int meetupID;
  final String meetupName;
  final String details;
  final String address;
  final String placeName;
  final String startDate;
  final String endDate;
  final int quota;
  final int registeredCount;

  factory Meetup.fromJson(Map<String, dynamic> json) {
    return Meetup(
      meetupID: json["id"] as int,
      meetupName: json["meetupName"] as String,
      details: json["details"] as String,
      address: json["address"] as String,
      placeName: json["placeName"] as String,
      startDate: json["startDate"] as String,
      endDate: json["endDate"] as String,
      quota: json["quota"] as int,
      registeredCount: json["registeredUserCount"] as int,
    );
  }
}