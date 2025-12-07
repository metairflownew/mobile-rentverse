import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/core/services/service_locator.dart';
import 'package:rentverse/features/property/domain/entity/list_property_entity.dart';
import 'package:rentverse/role/tenant/presentation/cubit/booking/cubit.dart';
import 'package:rentverse/role/tenant/presentation/cubit/booking/state.dart';

class BookingPropertyPage extends StatelessWidget {
  const BookingPropertyPage({super.key, required this.property});

  final PropertyEntity property;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(sl(), sl())..loadBillingPeriods(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Booking'), centerTitle: true),
        body: SafeArea(
          child: BlocConsumer<BookingCubit, BookingState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));
              }
              if (state.result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.result!.message ?? 'Booking created'),
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<BookingCubit>();
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${property.city}, ${property.country}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Rp${property.price}',
                            style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Billing Period',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          if (state.isBillingPeriodsLoading)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          else if (state.billingPeriods.isEmpty)
                            const Text('Billing period belum tersedia')
                          else
                            Wrap(
                              spacing: 8,
                              children: state.billingPeriods
                                  .map(
                                    (period) => _PeriodChip(
                                      label:
                                          '${period.label} (${period.durationMonths} bln)',
                                      selected:
                                          state.billingPeriodId == period.id,
                                      onTap: () =>
                                          cubit.setBillingPeriod(period.id),
                                    ),
                                  )
                                  .toList(),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Date',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDate(state.startDate),
                                style: const TextStyle(fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final now = DateTime.now();
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: state.startDate.isAfter(now)
                                        ? state.startDate
                                        : now,
                                    firstDate: now,
                                    lastDate: DateTime(now.year + 3),
                                  );
                                  if (picked != null) {
                                    cubit.setStartDate(picked);
                                  }
                                },
                                child: const Text('Pilih tanggal'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            state.isLoading ||
                                state.isBillingPeriodsLoading ||
                                state.billingPeriods.isEmpty
                            ? null
                            : () async {
                                await cubit.submit(property.id);
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Kirim Booking',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (state.result != null)
                      _Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Booking Created',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 6),
                            Text('Booking ID: ${state.result!.bookingId}'),
                            Text('Invoice ID: ${state.result!.invoiceId}'),
                            Text('Status: ${state.result!.status}'),
                            Text('Amount: Rp${state.result!.amount}'),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: Colors.teal.withOpacity(0.2),
      labelStyle: TextStyle(
        color: selected ? Colors.teal.shade800 : Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: selected ? Colors.teal : Colors.grey.shade300),
      ),
    );
  }
}
