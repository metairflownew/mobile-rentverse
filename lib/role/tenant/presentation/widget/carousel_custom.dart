import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/banner/cubit.dart';
import '../cubit/banner/state.dart';

/// Stateless carousel powered by BannerCubit.
class CarouselCustom extends StatelessWidget {
  const CarouselCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BannerCubit(),
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          final cubit = context.read<BannerCubit>();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider.builder(
                itemCount: state.images.length,
                itemBuilder: (context, index, realIndex) {
                  final imagePath = state.images[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  onPageChanged: (index, reason) {
                    cubit.onPageChanged(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
