// To parse this JSON data, do
//
//     final contactsSearch = contactsSearchFromJson(jsonString);

// List<ContactsSearch> contactsSearchFromJson(String str) =>
//     List<ContactsSearch>.from(
//         json.decode(str).map((x) => ContactsSearch.fromJson(x)));
//
// String contactsSearchToJson(List<ContactsSearch> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactsSearchList {
  final List<ContactsSearch> contactList;

  ContactsSearchList({required this.contactList});

  factory ContactsSearchList.fromJson(Map<String, dynamic> json) {
    return ContactsSearchList(
        contactList: (json['data']['items'] as List)
            .map((e) => ContactsSearch.fromJson(e))
            .toList()
        );
  }
}

class ContactsSearch {
  ContactsSearch({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.bloodGroup,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? bloodGroup;

  factory ContactsSearch.fromJson(Map<String, dynamic> json) => ContactsSearch(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        bloodGroup: json["blood_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "blood_group": bloodGroup,
      };
}
