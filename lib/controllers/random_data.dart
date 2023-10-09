import 'package:faker/faker.dart';
import 'dart:math';

class RandomData{
  late int id;
  late String name;
  late String surname;
  late String birth_date;
  late String address;
  late String tel;

  RandomData.forHive(){
    var faker = Faker();
    id = Random().nextInt(10000);
    name = faker.person.firstName();
    surname = faker.person.lastName();
    birth_date = faker.date.dateTime(minYear: 2000, maxYear: 2020).toString();
    address = "${faker.address.city()}  ${faker.address.country()}";
    tel = faker.phoneNumber.us();
  }

  RandomData.forObjBox(){
    var faker = Faker();
    name = faker.person.firstName();
    surname = faker.person.lastName();
    birth_date = faker.date.dateTime(minYear: 2000, maxYear: 2020).toString();
    address = "${faker.address.city()}  ${faker.address.country()}";
    tel = faker.phoneNumber.us();
  }

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