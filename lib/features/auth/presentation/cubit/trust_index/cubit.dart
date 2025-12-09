import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/common/bloc/auth/auth_state.dart';
import 'package:rentverse/features/auth/domain/entity/user_entity.dart';
import 'package:rentverse/features/auth/presentation/cubit/trust_index/state.dart';

class TrustIndexCubit extends Cubit<TrustIndexState> {
  TrustIndexCubit() : super(const TrustIndexState());

  void loadFromAuthState(AuthState authState) {
    if (authState is! Authenticated) return;

    final UserEntity user = authState.user;
    // Role-aware scoring: tenant uses TTI, landlord uses LRS. If both roles exist, prefer tenant TTI unless it's missing.
    final double score;
    if (user.isTenant) {
      score = user.tenantProfile?.ttiScore ?? 0;
    } else if (user.isLandlord) {
      score = user.landlordProfile?.lrsScore ?? 0;
    } else {
      score = 0;
    }

    developer.log(
      'TrustIndexCubit computed score=$score (isTenant=${user.isTenant}, isLandlord=${user.isLandlord}, tti=${user.tenantProfile?.ttiScore}, lrs=${user.landlordProfile?.lrsScore})',
      name: 'TrustIndex',
    );

    // Placeholder review stats; can be replaced when API available.
    const double avgRating = 4.5;
    const int totalReviews = 7;
    final reviews = _mockReviews();

    emit(
      state.copyWith(
        trustScore: score,
        rating: avgRating,
        reviewCount: totalReviews,
        reviews: reviews,
        isLoading: false,
        resetError: true,
      ),
    );
  }

  List<TrustReview> _mockReviews() {
    return const [
      TrustReview(
        reviewerName: 'Jackson',
        rating: 4.5,
        propertyTitle: 'Joane Residence',
        city: 'Kuala Lumpur',
        priceLabel: 'Rp1.000.000/mon',
        comment:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        imageUrl:
            'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=60',
      ),
      TrustReview(
        reviewerName: 'Jackson',
        rating: 4.5,
        propertyTitle: 'Joane Residence',
        city: 'Kuala Lumpur',
        priceLabel: 'Rp1.000.000/mon',
        comment:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        imageUrl:
            'https://images.unsplash.com/photo-1493809842364-78817add7ffb?auto=format&fit=crop&w=800&q=60',
      ),
    ];
  }
}
