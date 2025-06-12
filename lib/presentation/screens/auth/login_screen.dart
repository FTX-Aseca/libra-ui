import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';
import 'package:libra_ui/presentation/providers/auth/auth_message_provider.dart';
import 'package:libra_ui/presentation/widgets/auth/auth_form.dart';
import 'package:libra_ui/domain/mappers/error_mapper.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to show SnackBar after the build phase.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authMessage = ref.read(authMessageProvider);
      if (authMessage != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authMessage)));
        // Clear the message after displaying it
        ref.read(authMessageProvider.notifier).state = null;
      }
    });
  }

  Future<void> _login(Map<String, String> values) async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(authRepositoryProvider.notifier)
          .login(email: values['email']!, password: values['password']!);
      if (mounted) {
        context.go(AppRoutes.home);
      }
    } catch (e) {
      final errorMessage = ErrorMapper.mapError(e);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login Failed: $errorMessage')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<FormFieldConfig> loginFields = [
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
      ),
    ];

    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Login'),
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
              fieldConfigs: loginFields,
              isLoading: _isLoading,
              onSubmit: _login,
              submitButtonText: 'Login',
              title: 'Welcome to Libra Wallet!',
              subtitle: 'Login to your account',
              alternateAuthText: "Don't have an account? ",
              alternateAuthLinkText: 'Sign Up',
              onAlternateAuthPressed: () => context.push(AppRoutes.register),
            ),
          ),
        ),
      ),
    );
  }
}
