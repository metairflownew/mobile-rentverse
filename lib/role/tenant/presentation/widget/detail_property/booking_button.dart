//lib/role/tenant/presentation/widget/detail_property/booking_button.dart

import 'package:flutter/material.dart';
import 'package:rentverse/common/colors/custom_color.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({super.key, required this.price, this.onTap});

  final String price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final formattedPrice = _formatPrice(price);

    // Bungkus dengan Container agar punya background putih & shadow
    // Serta padding bawah untuk safe area (secara manual atau via SafeArea)
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -4), // Shadow ke atas
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min, // PENTING: Agar tidak expand
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monthly Price',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                formattedPrice,
                style: const TextStyle(
                  color: appPrimaryColor,
                  fontSize: 18, // Sedikit diperbesar
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),

              // TOMBOL UTAMA (ElevatedButton dengan Gradient)
              Container(
                width: double.infinity,
                height: 50, // Tinggi fix biar gagah
                decoration: BoxDecoration(
                  gradient: customLinearGradient, // Gradient di sini
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // Transparan agar gradient terlihat
                    shadowColor:
                        Colors.transparent, // Hilangkan shadow bawaan button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return raw.isNotEmpty ? raw : 'Rp 0';

    final buffer = StringBuffer();
    int count = 0;
    for (int i = digits.length - 1; i >= 0; i--) {
      buffer.write(digits[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    final reversed = buffer.toString().split('').reversed.join();
    return 'Rp $reversed';
  }
}
