class RentReferencesEntity {
  final List<PropertyTypeEntity> propertyTypes;
  final List<ListingTypeEntity> listingTypes;
  final List<BillingPeriodEntity> billingPeriods;
  final List<AttributeEntity> attributes;

  const RentReferencesEntity({
    required this.propertyTypes,
    required this.listingTypes,
    required this.billingPeriods,
    required this.attributes,
  });
}

class PropertyTypeEntity {
  final int id;
  final String slug;
  final String label;

  const PropertyTypeEntity({
    required this.id,
    required this.slug,
    required this.label,
  });
}

class ListingTypeEntity {
  final int id;
  final String slug;
  final String label;

  const ListingTypeEntity({
    required this.id,
    required this.slug,
    required this.label,
  });
}

class BillingPeriodEntity {
  final int id;
  final String slug;
  final String label;
  final int durationMonths;

  const BillingPeriodEntity({
    required this.id,
    required this.slug,
    required this.label,
    required this.durationMonths,
  });
}

class AttributeEntity {
  final int id;
  final String slug;
  final String label;
  final String dataType;
  final String iconUrl;

  const AttributeEntity({
    required this.id,
    required this.slug,
    required this.label,
    required this.dataType,
    required this.iconUrl,
  });
}
