import 'package:rentverse/features/rental/domain/entity/rent_references_entity_response.dart';

class RentReferencesResponseModel {
  final List<PropertyTypeModel> propertyTypes;
  final List<ListingTypeModel> listingTypes;
  final List<BillingPeriodModel> billingPeriods;
  final List<AttributeModel> attributes;

  RentReferencesResponseModel({
    required this.propertyTypes,
    required this.listingTypes,
    required this.billingPeriods,
    required this.attributes,
  });

  factory RentReferencesResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final propertyTypes = (data['propertyTypes'] as List<dynamic>? ?? [])
        .map((e) => PropertyTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final listingTypes = (data['listingTypes'] as List<dynamic>? ?? [])
        .map((e) => ListingTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final billingPeriods = (data['billingPeriods'] as List<dynamic>? ?? [])
        .map((e) => BillingPeriodModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final attributes = (data['attributes'] as List<dynamic>? ?? [])
        .map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return RentReferencesResponseModel(
      propertyTypes: propertyTypes,
      listingTypes: listingTypes,
      billingPeriods: billingPeriods,
      attributes: attributes,
    );
  }

  RentReferencesEntity toEntity() {
    return RentReferencesEntity(
      propertyTypes: propertyTypes.map((e) => e.toEntity()).toList(),
      listingTypes: listingTypes.map((e) => e.toEntity()).toList(),
      billingPeriods: billingPeriods.map((e) => e.toEntity()).toList(),
      attributes: attributes.map((e) => e.toEntity()).toList(),
    );
  }
}

class PropertyTypeModel {
  final int id;
  final String slug;
  final String label;

  PropertyTypeModel({
    required this.id,
    required this.slug,
    required this.label,
  });

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) {
    return PropertyTypeModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      slug: json['slug'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }

  PropertyTypeEntity toEntity() =>
      PropertyTypeEntity(id: id, slug: slug, label: label);
}

class ListingTypeModel {
  final int id;
  final String slug;
  final String label;

  ListingTypeModel({required this.id, required this.slug, required this.label});

  factory ListingTypeModel.fromJson(Map<String, dynamic> json) {
    return ListingTypeModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      slug: json['slug'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }

  ListingTypeEntity toEntity() =>
      ListingTypeEntity(id: id, slug: slug, label: label);
}

class BillingPeriodModel {
  final int id;
  final String slug;
  final String label;
  final int durationMonths;

  BillingPeriodModel({
    required this.id,
    required this.slug,
    required this.label,
    required this.durationMonths,
  });

  factory BillingPeriodModel.fromJson(Map<String, dynamic> json) {
    return BillingPeriodModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      slug: json['slug'] as String? ?? '',
      label: json['label'] as String? ?? '',
      durationMonths: (json['durationMonths'] as num?)?.toInt() ?? 0,
    );
  }

  BillingPeriodEntity toEntity() => BillingPeriodEntity(
    id: id,
    slug: slug,
    label: label,
    durationMonths: durationMonths,
  );
}

class AttributeModel {
  final int id;
  final String slug;
  final String label;
  final String dataType;
  final String iconUrl;

  AttributeModel({
    required this.id,
    required this.slug,
    required this.label,
    required this.dataType,
    required this.iconUrl,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      slug: json['slug'] as String? ?? '',
      label: json['label'] as String? ?? '',
      dataType: json['dataType'] as String? ?? '',
      iconUrl: json['iconUrl'] as String? ?? '',
    );
  }

  AttributeEntity toEntity() => AttributeEntity(
    id: id,
    slug: slug,
    label: label,
    dataType: dataType,
    iconUrl: iconUrl,
  );
}
