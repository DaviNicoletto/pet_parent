import 'package:flutter/material.dart';
import 'package:pet_parent/src/constants/app_constants.dart';

class DialogMessage extends StatefulWidget {
  const DialogMessage({
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

    AppConstants constants = AppConstants();
    if (widget.title == constants.error) {
      buttonText = '';
    }
    return AlertDialog(
      actions: [
        widget.title == constants.error
            ? TextButton(
                onPressed: () => Navigator.of(context).pop,
                child: Text(constants.goBack))
            : buttonText == ''
                ? TextButton(onPressed: () {}, child: const Text(""))
                : Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop;
                          },
                          child: Text(constants.goBack)),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(widget.buttonRoute);
                          },
                          child: Text(buttonText)),
                    ],
                  ),
      ],
      title: Text(widget.title),
      contentPadding: const EdgeInsets.all(15.0),
      content: Text(widget.message),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
