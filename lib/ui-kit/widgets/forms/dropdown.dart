import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final String Function(T) getLabel;
  final T value;
  final void Function(T?) onChanged;

  const AppDropdownInput({
    super.key,
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.getLabel,
    required this.onChanged, required this.value,
  });


  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(0, 247, 247, 249),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.white)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<T>(
              style: GoogleFonts.roboto(color: Colors.black),
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
