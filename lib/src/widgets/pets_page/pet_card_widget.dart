import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/services/media_storage.dart';
import 'package:pet_parent/src/widgets/common/section_container.dart';

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

  String urlPetImage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ExpansionTile(
            title: Text(widget.name),
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
                      IconButton(
                        onPressed: () => uploadPetImage(),
                        icon: const Icon(
                          Icons.pets,
                          size: 60,
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                ],
              ),
            ],
            onExpansionChanged: (bool isExpanded) {
              setState(() {
                _cardIsExpanded = isExpanded;
              });
            },
          ),
        ),
      ],
    );
  }
}
