class AddressModel {
  String id;
  String fullName;
  String mobileNumber;
  String city;
  String location;
  String dzongkhag;

  AddressModel({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.city,
    required this.location,
    required this.dzongkhag,
  });

  // Convert a PlaceModel object into a Map object to send to Cloud,---->used when u want to create
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'city': city,
      'location': location,
      'dzongkhag': dzongkhag,
    };
  }

  // Create a PlaceModel object from a Map object for fetching from Cloud\
// Convert the Map object to PlaceModel object
  factory AddressModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AddressModel(
      id: documentId,
      fullName: map['fullName'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      city: map['city'] ?? '',
      location: map['location'] ?? '',
      dzongkhag: map['dzongkhag'] ?? '',
    );
  }
}
