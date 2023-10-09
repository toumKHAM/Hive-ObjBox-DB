import 'package:objectbox/objectbox.dart';

@Entity()
class ObjBoxModel{
  int id;
  String name;
  String surname;
  String birth_date;
  String address;
  String tel;

  ObjBoxModel({
    this.id=0,
    required this.name,
    required this.surname,
    required this.birth_date,
    required this.address,
    required this.tel
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['birth_date'] = birth_date;
    data['address'] = address;
    data['tel'] = tel;
    return data;
  }
}