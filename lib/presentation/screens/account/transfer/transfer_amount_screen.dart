import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/presentation/widgets/shared/libra_text_form_field.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:libra_ui/presentation/screens/account/transfer/transfer_loading_screen.dart';

class TransferAmountScreen extends ConsumerStatefulWidget {
  final String dest;
  final bool isAlias;
  final OperationType operationType;

  const TransferAmountScreen({
    super.key,
    required this.dest,
    required this.isAlias,
    required this.operationType,
  });

  @override
  ConsumerState<TransferAmountScreen> createState() =>
      _TransferAmountScreenState();
}

class _TransferAmountScreenState extends ConsumerState<TransferAmountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  bool _isAmountValid = false;
  double _balance = 0.0;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged(String value) {
    final parsed = double.tryParse(value);
    setState(() {
      if (widget.operationType == OperationType.transfer) {
        _isAmountValid = parsed != null && parsed > 0 && parsed <= _balance;
      } else {
        _isAmountValid = parsed != null && parsed > 0;
      }
    });
  }

  void _onConfirm() {
    final amount = double.parse(_amountController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferLoadingScreen(
          dest: widget.dest,
          isAlias: widget.isAlias,
          amount: amount,
          operationType: widget.operationType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balanceAsync = ref.watch(balanceProvider);
    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: widget.operationType == OperationType.transfer
            ? balanceAsync.when(
                data: (balance) {
                  _balance = balance;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.operationType == OperationType.transfer
                                ? 'Enter Amount'
                                : widget.operationType == OperationType.debin
                                ? 'Enter DEBIN Amount'
                                : 'Enter Top-Up Amount',
                            style: const TextStyle(
                              color: LibraColors.primaryText,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (widget.operationType != OperationType.topUp) ...[
                            Text(
                              widget.operationType == OperationType.debin
                                  ? 'DEBIN from: ${widget.dest}'
                                  : 'Transfer to: ${widget.dest}',
                              style: const TextStyle(
                                color: LibraColors.secondaryText,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          LibraTextFormField(
                            controller: _amountController,
                            labelText: 'Amount',
                            hintText: '0.00',
                            prefixIconData: Icons.attach_money,
                            keyboardType: TextInputType.number,
                            validator: _validateBalance,
                            onChanged: _onAmountChanged,
                            textInputAction: TextInputAction.done,
                          ),
                          if (widget.operationType == OperationType.transfer &&
                              _amountController.text.isNotEmpty &&
                              (double.tryParse(_amountController.text) ?? 0) >
                                  _balance)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Insufficient balance',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isAmountValid ? _onConfirm : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: LibraColors.accentTeal,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Confirm',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.operationType == OperationType.topUp
                          ? 'Enter Top-Up Amount'
                          : 'Enter DEBIN Amount',
                      style: const TextStyle(
                        color: LibraColors.primaryText,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LibraTextFormField(
                      controller: _amountController,
                      labelText: 'Amount',
                      hintText: '0.00',
                      prefixIconData: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final v = double.tryParse(value ?? '');
                        if (v == null || v <= 0) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                      onChanged: _onAmountChanged,
                      textInputAction: TextInputAction.done,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isAmountValid ? _onConfirm : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LibraColors.accentTeal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: NavBar.common(),
    );
  }

  String? _validateBalance(value) {
    final v = double.tryParse(value ?? '');
    if (v == null || v <= 0) {
      return 'Enter a valid amount';
    }
    if (widget.operationType == OperationType.transfer && v > _balance) {
      return 'Insufficient balance';
    }
    return null;
  }
}
