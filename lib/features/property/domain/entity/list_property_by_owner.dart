import 'package:rentverse/features/property/domain/entity/list_property_entity.dart';

class ListPropertyByOwnerEntity {
  final List<OwnerPropertyEntity> properties;
  final MetaEntity meta;

  const ListPropertyByOwnerEntity({
    required this.properties,
    required this.meta,
  });
}

class OwnerPropertyEntity {
  final String id;
  final String title;
  final String address;
  final String city;
  final int price;
  final String currency;
  final bool isVerified;
  final String? image;
  final String type;
  final OwnerPropertyStatsEntity stats;
  final DateTime? createdAt;

  const OwnerPropertyEntity({
    required this.id,
    required this.title,
    required this.address,
    required this.city,
    required this.price,
    required this.currency,
    required this.isVerified,
    required this.image,
    required this.type,
    required this.stats,
    required this.createdAt,
  });
}

class OwnerPropertyStatsEntity {
  final int totalBookings;

  const OwnerPropertyStatsEntity({required this.totalBookings});
}
