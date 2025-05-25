import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';
import 'package:libra_ui/presentation/widgets/auth/auth_form.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _register(Map<String, String> values) async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(authRepositoryProvider.notifier)
          .register(email: values['email']!, password: values['password']!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration Successful! Please login.'),
          ),
        );
        context.go(AppRoutes.login);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<FormFieldConfig> registerFields = [
      FormFieldConfig(
        fieldName: 'email',
        type: FieldType.email,
        icon: Icons.email_outlined,
        labelText: 'Email',
        placeholder: 'Enter your email',
      ),
      FormFieldConfig(
        fieldName: 'password',
        type: FieldType.password,
        icon: Icons.lock_outline,
        labelText: 'Password',
        placeholder: 'Enter your password',
        initiallyObscure: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
      FormFieldConfig(
        fieldName: 'confirmPassword',
        type: FieldType.password,
        icon: Icons.lock_outline,
        labelText: 'Confirm Password',
        placeholder: 'Confirm your password',
        initiallyObscure: true,
        // Cross-field validation is handled in AuthForm by checking fieldName == 'confirmPassword'
        // and comparing with 'password' controller. So no specific validator needed here for that,
        // but we still need basic empty check.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          }
          return null;
        },
      ),
    ];

    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: LibraColors.scaffoldBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: LibraColors.primaryText),
        titleTextStyle: const TextStyle(
          color: LibraColors.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: AuthForm(
              formKey: _formKey,
              fieldConfigs: registerFields,
              // confirmPasswordController is no longer needed here as it's part of fieldConfigs
              isLoading: _isLoading,
              onSubmit: _register,
              submitButtonText: 'Sign Up',
              title: 'Get Started',
              subtitle: 'Create an account to continue',
              alternateAuthText: 'Already have an account? ',
              alternateAuthLinkText: 'Login',
              onAlternateAuthPressed: () => context.pop(),
              // isRegisterForm is also no longer needed, AuthForm infers from confirmPassword field or specific validators
            ),
          ),
        ),
      ),
    );
  }
}
