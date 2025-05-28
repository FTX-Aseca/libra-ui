import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/widgets/shared/libra_text_form_field.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';
import 'package:libra_ui/presentation/screens/account/transfer/transfer_amount_screen.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  bool _isAlias = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _destController = TextEditingController();

  @override
  void dispose() {
    _destController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transfer',
                  style: TextStyle(
                    color: LibraColors.primaryText,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ToggleButtons(
                  isSelected: [_isAlias, !_isAlias],
                  onPressed: (index) {
                    setState(() {
                      _isAlias = index == 0;
                      _destController.clear();
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: LibraColors.accentTeal,
                  color: LibraColors.secondaryText,
                  fillColor: LibraColors.accentTeal.withValues(alpha: 0.2),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Alias'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('CVU'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LibraTextFormField(
                  controller: _destController,
                  labelText: _isAlias ? 'Alias' : 'CVU',
                  hintText: _isAlias ? 'Enter alias' : 'Enter CVU',
                  prefixIconData: _isAlias
                      ? Icons.account_box
                      : Icons.account_balance,
                  keyboardType: _isAlias
                      ? TextInputType.text
                      : TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter ${_isAlias ? 'alias' : 'CVU'}';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final dest = _destController.text.trim();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransferAmountScreen(
                              dest: dest,
                              isAlias: _isAlias,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LibraColors.accentTeal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar.common(),
    );
  }
}
