import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool? enabled;

  CustomTextField(
      {required this.controller,
      required this.hintText,
      required this.textInputType,
      this.maxLine,
      this.enabled,
      required this.focusNode,
      required this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor});

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: isPhoneNumber
            ? BorderRadius.only(
                topRight: Radius.circular(6), bottomRight: Radius.circular(6))
            : BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine ?? 1,
        textCapitalization: capitalization,
        maxLength: isPhoneNumber ? 15 : null,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        //keyboardType: TextInputType.number,
        initialValue: null,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        //autovalidate: true,
        inputFormatters: [
          isPhoneNumber
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter
        ],
        validator: (input) {
          if (input!.isEmpty) {
            if (isValidator) {
              return validatorMessage ?? "";
            }
          }
          return null;
        },
        enabled: enabled ?? true,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          hintStyle:
              titilliumRegular.copyWith(color: Theme.of(context).hintColor),
          errorStyle: TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

const titilliumRegular = TextStyle(
    fontFamily: 'Ubuntu',
    fontSize: Dimensions.FONT_SIZE_SMALL,
    color: Colors.black);

class Dimensions {
  static const double FONT_SIZE_EXTRA_SMALL = 10.0;
  static const double FONT_SIZE_SMALL = 12.0;
  static const double FONT_SIZE_DEFAULT = 14.0;
  static const double FONT_SIZE_LARGE = 16.0;
  static const double FONT_SIZE_EXTRA_LARGE = 18.0;
  static const double FONT_SIZE_OVER_LARGE = 24.0;

  static const double PADDING_SIZE_EXTRA_EXTRA_SMALL = 2.0;
  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;
  static const double HOME_PAGE_PADDING = 16.0;
  static const double PADDING_SIZE_DEFAULT_ADDRESS = 17.0;
  static const double PADDING_SIZE_LARGE = 20.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;

  static const double MARGIN_SIZE_EXTRA_SMALL = 5.0;
  static const double MARGIN_SIZE_SMALL = 10.0;
  static const double MARGIN_SIZE_DEFAULT = 15.0;
  static const double MARGIN_SIZE_LARGE = 20.0;
  static const double MARGIN_SIZE_EXTRA_LARGE = 25.0;

  static const double ICON_SIZE_EXTRA_SMALL = 12.0;
  static const double ICON_SIZE_SMALL = 18.0;
  static const double ICON_SIZE_DEFAULT = 24.0;
  static const double ICON_SIZE_LARGE = 32.0;
  static const double ICON_SIZE_EXTRA_LARGE = 40.0;

  static const double IMAGE_SIZE_EXTRA_SEVENTY = 70.0;
}

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintTxt;
  final FocusNode focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  CustomPasswordTextField(
      {required this.controller,
      this.hintTxt,
      this.validator,
      required this.focusNode,
      this.nextNode,
      required this.textInputAction});

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          controller: widget.controller,
          obscureText: _obscureText,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (v) {
            setState(() {
              widget.textInputAction == TextInputAction.done
                  ? FocusScope.of(context).consumeKeyboardToken()
                  : FocusScope.of(context).requestFocus(widget.nextNode);
            });
          },
          validator: widget.validator ??
              (value) {
                return null;
              },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: _toggle),
              hintText: widget.hintTxt ?? '',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
              isDense: true,
              filled: true,
              fillColor: Theme.of(context).highlightColor,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
              hintStyle:
                  titilliumRegular.copyWith(color: Theme.of(context).hintColor),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
