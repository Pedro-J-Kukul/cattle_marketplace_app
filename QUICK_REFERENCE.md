# Quick Reference Guide

## Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Configure API Server
- Launch the app
- Tap settings icon on login screen
- Enter IP address and port
- Test connection
- Save settings

### 3. Run the App
```bash
# For development
flutter run

# For Android
flutter run -d android

# For iOS
flutter run -d ios
```

## Common Tasks

### Adding a New Screen
1. Create screen file in `lib/screens/{feature}/`
2. Import required models and services
3. Add route in `lib/main.dart` if needed
4. Navigate using `Navigator.push()` or `Navigator.pushNamed()`

### Adding a New Model
1. Create model file in `lib/models/`
2. Add fields with types
3. Create constructor
4. Add `fromJson()` factory method
5. Add `toJson()` method

### Adding a New Service
1. Create service file in `lib/services/`
2. Import `api_service.dart`
3. Use `ApiService.get/post/put/delete()` methods
4. Handle errors with try-catch
5. Parse responses with model's `fromJson()`

### Checking User Permissions
```dart
import '../../utils/permissions.dart';

// Check if user can manage products
final canManage = Permissions.canManageProducts(userRole);

// Check if user is admin
final isAdmin = Permissions.isAdmin(userRole);

// Check if user is manager or above
final isManagerOrAbove = Permissions.isManagerOrAbove(userRole);
```

### Making API Calls
```dart
import '../../services/api_service.dart';

// GET request
final response = await ApiService.get('/v1/endpoint', includeAuth: true);

// POST request
final response = await ApiService.post(
  '/v1/endpoint',
  {'key': 'value'},
  includeAuth: true,
);

// PUT request
final response = await ApiService.put(
  '/v1/endpoint/1',
  {'key': 'value'},
  includeAuth: true,
);

// DELETE request
final response = await ApiService.delete('/v1/endpoint/1', includeAuth: true);
```

### Storing User Preferences
```dart
import '../../utils/preferences.dart';

// Save auth token
await AppPreferences.saveAuthToken(token);

// Get auth token
final token = await AppPreferences.getAuthToken();

// Save user role
await AppPreferences.saveUserRole('admin');

// Get user role
final role = await AppPreferences.getUserRole();

// Clear all user data
await AppPreferences.clearUserData();
```

### Checking Network Connectivity
```dart
import '../../utils/network_helper.dart';

// Check if device has connectivity
final hasConnection = await NetworkHelper.hasConnectivity();

// Test connection to specific host
final canConnect = await NetworkHelper.testConnection('192.168.1.1', 8080);

// Validate IP address
final isValid = NetworkHelper.isValidIpAddress('192.168.1.1');

// Validate port
final isValidPort = NetworkHelper.isValidPort('8080');
```

## File Structure Reference

```
lib/
├── constants.dart              # App-wide constants
├── main.dart                   # App entry point
├── models/                     # Data models
│   ├── auth.dart              # AuthToken model
│   ├── product.dart           # Product model
│   ├── sale.dart              # Sale model
│   └── user.dart              # User model
├── services/                   # Business logic
│   ├── api_service.dart       # Base API service
│   ├── auth_service.dart      # Authentication
│   ├── product_service.dart   # Product operations
│   ├── sale_service.dart      # Sale operations
│   └── user_service.dart      # User management
├── screens/                    # UI screens
│   ├── auth/
│   │   ├── activation_screen.dart
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── dashboard/
│   │   └── dashboard_screen.dart
│   ├── products/
│   │   ├── product_form_screen.dart
│   │   └── products_screen.dart
│   ├── sales/
│   │   ├── sale_form_screen.dart
│   │   └── sales_screen.dart
│   ├── settings/
│   │   └── settings_screen.dart
│   └── users/
│       └── users_screen.dart
└── utils/                      # Utilities
    ├── network_helper.dart    # Network operations
    ├── permissions.dart       # Role-based access
    └── preferences.dart       # Local storage
```

## API Endpoints Quick Reference

| Operation | Method | Endpoint | Auth Required |
|-----------|--------|----------|---------------|
| Login | POST | `/v1/tokens/authentication` | No |
| Logout | DELETE | `/v1/tokens/authentication` | Yes |
| Register | POST | `/v1/users` | No |
| Activate | POST | `/v1/users/activate` | No |
| List Users | GET | `/v1/users` | Yes (Manager+) |
| Get User | GET | `/v1/users/:id` | Yes |
| Update User | PUT | `/v1/users/:id` | Yes |
| Delete User | DELETE | `/v1/users/:id` | Yes (Admin) |
| List Products | GET | `/v1/products` | Yes |
| Get Product | GET | `/v1/products/:id` | Yes |
| Create Product | POST | `/v1/products` | Yes (Manager+) |
| Update Product | PUT | `/v1/products/:id` | Yes (Manager+) |
| Delete Product | DELETE | `/v1/products/:id` | Yes (Manager+) |
| List Sales | GET | `/v1/sales` | Yes |
| Get Sale | GET | `/v1/sales/:id` | Yes |
| Create Sale | POST | `/v1/sales` | Yes |
| Update Sale | PUT | `/v1/sales/:id` | Yes |
| Delete Sale | DELETE | `/v1/sales/:id` | Yes (Manager+) |

## Role Permissions

| Feature | Staff | Manager | Admin |
|---------|-------|---------|-------|
| View Products | ✅ | ✅ | ✅ |
| Create Products | ❌ | ✅ | ✅ |
| Update Products | ❌ | ✅ | ✅ |
| Delete Products | ❌ | ✅ | ✅ |
| View Sales | ✅ | ✅ | ✅ |
| Create Sales | ✅ | ✅ | ✅ |
| Update Sales | ✅ | ✅ | ✅ |
| Delete Sales | ❌ | ✅ | ✅ |
| View Users | ❌ | ✅ | ✅ |
| Delete Users | ❌ | ❌ | ✅ |

## Troubleshooting

### "Connection refused" error
- Check if backend server is running
- Verify IP address and port in settings
- For Android emulator, use `10.0.2.2` instead of `localhost`
- Test connection in settings screen

### "401 Unauthorized" error
- Token may have expired
- Logout and login again
- Check if user is activated

### "403 Forbidden" error
- User doesn't have permission for this action
- Check user role
- Contact admin for role upgrade

### App crashes on startup
- Clear app data
- Reinstall the app
- Check for Flutter version compatibility

### Products/Sales not loading
- Check network connectivity
- Verify API server is accessible
- Check auth token is valid
- Look at error messages

## Development Tips

1. **Use const constructors** for widgets that don't change
2. **Dispose controllers** in StatefulWidget's dispose method
3. **Handle mounted check** before setState after async operations
4. **Use relative imports** for project files
5. **Add loading states** for all async operations
6. **Validate user input** before submitting
7. **Show meaningful error messages** to users
8. **Test with different roles** to verify permissions
9. **Use connection testing** before saving IP settings
10. **Keep business logic in services**, not in widgets

## Useful Commands

```bash
# Get dependencies
flutter pub get

# Run code analysis
flutter analyze

# Format code
flutter format lib/

# Clean build files
flutter clean

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Run on specific device
flutter run -d device_id

# List devices
flutter devices

# Check Flutter installation
flutter doctor
```

## Contact & Support

For issues or questions:
1. Check the documentation in README.md
2. Review IMPLEMENTATION_SUMMARY.md
3. Check VALIDATION_CHECKLIST.md
4. Review error messages carefully
5. Test API endpoints independently

Happy coding! 🚀
