import 'package:flutter/material.dart';

class InputWrapper extends StatelessWidget {
  const InputWrapper(
      {super.key,
      required this.label,
      required this.placeHolder,
      this.keyboardType,
      this.initialValue,
      this.onEditingComplete,
      this.textInputAction,
      this.validator,
      this.textEditingController,
      this.onChange});
  final String label;
  final String? initialValue;
  final String placeHolder;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 5),
          child: Text(label),
        ),
        TextFormField(
          initialValue: initialValue,
          controller: textEditingController,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          onEditingComplete: onEditingComplete,
          validator: validator,
          onChanged: onChange,
          decoration: InputDecoration(hintText: placeHolder),
        ),
      ],
    );
  }
}
