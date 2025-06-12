import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/presentation/views/account/transfer/transfer_amount_view.dart';
import 'package:libra_ui/presentation/widgets/shared/libra_text_form_field.dart';
import 'package:libra_ui/presentation/views/account/transfer/transfer_loading_view.dart';
import 'package:libra_ui/presentation/views/account/transfer/transfer_confirmation_view.dart';

class TransferView extends ConsumerStatefulWidget {
  const TransferView({super.key});

  @override
  ConsumerState<TransferView> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferView> {
  int _stepIndex = 0;
  String _dest = '';
  double _amount = 0.0;
  bool _success = true;
  String? _errorMessage;
  bool _isAlias = true;
  OperationType _operationType = OperationType.transfer;
  static const List<OperationType> _operationOptions = [
    OperationType.transfer,
    OperationType.debin,
    OperationType.topUp,
  ];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _destController = TextEditingController();

  @override
  void dispose() {
    _destController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_stepIndex) {
      case 0:
        return _buildDestinationStep(context);
      case 1:
        return TransferAmountView(
          dest: _dest,
          isAlias: _isAlias,
          operationType: _operationType,
          onNext: (amount) => setState(() {
            _amount = amount;
            _stepIndex = 2;
          }),
        );
      case 2:
        return TransferLoadingView(
          dest: _dest,
          isAlias: _isAlias,
          amount: _amount,
          operationType: _operationType,
          onComplete: (success, errorMessage) => setState(() {
            _success = success;
            _errorMessage = errorMessage;
            _stepIndex = 3;
          }),
        );
      case 3:
        return TransferConfirmationView(
          dest: _dest,
          isAlias: _isAlias,
          amount: _amount,
          operationType: _operationType,
          success: _success,
          errorMessage: _errorMessage,
          onDone: () => setState(() {
            _stepIndex = 0;
            _destController.clear();
            _isAlias = true;
            _operationType = OperationType.transfer;
          }),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDestinationStep(BuildContext context) {
    final operationTypeText = switch (_operationType) {
      OperationType.transfer => 'Transfer',
      OperationType.debin => 'Request DEBIN',
      OperationType.topUp => 'Request Top-Up',
    };
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              operationTypeText,
              style: const TextStyle(
                color: LibraColors.primaryText,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ToggleButtons(
              isSelected: _operationOptions
                  .map((opt) => opt == _operationType)
                  .toList(),
              onPressed: (index) {
                setState(() {
                  _operationType = _operationOptions[index];
                  _destController.clear();
                  _isAlias = true;
                });
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: LibraColors.accentTeal,
              color: LibraColors.secondaryText,
              fillColor: LibraColors.accentTeal.withValues(alpha: 0.2),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Transfer'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('DEBIN'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Top-Up'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_operationType == OperationType.transfer ||
                _operationType == OperationType.debin) ...[
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
                semanticsFieldName: _isAlias ? 'alias' : 'cvu',
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
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _dest =
                          (_operationType == OperationType.transfer ||
                              _operationType == OperationType.debin)
                          ? _destController.text.trim()
                          : '';
                      _stepIndex = 1;
                    });
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
                child: const Text('Continue', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
