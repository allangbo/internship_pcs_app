// ignore: constant_identifier_names
enum UserRole { STUDENT, TEACHER, COMPANY }

extension UserRoleExtension on UserRole {
  String get caption {
    switch (this) {
      case UserRole.STUDENT:
        return 'Estudante';
      case UserRole.TEACHER:
        return 'Professor';
      case UserRole.COMPANY:
        return 'Empresa';
      default:
        return '';
    }
  }
}
