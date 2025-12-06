import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/role/tenant/presentation/cubit/search_and_sort/cubit.dart';
import 'package:rentverse/role/tenant/presentation/cubit/search_and_sort/state.dart';

class SearchAndSortWidgetForProperty extends StatefulWidget {
  final List<String> categories;
  final void Function(String query, String category)? onChanged;

  const SearchAndSortWidgetForProperty({
    super.key,
    this.categories = const ['All', 'House', 'Apartment', 'Townhouse'],
    this.onChanged,
  });

  @override
  State<SearchAndSortWidgetForProperty> createState() =>
      _SearchAndSortWidgetForPropertyState();
}

class _SearchAndSortWidgetForPropertyState
    extends State<SearchAndSortWidgetForProperty> {
  bool showFilter = false;
  int selectedBedroom = 0; // 0 = any
  double sizeValue = 500;
  double priceValue = 5000000;
  final Set<String> selectedFeatures = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchAndSortCubit(),
      child: BlocBuilder<SearchAndSortCubit, SearchAndSortState>(
        builder: (context, state) {
          final cubit = context.read<SearchAndSortCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _SearchField(
                      initialValue: state.query,
                      onChanged: (q) {
                        cubit.updateQuery(q);
                        widget.onChanged?.call(q, state.selectedType);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => setState(() => showFilter = !showFilter),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00C2FF), Color(0xFF00E0C3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.tune, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final c in widget.categories) ...[
                      _FilterChipItem(
                        label: c,
                        selected: state.selectedType == c,
                        onTap: () {
                          cubit.selectType(c);
                          widget.onChanged?.call(state.query, c);
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: showFilter
                    ? Padding(
                        key: const ValueKey('filters'),
                        padding: const EdgeInsets.only(top: 14),
                        child: _FilterSheet(
                          selectedBedroom: selectedBedroom,
                          onBedroomSelected: (v) =>
                              setState(() => selectedBedroom = v),
                          sizeValue: sizeValue,
                          onSizeChanged: (v) => setState(() => sizeValue = v),
                          priceValue: priceValue,
                          onPriceChanged: (v) => setState(() => priceValue = v),
                          selectedFeatures: selectedFeatures,
                          onToggleFeature: (f) {
                            setState(() {
                              if (selectedFeatures.contains(f)) {
                                selectedFeatures.remove(f);
                              } else {
                                selectedFeatures.add(f);
                              }
                            });
                          },
                          onReset: () {
                            setState(() {
                              selectedBedroom = 0;
                              sizeValue = 500;
                              priceValue = 5000000;
                              selectedFeatures.clear();
                            });
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.initialValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.teal, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final int selectedBedroom;
  final ValueChanged<int> onBedroomSelected;
  final double sizeValue;
  final ValueChanged<double> onSizeChanged;
  final double priceValue;
  final ValueChanged<double> onPriceChanged;
  final Set<String> selectedFeatures;
  final ValueChanged<String> onToggleFeature;
  final VoidCallback onReset;

  const _FilterSheet({
    required this.selectedBedroom,
    required this.onBedroomSelected,
    required this.sizeValue,
    required this.onSizeChanged,
    required this.priceValue,
    required this.onPriceChanged,
    required this.selectedFeatures,
    required this.onToggleFeature,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final featureOptions = ['Kitchen', 'Wifi', 'Swimming Pool', 'TV', 'Washer'];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Text(
            'Location',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.location_on, color: Colors.teal, size: 18),
                SizedBox(width: 8),
                Text(
                  'Kuala Lumpur, Malaysia',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text('Bedrooms', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final bed in [0, 1, 2, 3, 4, 5])
                _pill(
                  label: bed == 0 ? 'Any' : '$bed',
                  selected: selectedBedroom == bed,
                  onTap: () => onBedroomSelected(bed),
                ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Size (sqft)',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Slider(
            value: sizeValue,
            min: 200,
            max: 2000,
            divisions: 18,
            activeColor: Colors.teal,
            label: '${sizeValue.toStringAsFixed(0)} sqft',
            onChanged: onSizeChanged,
          ),
          const SizedBox(height: 6),
          const Text(
            'Price Range',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Slider(
            value: priceValue,
            min: 1000000,
            max: 20000000,
            divisions: 19,
            activeColor: Colors.teal,
            label: 'Rp ${priceValue.toStringAsFixed(0)}',
            onChanged: onPriceChanged,
          ),
          const SizedBox(height: 10),
          const Text('Features', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final f in featureOptions)
                _pill(
                  label: f,
                  selected: selectedFeatures.contains(f),
                  onTap: () => onToggleFeature(f),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReset,
                  child: const Text('Reset Filter'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('Apply Filter'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.teal : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChipItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? null : Colors.white,
          gradient: selected
              ? const LinearGradient(
                  colors: [Color(0xFF00C2FF), Color(0xFF00E0C3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (selected)
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.teal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
