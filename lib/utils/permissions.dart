// File: lib/utils/permissions.dart

class Permissions {
  // Role constants
  static const String roleAdmin = 'admin';
  static const String roleManager = 'manager';
  static const String roleStaff = 'staff';

  // Check if user is admin
  static bool isAdmin(String role) {
    return role.toLowerCase() == roleAdmin;
  }

  // Check if user is manager or above
  static bool isManagerOrAbove(String role) {
    final lowerRole = role.toLowerCase();
    return lowerRole == roleAdmin || lowerRole == roleManager;
  }

  // Check if user can manage users
  static bool canManageUsers(String role) {
    return isManagerOrAbove(role);
  }

  // Check if user can manage products
  static bool canManageProducts(String role) {
    return isManagerOrAbove(role);
  }

  // Check if user can view sales
  static bool canViewSales(String role) {
    return true; // All users can view sales
  }

  // Check if user can create sales
  static bool canCreateSales(String role) {
    return true; // All users can create sales
  }

  // Check if user can delete sales
  static bool canDeleteSales(String role) {
    return isManagerOrAbove(role);
  }

  // Check if user can view reports
  static bool canViewReports(String role) {
    return isManagerOrAbove(role);
  }
}
