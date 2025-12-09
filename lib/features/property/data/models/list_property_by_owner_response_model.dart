import 'package:rentverse/features/property/domain/entity/list_property_by_owner.dart';
import 'package:rentverse/features/property/domain/entity/list_property_entity.dart';

class ListPropertyByOwnerResponseModel {
  final String? status;
  final String? message;
  final MetaModel meta;
  final List<OwnerPropertyModel> data;

  const ListPropertyByOwnerResponseModel({
    required this.status,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory ListPropertyByOwnerResponseModel.fromJson(Map<String, dynamic> json) {
    final rawMeta = json['meta'] as Map<String, dynamic>? ?? {};
    final rawList = json['data'] as List<dynamic>? ?? [];
    return ListPropertyByOwnerResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      meta: MetaModel.fromJson(rawMeta),
      data: rawList
          .map((e) => OwnerPropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  ListPropertyByOwnerEntity toEntity() {
    return ListPropertyByOwnerEntity(
      properties: data.map((e) => e.toEntity()).toList(),
      meta: meta.toEntity(),
    );
  }
}

class MetaModel {
  final int total;
  final int limit;
  final String? nextCursor;
  final bool hasMore;

  const MetaModel({
    required this.total,
    required this.limit,
    required this.nextCursor,
    required this.hasMore,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      total: (json['total'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  MetaEntity toEntity() {
    return MetaEntity(
      total: total,
      limit: limit,
      nextCursor: nextCursor,
      hasMore: hasMore,
    );
  }
}

class OwnerPropertyModel {
  final String id;
  final String title;
  final String address;
  final String city;
  final int price;
  final String currency;
  final bool isVerified;
  final String? image;
  final String type;
  final OwnerPropertyStatsModel stats;
  final DateTime? createdAt;

  const OwnerPropertyModel({
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

  factory OwnerPropertyModel.fromJson(Map<String, dynamic> json) {
    return OwnerPropertyModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
      image: json['image'] as String?,
      type: json['type'] as String? ?? '',
      stats: OwnerPropertyStatsModel.fromJson(
        json['stats'] as Map<String, dynamic>? ?? {},
      ),
      createdAt: _parseDate(json['createdAt'] as String?),
    );
  }

  OwnerPropertyEntity toEntity() {
    return OwnerPropertyEntity(
      id: id,
      title: title,
      address: address,
      city: city,
      price: price,
      currency: currency,
      isVerified: isVerified,
      image: image,
      type: type,
      stats: stats.toEntity(),
      createdAt: createdAt,
    );
  }
}

class OwnerPropertyStatsModel {
  final int totalBookings;

  const OwnerPropertyStatsModel({required this.totalBookings});

  factory OwnerPropertyStatsModel.fromJson(Map<String, dynamic> json) {
    return OwnerPropertyStatsModel(
      totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
    );
  }

  OwnerPropertyStatsEntity toEntity() {
    return OwnerPropertyStatsEntity(totalBookings: totalBookings);
  }
}

DateTime? _parseDate(String? raw) {
  if (raw == null) return null;
  try {
    return DateTime.parse(raw);
  } catch (_) {
    return null;
  }
}
