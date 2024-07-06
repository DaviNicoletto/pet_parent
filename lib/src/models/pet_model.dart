  class Pet {
    final String name;
    final String gender;
    final String breed;
    final String color;
    final int age;
    final String? specialNecessities;
    final String? schedule;

    Pet({required this.name, required this.gender,required this.breed,required this.color, required this.age, this.specialNecessities, this.schedule});

    toJson(){
      return{
        "Name": name,
        "Gender": gender,
        "Breed": breed,
        "Color": color,
        "Age": age,
        "SpecialNecessities": specialNecessities,
      };
    }
  }