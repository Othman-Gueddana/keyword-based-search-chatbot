import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
export 'text_input.dart';

Widget myTextField(
    {required TextEditingController controller,
    required TextInputType keyboardType,
    inputFormatterList,
    int? errorMaxLines,
    bool? obscureText,
    String? hintText,
    bool? enableSuggestions,
    Function? validatorFunction,
    Function? onChangedFunction,
    Function? onTapFunction,
    String? prefix,
    Widget? suffix,
    bool? enabled,
    TextInputAction? textInputAction}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextFormField(
      textInputAction: textInputAction,
      style: const TextStyle(
        fontSize: 14.0,
        fontFamily: "Mark Pro",
        color: Colors.black,
      ),
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled ?? true,
      obscureText: obscureText ?? false,
      autocorrect: false,
      inputFormatters: inputFormatterList ?? [],
      onTap: () => onTapFunction,
      onChanged: (value) {
        debugPrint("search value : $value");
      },
      validator: (value) {
        if (validatorFunction != null) {
          return validatorFunction(value);
        } else {
          return null;
        }
      },
      enableSuggestions: enableSuggestions ?? true,
      enableInteractiveSelection: true,
      contextMenuBuilder:
          (BuildContext context, EditableTextState editableTextState) {
        return AdaptiveTextSelectionToolbar(
          anchors: editableTextState.contextMenuAnchors,
          // Build the default buttons, but make them look custom.
          // In a real project you may want to build different
          // buttons depending on the platform.
          children: editableTextState.contextMenuButtonItems
              .map((ContextMenuButtonItem buttonItem) {
            return CupertinoButton(
              borderRadius: null,
              color: Colors.grey,
              disabledColor: const Color(0xffaaaaff),
              onPressed: buttonItem.onPressed,
              padding: const EdgeInsets.all(10.0),
              pressedOpacity: 0.7,
              child: SizedBox(
                width: 50.0,
                child: Text(
                  CupertinoTextSelectionToolbarButton.getButtonLabel(
                      context, buttonItem),
                ),
              ),
            );
          }).toList(),
        );
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText ?? "",
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: "Mark Pro",
          color: Colors.grey,
        ),
        errorMaxLines: errorMaxLines ?? 1,
        //contentPadding: EdgeInsets.only(left: prefix == null ? 0 : 32),
        //prefixText: prefix == null ? 'prefix' : "       $prefix",
        prefixText: prefix,
        //prefixStyle: prefix == null ? TextStyle(color: Colors.transparent) : null,
        suffix: suffix,
        /*   border: Styles.textFieldRoundedBorder,
        focusedBorder: Styles.textFieldRoundedBorder,
        enabledBorder: Styles.textFieldRoundedBorder,
        disabledBorder: Styles.textFieldRoundedBorder,
        errorBorder: Styles.textFieldErrorRoundedBorder,
        focusedErrorBorder: Styles.textFieldRoundedBorder, */
        labelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "Montserrat",
          color: Colors.grey,
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontFamily: "Montserrat",
        ),
      ),
      cursorColor: Colors.black,
      cursorWidth: 1.0,
    ),
  );
}
