import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String surname;

  @HiveField(3)
  String birth_date;

  @HiveField(4)
  String address;

  @HiveField(5)
  String tel;

  HiveModel(this.id, this.name, this.surname, this.birth_date, this.address, this.tel);

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
