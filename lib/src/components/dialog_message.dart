import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class DialogMessage extends StatefulWidget {
  DialogMessage({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.buttonRoute,
  });

  final String title;
  final String message;
  final String buttonRoute;
  final String buttonText;


  @override
  State<DialogMessage> createState() => _DialogMessageState();
}

class _DialogMessageState extends State<DialogMessage> {

  @override
  Widget build(BuildContext context) {

    String buttonText = widget.buttonText; 

    AppColors colors = AppColors();
    AppConstants constants = AppConstants();
    if (widget.title == constants.error) {
              setState(() {
                buttonText = '';
              }); 
            }
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            if (widget.title == constants.error) {
              Navigator.of(context).pop();
            }
            Navigator.of(context).pushReplacementNamed(widget.buttonRoute);
          },
          child: Text(
            buttonText,
            style: TextStyle(color: colors.colorPrimary),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            constants.goBack,
            style: TextStyle(color: colors.colorPrimary),
          ),
        ),
      ],
      title: Text(widget.title),
      contentPadding: EdgeInsets.all(15.0),
      content: Text(widget.message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)),),
    );
  }
}