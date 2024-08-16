import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/media_storage.dart';

class PetCard extends StatefulWidget {
  const PetCard(
      {super.key,
      required this.name,
      required this.age,
      required this.gender,
      required this.breed});

  final String name;
  final int age;
  final String gender;
  final String breed;

  @override
  State<PetCard> createState() => _PetCardState();
}
//TODO: ALTERAR O CARD PARA TROCAR O ICONE DE PATINHA PELA FOTO DO PET
class _PetCardState extends State<PetCard> {
  bool _cardIsExpanded = false;
  AppConstants constants = AppConstants();
  AppColors color = AppColors();

  double petNameFontSize = 17;
  FontWeight petNameFontWeight = FontWeight.normal;

  String urlPetImage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ExpansionTile(
            title: Text(
              widget.name,
              style: TextStyle(
                  fontSize: petNameFontSize, fontWeight: petNameFontWeight),
            ),
            leading: _cardIsExpanded
                ? null
                : const Icon(
                    Icons.pets,
                    shadows: [Shadow(color: Colors.grey, blurRadius: 5)],
                  ),
            trailing: Icon(_cardIsExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded),
            expandedAlignment: Alignment.topLeft,
            childrenPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            shape: Border.all(color: Colors.transparent),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PetImage(
                          widget: widget, color: color, petName: widget.name),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Raça: ${widget.breed}"),
                          Text("Idade: ${widget.age}"),
                          Text("Sexo: ${widget.gender}"),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                ],
              ),
            ],
            onExpansionChanged: (bool isExpanded) {
              setState(() {
                _cardIsExpanded = isExpanded;

                isExpanded ? petNameFontSize = 20 : petNameFontSize = 17;
                isExpanded
                    ? petNameFontWeight = FontWeight.w500
                    : petNameFontWeight = FontWeight.normal;
              });
            },
          ),
        ),
      ],
    );
  }
}

class PetImage extends StatefulWidget {
  const PetImage({
    super.key,
    required this.widget,
    required this.color,
    required this.petName,
  });

  final PetCard widget;
  final AppColors color;
  final String petName;

  @override
  State<PetImage> createState() => _PetImageState();
}

class _PetImageState extends State<PetImage> {
  bool petHasImg = false;
  bool isLoading = true;
  String petImage = '';

  void loadPetImages(petName) async {
    try {
      String imagePath = await getPetsImages(petName);
      setState(() {
        petImage = imagePath;
        petHasImg = imagePath.isNotEmpty;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        petHasImg = false;
      });
      print("Erro ESPERADO ao carregar imagem: ${e}");
    }
  }

  void _onImageUploaded() {
    loadPetImages(widget.petName);
  }

  @override
  void initState() {
    loadPetImages(widget.petName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const CircularProgressIndicator())
        : petHasImg
            ? Container(
                width: 60,
                margin: const EdgeInsets.only(right: 13),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  petImage,
                ),
              )
            : IconButton(
                onPressed: () =>
                    uploadPetImage(widget.widget.name, _onImageUploaded),
                icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 205, 205, 205),
                            offset: Offset(0, 0),
                            blurRadius: 1)
                      ]),
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 45,
                    color: widget.color.colorPrimary,
                  ),
                ),
              );
  }
}
