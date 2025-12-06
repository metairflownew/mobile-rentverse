//lib/role/tenant/presentation/pages/property/detail_property.dart

import 'package:flutter/material.dart';
import 'package:rentverse/features/property/domain/entity/list_property_entity.dart';
import 'package:rentverse/role/tenant/presentation/widget/detail_property/amenities_widget.dart';
import 'package:rentverse/role/tenant/presentation/widget/detail_property/accessorise_widget.dart';
import 'package:rentverse/role/tenant/presentation/widget/detail_property/image_tile.dart';
import 'package:rentverse/role/tenant/presentation/widget/detail_property/owner_contact.dart';
import 'package:rentverse/role/tenant/presentation/widget/detail_property/booking_button.dart';

class DetailProperty extends StatelessWidget {
  const DetailProperty({super.key, required this.property});

  final PropertyEntity property;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            property.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageTile(images: property.images),
              AccessoriseWidget(attributes: property.attributes),
              const SizedBox(height: 10),
              OwnerContact(
                landlordId: property.landlordId,
                ownerName: _extractOwnerName(property),
                avatarUrl: _extractOwnerAvatar(property),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      property.description,
                      style: const TextStyle(fontSize: 13, height: 1.4),
                    ),
                    AmenitiesWidget(amenities: property.amenities),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        bottomNavigationBar: BookingButton(price: property.price),
      ),
    );
  }
}

String? _extractOwnerName(PropertyEntity property) {
  final meta = property.metadata ?? {};
  final byKey = meta['landlordName'] ?? meta['ownerName'];
  if (byKey is String && byKey.trim().isNotEmpty) return byKey.trim();
  return null;
}

String? _extractOwnerAvatar(PropertyEntity property) {
  final meta = property.metadata ?? {};
  final avatar = meta['landlordAvatar'] ?? meta['ownerAvatar'];
  if (avatar is String && avatar.trim().isNotEmpty) return avatar.trim();
  return null;
}
