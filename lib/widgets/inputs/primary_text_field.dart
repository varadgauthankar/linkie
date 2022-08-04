import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const PrimaryTextField({
    Key? key,
    required this.formKey,
    required this.validator,
    required this.controller,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
    );
  }
}
