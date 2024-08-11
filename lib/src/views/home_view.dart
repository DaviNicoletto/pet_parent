import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_parent/src/views/pets_view.dart';
import 'package:pet_parent/src/widgets/app_bar_widget.dart';
import 'package:pet_parent/src/widgets/appointment_modal_widget.dart';
import 'package:pet_parent/src/widgets/custom_navigation_bar.dart';
import '../constants/app_constants.dart';
import '../widgets/section_container.dart';
import '../widgets/calendar_widget.dart';
import 'agenda_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppConstants constants = AppConstants();
  AppColors colors = AppColors();
    
    static final List<Widget> _widgetOptions = <Widget>[
      AgendaPage(constants: AppConstants(), colors: AppColors()),
      PetsPage(constants: AppConstants(), colors: AppColors()),
      AgendaPage(constants: AppConstants(), colors: AppColors()),
      AgendaPage(constants: AppConstants(), colors: AppColors()),
    ];

    int _selectedIndex = 0;

    void _ontItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppBar(),

      body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
      
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'Meus pets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Serviços',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Perfil',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _ontItemTapped,
    ));
    
  }
}