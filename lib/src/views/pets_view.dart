import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/widgets/pets_page/add_pet_modal_widget.dart';
import 'package:pet_parent/src/widgets/pets_page/pets_list_widget.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({
    super.key,
    required this.constants,
    required this.colors,
  });

  final AppConstants constants;
  final AppColors colors;

  @override
  State<PetsPage> createState() => _PetsPageState();
}
//TODO: ALTERAR OS FORMULARIOS PARA VALIDAR A ENTRADA CORRETAMENTE
class _PetsPageState extends State<PetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(),
          Expanded(child: PetsList()),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 70,
                      height: 70,
                      //TODO: Antes de montar o modal do form para task, criar o sistema de adicionar pets.
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => PetModal());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              widget.colors.colorHighlight),
                        ),
                        child: const Text("+",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.w300)),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
