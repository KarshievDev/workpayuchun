
class Contacts{

  final List<Contact> contacts;

  Contacts({required this.contacts});

  factory Contacts.fromJson(Map<String,dynamic> json){
    return Contacts(
      contacts: (json['data']['items'] as List).map((e) => Contact.fromJson(e)).toList()
    );
  }

}

class Contact{

  final int? id;
  final String? name;
  final String? phone;
  final String? avatar;
  final String? gender;
  final String? bloodGroup;
  final String? address;

  Contact({this.id, this.name, this.phone, this.avatar, this.gender,
      this.bloodGroup, this.address});

  factory Contact.fromJson(Map<String,dynamic> json){
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      avatar: json['avatar'],
      gender: json['gender'],
      bloodGroup: json['blood_group'],
      address: json['permanent_address']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'phone':phone,
      'avatar':avatar,
      'gender':gender,
      'blood_group':bloodGroup,
      'permanent_address':address
    };
  }
}