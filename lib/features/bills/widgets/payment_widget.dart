import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/user.dart';
import '../../../theme/app_theme.dart';

class PaymentWidget extends ConsumerStatefulWidget {
  const PaymentWidget({
    super.key,
    required this.accountBalance,
    this.onPaymentSuccess,
    this.onPaymentError,
  });

  final AccountBalance accountBalance;
  final Function(double amount, String method)? onPaymentSuccess;
  final Function(String error)? onPaymentError;

  @override
  ConsumerState<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends ConsumerState<PaymentWidget> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  // Removed in-app card form fields per requirements

  PaymentMethodType _selectedPaymentMethod = PaymentMethodType.card;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.accountBalance.currentBalance.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppCard(
        padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                  children: [
                    Icon(Icons.payment, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: AppTheme.spacing8),
                    Text(
                      'Make Payment',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing16),
                if (_isProcessing)
                  _buildProcessingState()
                else
                  _buildPaymentForm(),
              ],
            ),
        );

  Widget _buildProcessingState() => const Center(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing32),
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: AppTheme.spacing16),
              Text('Processing payment...'),
            ],
          ),
        ),
      );

  Widget _buildPaymentForm() => Form(
        key: _formKey,
        child: Column(
          children: [
            _buildAmountSection(),
            const SizedBox(height: AppTheme.spacing16),
            _buildPaymentMethodSection(),
            const SizedBox(height: AppTheme.spacing16),
            // _buildPaymentOptions(),
            const SizedBox(height: AppTheme.spacing16),
            _buildActionButtons(),
          ],
        ),
      );

  Widget _buildAmountSection() => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Amount',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: r'$',
                hintText: '0.00',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter payment amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                if (amount > widget.accountBalance.currentBalance * 2) {
                  return 'Amount cannot exceed twice the current balance';
                }
                return null;
              },
            ),
            const SizedBox(height: AppTheme.spacing8),
            Row(
              children: [
                _buildQuickAmountButton('Past Due', widget.accountBalance.lastPaymentAmount),
                const SizedBox(width: AppTheme.spacing8),
                _buildQuickAmountButton('Full Balance', widget.accountBalance.currentBalance),
              ],
            ),
          ],
        ),
      );

  Widget _buildQuickAmountButton(String label, double? amount) => Expanded(
        child: OutlinedButton(
          onPressed: () {
            if (amount != null) {
              _amountController.text = amount.toStringAsFixed(2);
            }
          },
          child: Text(label),
        ),
      );

  Widget _buildPaymentMethodSection() => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            DropdownButtonFormField<PaymentMethodType>(
              value: _selectedPaymentMethod,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _availableMethods.map((method) => DropdownMenuItem(
                  value: method,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_getPaymentMethodIcon(method), size: 20),
                      const SizedBox(width: AppTheme.spacing8),
                      Flexible(
                        child: Text(
                          _getPaymentMethodLabel(method),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              selectedItemBuilder: (context) => _availableMethods.map((method) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getPaymentMethodIcon(method), size: 20),
                    const SizedBox(width: AppTheme.spacing8),
                    Flexible(
                      child: Text(
                        _getPaymentMethodLabel(method),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                }
              },
            ),
          ],
        ),
      );

  

  Widget _buildActionButtons() => Row(
        children: [
          // Expanded(
          //   child: OutlinedButton(
          //     onPressed: _isProcessing ? null : _cancelPayment,
          //     child: const Text('Cancel'),
          //   ),
          // ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _processPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
              ),
              child: const Text('Make Payment'),
            ),
          ),
        ],
      );

  List<PaymentMethodType> get _availableMethods => const [
        PaymentMethodType.card,
        PaymentMethodType.digiWallet,
        PaymentMethodType.heritageBank,
        PaymentMethodType.atlanticBankCreditCard,
        PaymentMethodType.atlanticBankPersonal,
        PaymentMethodType.belizeBank,
        PaymentMethodType.nationalBank,
      ];

  IconData _getPaymentMethodIcon(PaymentMethodType method) {
    switch (method) {
      case PaymentMethodType.card:
        return Icons.credit_card;
      case PaymentMethodType.digiWallet:
        return Icons.account_balance_wallet;
      case PaymentMethodType.heritageBank:
      case PaymentMethodType.atlanticBankCreditCard:
      case PaymentMethodType.atlanticBankPersonal:
      case PaymentMethodType.belizeBank:
      case PaymentMethodType.nationalBank:
        return Icons.account_balance;
    }
  }

  String _getPaymentMethodLabel(PaymentMethodType method) {
    switch (method) {
      case PaymentMethodType.card:
        return 'Debit/Credit Card';
      case PaymentMethodType.digiWallet:
        return 'DigiWallet';
      case PaymentMethodType.heritageBank:
        return 'Heritage Bank Limited (Web Portal)';
      case PaymentMethodType.atlanticBankCreditCard:
        return 'Atlantic Bank (Web Portal - Credit Card)';
      case PaymentMethodType.atlanticBankPersonal:
        return 'Atlantic Bank (Web Portal - Personal Login)';
      case PaymentMethodType.belizeBank:
        return 'Belize Bank (Portal)';
      case PaymentMethodType.nationalBank:
        return 'National Bank of Belize (Web Portal)';
    }
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      final amount = double.parse(_amountController.text);
      final method = _getPaymentMethodLabel(_selectedPaymentMethod);

      // Simulate success/failure (90% success rate)
      if (DateTime.now().millisecond % 10 < 9) {
        widget.onPaymentSuccess?.call(amount, method);
        _showSuccessDialog(amount, method);
      } else {
        throw Exception('Payment processing failed');
      }
    } catch (e) {
      widget.onPaymentError?.call(e.toString());
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showSuccessDialog(double amount, String method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppTheme.spacing8),
            const Text('Payment Successful'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: \$${amount.toStringAsFixed(2)}'),
            Text('Method: $method'),
            Text('Transaction ID: TXN-${DateTime.now().millisecondsSinceEpoch}'),
            const SizedBox(height: AppTheme.spacing8),
            const Text('Your payment has been processed successfully.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            const SizedBox(width: AppTheme.spacing8),
            const Text('Payment Failed'),
          ],
        ),
        content: Text('Payment could not be processed: $error'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

enum PaymentMethodType {
  card,
  digiWallet,
  heritageBank,
  atlanticBankCreditCard,
  atlanticBankPersonal,
  belizeBank,
  nationalBank,
}
