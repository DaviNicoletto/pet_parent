import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/models/pet_model.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/services/firestore_db.dart';
import 'package:pet_parent/src/views/pets_view.dart';
import 'package:pet_parent/src/widgets/pets_page/pet_card_widget.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  DBAuth auth = DBAuth();
  CloudDatabase db = CloudDatabase();

  late Stream<List<Pet>> _petsStream;

  Future<String?> _getUId() async {
    String? uId = await auth.getLoggedUserId();
    return uId;
  }

  @override
  void initState() {
    _getUId().then((uId) {
      if (uId != null) {
        setState(() {
          _petsStream = db.streamPets(context, uId);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppConstants constants = AppConstants();
    AppColors colors = AppColors();
    final PetsPage widget = PetsPage(constants: constants, colors: colors);

    return StreamBuilder(
        stream: _petsStream,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('ERRO: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Uau! As coisas estão quietas por aqui!",
                    style: TextStyle(fontSize: constants.titleFontSize),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Você não possui pets registrados, adicione novos pets clicando no botão abaixo:",
                    style: TextStyle(fontSize: constants.textFontSize),
                    textAlign: TextAlign.center,
                  ),
                  Container(padding: const EdgeInsets.all(20),child: AddNewPetButton(widget: widget))
                ],
              ),
            );
          } else {
            final petsList = snapshot.data!;

            return Container(
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
        }));
  }
}
