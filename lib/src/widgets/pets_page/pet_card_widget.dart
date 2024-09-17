import 'package:flutter/material.dart';
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

class _PetCardState extends State<PetCard> {
  bool _cardIsExpanded = false;
  AppConstants constants = AppConstants();
  AppColors color = AppColors();

  double petNameFontSize = 17;
  FontWeight petNameFontWeight = FontWeight.normal;

  String urlPetImage = '';

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
      print("Erro ESPERADO ao carregar imagem: $e");
    }
  }

  void _onImageUploaded() {
    isLoading = true;
    loadPetImages(widget.name);
    isLoading = false;
  }

  @override
  void initState() {
    loadPetImages(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: ExpansionTile(
            title: Text(
              widget.name,
              style: TextStyle(
                  fontSize: petNameFontSize, fontWeight: petNameFontWeight),
            ),
            leading: _cardIsExpanded
                ? null
                : petHasImg
                    ? Container(height: 100, decoration: const BoxDecoration(shape: BoxShape.circle), clipBehavior: Clip.hardEdge,child: Image.network(petImage))
                    : const Icon(Icons.pets),
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
                      isLoading
                          ? const CircularProgressIndicator()
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
                                  onPressed: () => uploadPetImage(
                                      widget.name, _onImageUploaded),
                                  icon: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 205, 205, 205),
                                              offset: Offset(0, 0),
                                              blurRadius: 1)
                                        ]),
                                    child: Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 45,
                                      color: color.colorPrimary,
                                    ),
                                  ),
                                ),
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
