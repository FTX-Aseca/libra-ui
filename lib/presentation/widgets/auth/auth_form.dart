import 'package:flutter/material.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/widgets/auth/auth_button.dart';
import 'package:libra_ui/presentation/widgets/shared/libra_text_form_field.dart';

enum FieldType { text, email, password }

class FormFieldConfig {
  final String fieldName; // Unique key for the field
  final FieldType type;
  final IconData icon;
  final String placeholder;
  final String labelText;
  final bool initiallyObscure;
  final String? Function(String? value)? validator;
  final TextInputAction? textInputAction;

  FormFieldConfig({
    required this.fieldName,
    required this.type,
    required this.icon,
    required this.placeholder,
    required this.labelText,
    this.initiallyObscure = false,
    this.validator,
    this.textInputAction,
  });
}

class AuthForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<FormFieldConfig> fieldConfigs;
  final bool isLoading;
  final Future<void> Function(Map<String, String> values) onSubmit;
  final String submitButtonText;
  final String title;
  final String subtitle;
  final String alternateAuthText;
  final String alternateAuthLinkText;
  final VoidCallback onAlternateAuthPressed;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.fieldConfigs,
    required this.isLoading,
    required this.onSubmit,
    required this.submitButtonText,
    required this.title,
    required this.subtitle,
    required this.alternateAuthText,
    required this.alternateAuthLinkText,
    required this.onAlternateAuthPressed,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = {};
    _focusNodes = {};
    for (var config in widget.fieldConfigs) {
      _controllers[config.fieldName] = TextEditingController();
      _focusNodes[config.fieldName] = FocusNode();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  TextEditingController? getController(String fieldName) =>
      _controllers[fieldName];

  void _submitForm() {
    if (widget.formKey.currentState!.validate()) {
      final values = _controllers.map(
        (key, controller) => MapEntry(key, controller.text),
      );
      widget.onSubmit(values);
    }
  }

  String? _getDefaultValidator(
    FieldType type,
    String? value,
    String label, {
    String? passwordFieldName,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter $label';
    }
    if (type == FieldType.email && !value.contains('@')) {
      return 'Please enter a valid email';
    }
    if (type == FieldType.password &&
        passwordFieldName != null &&
        _controllers.containsKey(passwordFieldName)) {
      // This specific validator (like min length) should be in FormFieldConfig
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: LibraColors.primaryText,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: LibraColors.secondaryText,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          ..._buildFormFields(),
          const SizedBox(height: 30),
          AuthButton(
            text: widget.submitButtonText,
            isLoading: widget.isLoading,
            onPressed: _submitForm,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: widget.onAlternateAuthPressed,
            child: RichText(
              text: TextSpan(
                text: widget.alternateAuthText,
                style: const TextStyle(
                  color: LibraColors.secondaryText,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.alternateAuthLinkText,
                    style: const TextStyle(
                      color: LibraColors.accentTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormFields() {
    final List<Widget> formFields = [];
    for (int i = 0; i < widget.fieldConfigs.length; i++) {
      final config = widget.fieldConfigs[i];
      final controller = _controllers[config.fieldName]!;
      final focusNode = _focusNodes[config.fieldName]!;
      final nextFocusNode = (i < widget.fieldConfigs.length - 1)
          ? _focusNodes[widget.fieldConfigs[i + 1].fieldName]
          : null;

      formFields.add(
        LibraTextFormField(
          controller: controller,
          labelText: config.labelText,
          hintText: config.placeholder,
          prefixIconData: config.icon,
          obscureText: config.initiallyObscure,
          keyboardType: config.type == FieldType.email
              ? TextInputType.emailAddress
              : config.type == FieldType.password
              ? TextInputType
                    .visiblePassword // Allows toggling if AuthTextFormField supports it
              : TextInputType.text,
          validator: (value) {
            // 1. Use provided validator if it exists
            if (config.validator != null) {
              return config.validator!(value);
            }
            // 2. Default validation
            final String? defaultValidation = _getDefaultValidator(
              config.type,
              value,
              config.labelText,
            );
            if (defaultValidation != null) return defaultValidation;

            // 3. Specific cross-field validations (example for confirmPassword)
            if (config.fieldName == 'confirmPassword' &&
                _controllers.containsKey('password')) {
              if (value != _controllers['password']?.text) {
                return 'Passwords do not match';
              }
            }
            return null;
          },
          focusNode: focusNode,
          onFieldSubmitted: (val) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              _submitForm(); // Submit form if it's the last field
            }
          },
          textInputAction:
              config.textInputAction ??
              (nextFocusNode != null
                  ? TextInputAction.next
                  : TextInputAction.done),
        ),
      );
      if (i < widget.fieldConfigs.length - 1) {
        formFields.add(const SizedBox(height: 20));
      }
    }
    return formFields;
  }
}
