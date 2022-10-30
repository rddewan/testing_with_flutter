
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    ValueKey? textFieldKey,
    required String labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isObscureText = false,
    String? Function(String?)? validator,
    required TextEditingController passwordConfirmController,
  }) : 
  _textFieldKey = textFieldKey,
  _labelText = labelText,
  _hintText = hintText,
  _prefixIcon = prefixIcon,
  _suffixIcon = suffixIcon,
  _validator = validator,
  _isObscureText = isObscureText,
  _passwordConfirmController = passwordConfirmController, 
  super(key: key);

  final ValueKey? _textFieldKey;
  final TextEditingController _passwordConfirmController;
  final String _labelText;
  final String? _hintText;
  final Widget? _prefixIcon;
  final Widget? _suffixIcon;
  final bool _isObscureText;
  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _textFieldKey,   
      controller: _passwordConfirmController,
      obscureText: _isObscureText,             
      decoration: InputDecoration(
        labelText: _labelText,
        hintText: _hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: _prefixIcon,
        suffixIcon: _suffixIcon,            
      ),
      validator: _validator,
    );
  }
}