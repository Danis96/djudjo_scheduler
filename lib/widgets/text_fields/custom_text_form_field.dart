import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { passwordType, textAreaType, dropdownFieldType }

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.label = '',
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.icon,
    this.errorTextEmpty,
    this.identical = true,
    this.onChange,
    this.onEditingComplete,
    this.fKey,
    this.readOnly = false,
    this.type,
    this.errorTextConfirm,
    this.dropdownPressFunction,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.validation,
    this.errorMessage,
    this.style,
    this.errorStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
    ),
    this.labelStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Color.fromRGBO(257, 70, 82, 1),
    ),
    this.inputColor,
    this.obscureStarChar = false,
    this.helperText,
    this.height = 90,
    this.disableHeight = false,
    this.hintStyle,
    this.textInputAction,
    this.onFieldSubmitted,
    this.fillColor,
    this.focusNode,
    this.enabledBorder,
    this.errorBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    this.obscureIcon,
    this.disableObscureIcon,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool identical;
  final bool obscureStarChar;
  final Widget? icon;
  final String? errorTextEmpty;
  final String? errorTextConfirm;
  final Function? onChange;
  final Function? onEditingComplete;
  final Function? dropdownPressFunction;
  final Function? onTap;
  final Key? fKey;
  final bool readOnly;
  final TextFieldType? type;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validation;
  final TextCapitalization textCapitalization;
  final String? errorMessage;
  final TextStyle? style;
  final TextStyle errorStyle;
  final TextStyle labelStyle;
  final String? helperText;
  final double? height;
  final bool disableHeight;
  final TextStyle? hintStyle;
  final Color? inputColor;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Color? fillColor;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? errorBorder;
  final Widget? obscureIcon;
  final Widget? disableObscureIcon;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool filled = true;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormField(
          fillColor: widget.fillColor,
          onChanged: () {
            if (widget.onChange != null) {
              widget.onChange!();
            }
            setState(() {
              widget.controller!.text.isEmpty ? filled = true : filled = false;
            });
          },
          onEditingComplete: () {
            if (widget.onEditingComplete != null) {
              widget.onEditingComplete!();
            }
          },
          visibilityFunction: () => setState(() {
            _obscure = !_obscure;
          }),
          obscure: _obscure,
          obscureRegular: widget.obscureText,
          filled: filled,
          validation: widget.validation,
          controller: widget.controller,
          hintText: widget.hintText!,
          type: widget.type,
          icon: widget.icon,
          readOnly: widget.readOnly,
          key: widget.fKey,
          identical: widget.identical,
          errorTextConfirm: widget.errorTextConfirm,
          errorTextEmpty: widget.errorTextEmpty,
          dropdownPressFunction: widget.dropdownPressFunction,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.textCapitalization,
          errorMessage: widget.errorMessage,
          style: widget.style,
          errorStyle: widget.errorStyle,
          inputColor: widget.inputColor,
          helperText: widget.helperText,
          hintStyle: widget.hintStyle,
          obscureStarChar: widget.obscureStarChar,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          labelStyle: widget.labelStyle,
          height: widget.height,
          disableHeight: widget.disableHeight,
          obscureIcon: widget.obscureIcon,
          disableObscureIcon: widget.disableObscureIcon,
        ),
      ],
    );
  }
}

Widget _buildFieldLabel(String label, {TextStyle style = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    child: Text(label, style: style),
  );
}

Widget _buildTextFormField(
    {TextEditingController? controller,
    bool readOnly = false,
    bool filled = false,
    TextFieldType? type,
    bool obscure = false,
    bool obscureRegular = false,
    bool obscureStarChar = false,
    Widget? icon,
    String hintText = '',
    Function? onChanged,
    Function? onEditingComplete,
    Function? visibilityFunction,
    Function? dropdownPressFunction,
    Function? onTap,
    String? Function(String?)? validation,
    Key? key,
    String? errorTextConfirm,
    String? errorTextEmpty,
    bool identical = true,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization? textCapitalization,
    String? errorMessage,
    TextStyle? style,
    TextStyle? errorStyle,
    TextStyle? labelStyle,
    Color? inputColor,
    String? helperText,
    double? height,
    bool? disableHeight,
    TextStyle? hintStyle,
    TextInputAction? textInputAction,
    Function(String)? onFieldSubmitted,
    Color? fillColor,
    FocusNode? focusNode,
    OutlineInputBorder? errorBorder,
    OutlineInputBorder? enabledBorder,
    Widget? obscureIcon,
    Widget? disableObscureIcon}) {
  bool isPasswordType() => type == TextFieldType.passwordType;
  bool isDropDownType() => type == TextFieldType.dropdownFieldType;
  return SizedBox(
    height: disableHeight == true ? null : height,
    width: 400,
    child: TextFormField(
      key: key,
      focusNode: focusNode,
      maxLines: type == TextFieldType.textAreaType ? 10 : 1,
      textCapitalization: textCapitalization!,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      onTap: () => onTap != null ? onTap() : print(''),
      onChanged: (String input) {
        if (onChanged != null) {
          onChanged();
        }
      },
      onEditingComplete: () => onEditingComplete,
      style: style ?? TextStyle(color: inputColor),
      readOnly: readOnly,
      validator: validation ??
          (String? value) {
            if (value != null && value.isEmpty) {
              return errorTextEmpty;
            } else {
              return null;
            }
          },
      obscuringCharacter: obscureStarChar ? '*' : '•',
      obscureText: isPasswordType() ? obscure : obscureRegular,
      decoration: InputDecoration(
        fillColor: fillColor,
        hintStyle: hintStyle,
        helperText: helperText,
        suffixIcon: isDropDownType()
            ? IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                color: const Color.fromRGBO(189, 195, 199, 1),
                onPressed: () => dropdownPressFunction!(),
              )
            : isPasswordType()
                ? IconButton(
                    icon: obscure
                        ? obscureIcon ??
                            const Icon(
                              Icons.visibility,
                            )
                        : disableObscureIcon ??
                            const Icon(
                              Icons.visibility_off,
                            ),
                    color: const Color.fromRGBO(189, 195, 199, 1),
                    onPressed: () => visibilityFunction!(),
                  )
                : icon,
        hintText: hintText,
        filled: filled,
        errorStyle: errorStyle,
        labelStyle: labelStyle,
        errorText: errorMessage != null ? errorMessage : null,
        errorMaxLines: 2,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
      ),

      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}
