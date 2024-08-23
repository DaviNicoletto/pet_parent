import 'package:pet_parent/src/models/appointment_model.dart';

class Pet {
  final String name;
  final String gender;
  final String breed;
  final String color;
  final int age;
  final String? specialNecessities;
  final List<Appointment>? schedule;

  Pet(
      {required this.name,
      required this.gender,
      required this.breed,
      required this.color,
      required this.age,
      this.specialNecessities,
      this.schedule});

  toJson() {
    return {
      "Name": name,
      "Gender": gender,
      "Breed": breed,
      "Color": color,
      "Age": age,
      "SpecialNecessities": specialNecessities,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
        name: map["Name"] as String,
        gender: map["Gender"] as String,
        breed: map["Breed"] as String,
        color: map["Color"] as String,
        age: map["Age"] as int,
        specialNecessities: map["SpecialNecessities"] ?? "none",
        schedule: map["Schedule"] ?? []);
  }
}
