import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedContractId;
  String? _selectedCardId;
  final TextEditingController _amountController = TextEditingController();
  bool _isCustomAmount = false;

  final List<Map<String, dynamic>> _contracts = [
    {
      'id': '1',
      'productName': 'Samsung Galaxy S24',
      'contractNumber': 'SH-2024-001',
      'totalAmount': 15000000,
      'paidAmount': 5000000,
      'remainingAmount': 10000000,
      'monthlyPayment': 1250000,
      'nextPaymentDate': DateTime.now().add(const Duration(days: 15)),
      'term': 12,
    },
    {
      'id': '2',
      'productName': 'iPhone 15 Pro',
      'contractNumber': 'SH-2024-002',
      'totalAmount': 20000000,
      'paidAmount': 8000000,
      'remainingAmount': 12000000,
      'monthlyPayment': 1666667,
      'nextPaymentDate': DateTime.now().add(const Duration(days: 10)),
      'term': 12,
    },
  ];

  final List<Map<String, String>> _cards = [
    {
      'id': '1',
      'number': '8600 **** **** 1234',
      'holder': 'JOHN DOE',
      'expiry': '12/25',
    },
    {
      'id': '2',
      'number': '9860 **** **** 5678',
      'holder': 'JOHN DOE',
      'expiry': '03/26',
    },
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat('#,###', 'uz_UZ');
    return '${formatter.format(amount)} so\'m';
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  void _makePayment() {
    if (_selectedContractId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Shartnomani tanlang'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedCardId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Kartani tanlang'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final amount = _isCustomAmount
        ? int.tryParse(_amountController.text.replaceAll(' ', '')) ?? 0
        : _contracts.firstWhere(
            (c) => c['id'] == _selectedContractId)['monthlyPayment'] as int;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Summa noto\'g\'ri'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 60.sp,
                  color: AppColors.success,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'To\'lov muvaffaqiyatli!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _formatMoney(amount),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'Yopish',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To\'lov'),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/svg/chevron-right.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              AppColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contract Selection
            FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shartnomani tanlang',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ..._contracts.map((contract) => _buildContractCard(contract)),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Payment Amount
            if (_selectedContractId != null)
              FadeInUp(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To\'lov summasi',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCustomAmount = false;
                                _amountController.clear();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: !_isCustomAmount
                                    ? AppColors.primary.withOpacity(0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: !_isCustomAmount
                                      ? AppColors.primary
                                      : AppColors.textSecondary
                                          .withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Oylik to\'lov',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    _formatMoney(_contracts.firstWhere((c) =>
                                            c['id'] == _selectedContractId)[
                                        'monthlyPayment'] as int),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCustomAmount = true;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: _isCustomAmount
                                    ? AppColors.primary.withOpacity(0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _isCustomAmount
                                      ? AppColors.primary
                                      : AppColors.textSecondary
                                          .withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Ixtiyoriy',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  SvgPicture.asset(
                                    'assets/icons/svg/edit.svg',
                                    width: 20.w,
                                    height: 20.h,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_isCustomAmount) ...[
                      SizedBox(height: 12.h),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          _MoneyInputFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Summani kiriting',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: SvgPicture.asset(
                              'assets/icons/svg/wallet.svg',
                              width: 20.w,
                              height: 20.h,
                              colorFilter: ColorFilter.mode(
                                AppColors.textSecondary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

            if (_selectedContractId != null) SizedBox(height: 24.h),

            // Card Selection
            if (_selectedContractId != null)
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To\'lov kartasini tanlang',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ..._cards.map((card) => _buildCardOption(card)),
                  ],
                ),
              ),

            SizedBox(height: 32.h),

            // Payment Button
            if (_selectedContractId != null && _selectedCardId != null)
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomButton(
                    text: 'To\'lovni amalga oshirish',
                    onPressed: _makePayment,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractCard(Map<String, dynamic> contract) {
    final isSelected = _selectedContractId == contract['id'];
    final remainingAmount = contract['remainingAmount'] as int;
    final totalAmount = contract['totalAmount'] as int;
    final progress = 1 - (remainingAmount / totalAmount);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedContractId = contract['id'];
          _isCustomAmount = false;
          _amountController.clear();
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.textSecondary.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    contract['productName'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 24.sp,
                  ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              'Shartnoma: ${contract['contractNumber']}',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.background,
              valueColor: AlwaysStoppedAnimation(AppColors.success),
              minHeight: 6.h,
              borderRadius: BorderRadius.circular(3.r),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keyingi to\'lov',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      _formatDate(contract['nextPaymentDate']),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Qolgan',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      _formatMoney(remainingAmount),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardOption(Map<String, String> card) {
    final isSelected = _selectedCardId == card['id'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCardId = card['id'];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : AppColors.textSecondary.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/svg/card.svg',
              width: 32.w,
              height: 32.h,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card['number']!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    card['holder']!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected
                          ? Colors.white.withOpacity(0.8)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}

class _MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final number = int.tryParse(newValue.text.replaceAll(' ', ''));
    if (number == null) {
      return oldValue;
    }

    final formatter = NumberFormat('#,###', 'uz_UZ');
    final formatted = formatter.format(number);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
