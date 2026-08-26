/// Masks account-holder contact values for display.
///
/// Full phone numbers and emails stay off the screen. The backend often
/// repeats the raw contact in API `message` fields; do not show those.
class ContactMasking {
  ContactMasking._();

  static String maskPhone(String phone) {
    if (phone.length <= 2) return phone;
    final last2 = phone.substring(phone.length - 2);
    return '••••••$last2';
  }

  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final local = parts[0];
    final domain = parts[1];
    final visible = local.length <= 2 ? local : local.substring(0, 2);
    return '$visible***@$domain';
  }
}
