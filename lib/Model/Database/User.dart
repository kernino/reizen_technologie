class User {
  final int id;
  final String firstName;
  final String lastName;
  final int acceptedConditions;
  final String token;
  final int traveller_id;
  final int trip_id;

  User({this.id, this.firstName, this.lastName, this.acceptedConditions, this.token, this.traveller_id, this.trip_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'accepted_conditions': acceptedConditions,
      'token': token,
      'traveller_id': traveller_id,
      'trip_id': trip_id
    };
  }
}