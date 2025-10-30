import 'package:bel247_web/data/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Model Tests', () {
    late User testUser;
    late Address testAddress;
    late UserPreferences testPreferences;

    setUp(() {
      testAddress = const Address(
        street: '123 Main St',
        city: 'Anytown',
        state: 'CA',
        zipCode: '12345',
        country: 'USA',
      );

      testPreferences = const UserPreferences(
        notifications: NotificationSettings(
          email: true,
          sms: false,
          push: true,
        ),
        currency: 'USD',
        timezone: 'America/New_York',
        language: 'en',
      );

      testUser = User(
        id: 'user-123',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        phone: '+1234567890',
        address: testAddress,
        accountNumber: 'ACC-123456',
        serviceAddress: testAddress,
        meterNumber: 'MTR-789',
        tariffPlan: 'Standard',
        connectionDate: DateTime(2020, 1, 1),
        lastLogin: DateTime.now(),
        preferences: testPreferences,
        accountBalance: AccountBalance(
          currentBalance: 150,
          lastPaymentDate: DateTime(2023, 12, 1),
          lastPaymentAmount: 200,
          nextDueDate: DateTime(2024, 1, 15),
          paymentMethod: 'Credit Card',
        ),
        usageSummary: const UsageSummary(
          currentMonth: UsagePeriod(
            kwh: 450,
            cost: 67.50,
            averageDaily: 15,
          ),
          lastMonth: UsagePeriod(
            kwh: 420,
            cost: 63,
            averageDaily: 14,
          ),
          yearToDate: UsagePeriod(
            kwh: 5400,
            cost: 810,
            averageDaily: 15,
          ),
        ),
      );
    });

    group('Serialization/Deserialization', () {
      test('should serialize to JSON correctly', () {
        final json = testUser.toJson();
        
        expect(json['id'], equals('user-123'));
        expect(json['email'], equals('test@example.com'));
        expect(json['firstName'], equals('John'));
        expect(json['lastName'], equals('Doe'));
        expect(json['phone'], equals('+1234567890'));
        expect(json['accountNumber'], equals('ACC-123456'));
        expect(json['meterNumber'], equals('MTR-789'));
        expect(json['tariffPlan'], equals('Standard'));
      });

      test('should deserialize from JSON correctly', () {
        final json = testUser.toJson();
        final userFromJson = User.fromJson(json);
        
        expect(userFromJson.id, equals(testUser.id));
        expect(userFromJson.email, equals(testUser.email));
        expect(userFromJson.firstName, equals(testUser.firstName));
        expect(userFromJson.lastName, equals(testUser.lastName));
        expect(userFromJson.phone, equals(testUser.phone));
        expect(userFromJson.accountNumber, equals(testUser.accountNumber));
        expect(userFromJson.meterNumber, equals(testUser.meterNumber));
        expect(userFromJson.tariffPlan, equals(testUser.tariffPlan));
      });

      test('should handle null values in optional fields', () {
        final userWithNulls = testUser.copyWith(
          createdAt: null,
          updatedAt: null,
        );
        
        final json = userWithNulls.toJson();
        final userFromJson = User.fromJson(json);
        
        expect(userFromJson.createdAt, isNull);
        expect(userFromJson.updatedAt, isNull);
      });
    });

    group('Validation', () {
      test('should validate successfully with valid data', () {
        final result = testUser.validate();
        
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should fail validation with invalid email', () {
        final invalidUser = testUser.copyWith(email: 'invalid-email');
        final result = invalidUser.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Email: Please enter a valid email address'));
      });

      test('should fail validation with invalid phone', () {
        final invalidUser = testUser.copyWith(phone: 'invalid-phone');
        final result = invalidUser.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Phone: Please enter a valid phone number'));
      });

      test('should fail validation with empty required fields', () {
        final invalidUser = testUser.copyWith(
          firstName: '',
          lastName: '',
          accountNumber: '',
          meterNumber: '',
        );
        final result = invalidUser.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('First name is required'));
        expect(result.errors, contains('Last name is required'));
        expect(result.errors, contains('Account number is required'));
        expect(result.errors, contains('Meter number is required'));
      });

      test('should validate address fields', () {
        const invalidAddress = Address(
          street: '',
          city: '',
          state: '',
          zipCode: '',
          country: '',
        );
        final invalidUser = testUser.copyWith(address: invalidAddress);
        final result = invalidUser.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, anyOf(contains('Address: Street is required')));
      });
    });

    group('Computed Properties', () {
      test('should return correct display name', () {
        expect(testUser.displayName, equals('John Doe'));
      });

      test('should return correct initials', () {
        expect(testUser.initials, equals('JD'));
      });

      test('should return correct initials for single character names', () {
        final singleCharUser = testUser.copyWith(firstName: 'J', lastName: 'D');
        expect(singleCharUser.initials, equals('JD'));
      });

      test('should check if user is active', () {
        expect(testUser.isActive, isTrue);
        
        final inactiveUser = testUser.copyWith(status: UserStatus.inactive);
        expect(inactiveUser.isActive, isFalse);
      });

      test('should check if user has payment methods', () {
        expect(testUser.hasPaymentMethods, isFalse);
        
        final userWithPayment = testUser.copyWith(
          paymentMethods: [
            PaymentMethod(
              id: 'pm-1',
              type: 'credit_card',
              lastFourDigits: '1234',
              cardholderName: 'John Doe',
              expiryDate: DateTime(2025, 12, 31),
            ),
          ],
        );
        expect(userWithPayment.hasPaymentMethods, isTrue);
      });

      test('should return primary payment method', () {
        final primaryPayment = PaymentMethod(
          id: 'pm-1',
          type: 'credit_card',
          lastFourDigits: '1234',
          cardholderName: 'John Doe',
          expiryDate: DateTime(2025, 12, 31),
          isPrimary: true,
        );
        
        final secondaryPayment = PaymentMethod(
          id: 'pm-2',
          type: 'debit_card',
          lastFourDigits: '5678',
          cardholderName: 'John Doe',
          expiryDate: DateTime(2025, 12, 31),
          isPrimary: false,
        );
        
        final userWithPayments = testUser.copyWith(
          paymentMethods: [secondaryPayment, primaryPayment],
        );
        
        expect(userWithPayments.primaryPaymentMethod, equals(primaryPayment));
      });

      test('should return full address string', () {
        expect(testUser.fullAddress, equals('123 Main St, Anytown, CA 12345, USA'));
        expect(testUser.fullServiceAddress, equals('123 Main St, Anytown, CA 12345, USA'));
      });
    });

    group('Edge Cases', () {
      test('should handle empty string names', () {
        final userWithEmptyNames = testUser.copyWith(
          firstName: '',
          lastName: '',
        );
        
        expect(userWithEmptyNames.displayName, equals(' '));
        expect(userWithEmptyNames.initials, equals(''));
      });

      test('should handle special characters in names', () {
        final userWithSpecialChars = testUser.copyWith(
          firstName: 'José',
          lastName: 'García-López',
        );
        
        expect(userWithSpecialChars.displayName, equals('José García-López'));
        expect(userWithSpecialChars.initials, equals('JG'));
      });

      test('should handle very long names', () {
        final longName = 'A' * 1000;
        final userWithLongName = testUser.copyWith(firstName: longName);
        
        expect(userWithLongName.displayName, startsWith(longName));
      });
    });

    group('Default Values', () {
      test('should use default values for optional fields', () {
        final minimalUser = User(
          id: 'minimal-user',
          email: 'minimal@example.com',
          firstName: 'Min',
          lastName: 'User',
          phone: '+1234567890',
          address: testAddress,
          accountNumber: 'ACC-MIN',
          serviceAddress: testAddress,
          meterNumber: 'MTR-MIN',
          tariffPlan: 'Basic',
          connectionDate: DateTime.now(),
          lastLogin: DateTime.now(),
          preferences: testPreferences,
          accountBalance: AccountBalance(
            currentBalance: 0,
            lastPaymentDate: DateTime.now(),
            lastPaymentAmount: 0,
            nextDueDate: DateTime.now(),
            paymentMethod: 'None',
          ),
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
        );
        
        expect(minimalUser.profile, equals(const UserProfile()));
        expect(minimalUser.settings, equals(const UserSettings()));
        expect(minimalUser.security, equals(const UserSecurity()));
        expect(minimalUser.paymentMethods, isEmpty);
        expect(minimalUser.notificationHistory, isEmpty);
        expect(minimalUser.status, equals(UserStatus.active));
        expect(minimalUser.createdAt, isNull);
        expect(minimalUser.updatedAt, isNull);
      });
    });
  });

  group('Address Model Tests', () {
    test('should validate address correctly', () {
      const validAddress = Address(
        street: '123 Main St',
        city: 'Anytown',
        state: 'CA',
        zipCode: '12345',
        country: 'USA',
      );
      
      final errors = validAddress.validate();
      expect(errors, isEmpty);
    });

    test('should fail validation with empty fields', () {
      const invalidAddress = Address(
        street: '',
        city: '',
        state: '',
        zipCode: '',
        country: '',
      );
      
      final errors = invalidAddress.validate();
      expect(errors, contains('Street is required'));
      expect(errors, contains('City is required'));
      expect(errors, contains('State is required'));
      expect(errors, contains('ZIP code is required'));
      expect(errors, contains('Country is required'));
    });

    test('should return correct string representation', () {
      const address = Address(
        street: '123 Main St',
        city: 'Anytown',
        state: 'CA',
        zipCode: '12345',
        country: 'USA',
      );
      
      expect(address.toString(), equals('123 Main St, Anytown, CA 12345, USA'));
    });
  });

  group('PaymentMethod Model Tests', () {
    test('should check if payment method is expired', () {
      final expiredPayment = PaymentMethod(
        id: 'pm-1',
        type: 'credit_card',
        lastFourDigits: '1234',
        cardholderName: 'John Doe',
        expiryDate: DateTime(2020, 1, 1),
      );
      
      expect(expiredPayment.isExpired, isTrue);
      
      final validPayment = PaymentMethod(
        id: 'pm-2',
        type: 'credit_card',
        lastFourDigits: '5678',
        cardholderName: 'John Doe',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
      );
      
      expect(validPayment.isExpired, isFalse);
    });

    test('should return masked card number', () {
      final payment = PaymentMethod(
        id: 'pm-1',
        type: 'credit_card',
        lastFourDigits: '1234',
        cardholderName: 'John Doe',
        expiryDate: DateTime(2025, 12, 31),
      );
      
      expect(payment.maskedNumber, equals('**** **** **** 1234'));
    });

    test('should return expiry string', () {
      final payment = PaymentMethod(
        id: 'pm-1',
        type: 'credit_card',
        lastFourDigits: '1234',
        cardholderName: 'John Doe',
        expiryDate: DateTime(2025, 12, 31),
      );
      
      expect(payment.expiryString, equals('12/25'));
    });
  });

  group('UserProfile Model Tests', () {
    test('should serialize and deserialize correctly', () {
      final profile = UserProfile(
        profilePicture: 'https://example.com/avatar.jpg',
        bio: 'Software developer',
        dateOfBirth: DateTime(1990, 1, 1),
        gender: 'Male',
        occupation: 'Developer',
        company: 'Tech Corp',
        website: 'https://johndoe.com',
        interests: ['Technology', 'Sports'],
        socialLinks: ['https://linkedin.com/in/johndoe'],
      );
      
      final json = profile.toJson();
      final profileFromJson = UserProfile.fromJson(json);
      
      expect(profileFromJson.profilePicture, equals(profile.profilePicture));
      expect(profileFromJson.bio, equals(profile.bio));
      expect(profileFromJson.interests, equals(profile.interests));
      expect(profileFromJson.socialLinks, equals(profile.socialLinks));
    });
  });

  group('UserSettings Model Tests', () {
    test('should use default values', () {
      const settings = UserSettings();
      
      expect(settings.darkMode, isTrue);
      expect(settings.autoRefresh, isTrue);
      expect(settings.refreshIntervalMinutes, equals(30));
      expect(settings.showNotifications, isTrue);
      expect(settings.language, equals('en'));
      expect(settings.currency, equals('USD'));
      expect(settings.timezone, equals('America/New_York'));
    });
  });

  group('UserSecurity Model Tests', () {
    test('should use default values', () {
      const security = UserSecurity();
      
      expect(security.twoFactorEnabled, isFalse);
      expect(security.biometricEnabled, isFalse);
      expect(security.trustedDevices, isEmpty);
      expect(security.failedLoginAttempts, equals(0));
      expect(security.accountLocked, isFalse);
    });
  });

  group('NotificationHistory Model Tests', () {
    test('should serialize and deserialize correctly', () {
      final notification = NotificationHistory(
        id: 'notif-1',
        type: 'billReminder',
        title: 'Bill Due Soon',
        message: 'Your bill is due in 3 days',
        timestamp: DateTime(2024, 1, 1),
        isRead: false,
        isImportant: true,
        metadata: {'billId': 'bill-123'},
      );
      
      final json = notification.toJson();
      final notificationFromJson = NotificationHistory.fromJson(json);
      
      expect(notificationFromJson.id, equals(notification.id));
      expect(notificationFromJson.type, equals(notification.type));
      expect(notificationFromJson.title, equals(notification.title));
      expect(notificationFromJson.message, equals(notification.message));
      expect(notificationFromJson.isRead, equals(notification.isRead));
      expect(notificationFromJson.isImportant, equals(notification.isImportant));
      expect(notificationFromJson.metadata, equals(notification.metadata));
    });
  });
}
