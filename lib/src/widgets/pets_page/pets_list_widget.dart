import 'package:flutter/material.dart';
import 'package:pet_parent/src/models/pet_model.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/services/firestore_db.dart';
import 'package:pet_parent/src/widgets/pets_page/pet_card_widget.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  DBAuth auth = DBAuth();
  CloudDatabase db = CloudDatabase();
  List<Pet> petsList = [];
  bool isLoading = true;

  Future<String?> _getUId() async {
    String? uId = await auth.getLoggedUserId();
    return uId;
  }

  void _loadPetList() async {
    final String? uId = await _getUId();
    petsList = await db.listPets(context, uId);
    print(petsList);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPetList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: const CircularProgressIndicator())
        : Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: petsList.length,
              itemBuilder: (context, index) {
                final pet = petsList[index];
                return PetCard(
                    name: pet.name,
                    age: pet.age,
                    gender: pet.gender,
                    breed: pet.breed);
              },
            ),
          );
  }
}
