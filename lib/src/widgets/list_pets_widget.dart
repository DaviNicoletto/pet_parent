import 'package:flutter/material.dart';
import 'package:pet_parent/src/services/auth_service.dart';
import 'package:pet_parent/src/services/firestore_db.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  DBAuth auth = DBAuth();
  CloudDatabase db = CloudDatabase();

  Future<String?> _getUId() async {
    String? uId = await auth.getLoggedUserId();
    return uId;
  }

  void _loadPetList() async {
    final String? uId = await _getUId();
    await db.listPets(context, uId);
  }

    @override
  void initState() {
    super.initState();
    _loadPetList();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("Check console to the pet list"),
    );
  }
}
