import 'package:flutter_test/flutter_test.dart';
import 'package:barengkita/models/emergency_contact.dart';
import 'package:barengkita/models/counselor.dart';
import 'package:barengkita/models/resource.dart';

void main() {
  group('EmergencyContact model', () {
    test('emergencyContacts list is not empty', () {
      expect(emergencyContacts, isNotEmpty);
    });

    test('each contact has a name and phone number', () {
      for (final contact in emergencyContacts) {
        expect(contact.name, isNotEmpty);
        expect(contact.phoneNumber, isNotEmpty);
      }
    });

    test('SAPA 129 is available 24 hours', () {
      final sapa = emergencyContacts.firstWhere(
        (c) => c.phoneNumber == '129',
        orElse: () => throw StateError('SAPA 129 not found'),
      );
      expect(sapa.isAvailable24h, isTrue);
    });

    test('at least one contact has isAvailable24h true', () {
      final available24h = emergencyContacts.where((c) => c.isAvailable24h);
      expect(available24h, isNotEmpty);
    });
  });

  group('Counselor model', () {
    test('counselors list is not empty', () {
      expect(counselors, isNotEmpty);
    });

    test('each counselor has an organization name and email', () {
      for (final counselor in counselors) {
        expect(counselor.organizationName, isNotEmpty);
        expect(counselor.contactEmail, isNotEmpty);
      }
    });

    test('each counselor has at least one service', () {
      for (final counselor in counselors) {
        expect(counselor.services, isNotEmpty);
      }
    });

    test('at least one counselor provides online service', () {
      final onlineCounselors = counselors.where((c) => c.isOnline);
      expect(onlineCounselors, isNotEmpty);
    });
  });

  group('Resource model', () {
    test('resources list is not empty', () {
      expect(resources, isNotEmpty);
    });

    test('each resource has a title and content', () {
      for (final resource in resources) {
        expect(resource.title, isNotEmpty);
        expect(resource.content, isNotEmpty);
        expect(resource.summary, isNotEmpty);
      }
    });

    test('categoryLabel returns correct label', () {
      const r = Resource(
        title: 'Test',
        summary: 'Test summary',
        content: 'Test content',
        category: ResourceCategory.legalRights,
      );
      expect(r.categoryLabel, 'Hak Hukum');
    });

    test('all ResourceCategory values have labels', () {
      for (final category in ResourceCategory.values) {
        final r = Resource(
          title: 'Test',
          summary: 'Test',
          content: 'Test',
          category: category,
        );
        expect(r.categoryLabel, isNotEmpty);
      }
    });

    test('resources cover all categories', () {
      final categories = resources.map((r) => r.category).toSet();
      expect(categories.length, greaterThanOrEqualTo(3));
    });
  });
}
