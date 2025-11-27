# Sales Management App

A Flutter application for managing sales, products, and users with seamless integration to a Sales API backend.

## Features

### Authentication
- User registration with email verification
- Account activation via token
- Secure login with JWT authentication
- Role-based access control (Admin, Manager, Staff)

### Sales Management
- Record sales transactions
- View sales history
- Track total sales revenue
- Add notes to sales records

### Product Management
- Create, read, update, and delete products
- Track inventory levels
- Set product prices and categories
- Stock quantity management

### User Management (Admin/Manager)
- View all users
- Manage user accounts
- Role-based permissions
- User deletion (admin only)

### Settings
- Flexible API server configuration
- IP address and port customization
- Connection testing
- Quick presets for common configurations
  - Localhost (127.0.0.1:8080)
  - Network IP (192.168.x.x:8080)
  - Android Emulator (10.0.2.2:8080)

## Architecture

### Models
- **User**: Manages user data with role-based fields
- **Product**: Handles product information and inventory
- **Sale**: Records sales transactions
- **AuthToken**: Manages authentication tokens

### Services
- **AuthService**: Handles login, logout, registration, and activation
- **UserService**: Manages user CRUD operations
- **ProductService**: Handles product management
- **SaleService**: Manages sales operations
- **ApiService**: Base service for HTTP requests

### Utilities
- **AppPreferences**: Manages local storage (IP config, auth tokens, user data)
- **NetworkHelper**: Provides network connectivity and validation utilities
- **Permissions**: Role-based access control logic

### Screens
- **Auth**: Login, signup, and activation screens
- **Dashboard**: Main overview with quick access to features
- **Products**: Product listing and management
- **Sales**: Sales recording and history
- **Users**: User management (admin/manager)
- **Settings**: API configuration

## API Integration

### Endpoints
- `POST /v1/tokens/authentication` - User login
- `DELETE /v1/tokens/authentication` - User logout
- `POST /v1/users` - User registration
- `POST /v1/users/activate` - Account activation
- `GET /v1/users` - List users
- `GET /v1/users/:id` - Get user details
- `PUT /v1/users/:id` - Update user
- `DELETE /v1/users/:id` - Delete user
- `GET /v1/products` - List products
- `GET /v1/products/:id` - Get product details
- `POST /v1/products` - Create product
- `PUT /v1/products/:id` - Update product
- `DELETE /v1/products/:id` - Delete product
- `GET /v1/sales` - List sales
- `GET /v1/sales/:id` - Get sale details
- `POST /v1/sales` - Create sale
- `PUT /v1/sales/:id` - Update sale
- `DELETE /v1/sales/:id` - Delete sale

## Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK
- Sales API backend running

### Installation

1. Clone the repository
```bash
git clone https://github.com/Pedro-J-Kukul/cattle_marketplace_app.git
cd cattle_marketplace_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

### Configuration

#### First-time Setup
1. Launch the app
2. Tap the settings icon on the login screen
3. Configure your API server IP and port
4. Test the connection
5. Save settings

#### Common Configurations
- **Local Development**: `127.0.0.1:8080`
- **Network Testing**: `192.168.x.x:8080` (replace with your network IP)
- **Android Emulator**: `10.0.2.2:8080` (points to host machine)

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0                    # HTTP client for API requests
  shared_preferences: ^2.2.2      # Local storage for settings
  connectivity_plus: ^5.0.2       # Network connectivity checking

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0           # Linting rules
```

## Role-Based Access Control

### Staff
- View products
- Create sales
- View sales history

### Manager
- All staff permissions
- Create/update/delete products
- View all users
- Delete sales

### Admin
- All manager permissions
- Delete users
- Full system access

## Development

### Project Structure
```
lib/
├── constants.dart              # App constants
├── main.dart                   # App entry point
├── models/                     # Data models
│   ├── user.dart
│   ├── auth.dart
│   ├── product.dart
│   └── sale.dart
├── services/                   # Business logic
│   ├── api_service.dart
│   ├── auth_service.dart
│   ├── user_service.dart
│   ├── product_service.dart
│   └── sale_service.dart
├── screens/                    # UI screens
│   ├── auth/
│   ├── dashboard/
│   ├── products/
│   ├── sales/
│   ├── users/
│   └── settings/
└── utils/                      # Utilities
    ├── preferences.dart
    ├── network_helper.dart
    └── permissions.dart
```

### Code Quality
- Follow Dart/Flutter style guidelines
- Use Material Design components
- Implement proper error handling
- Add loading states for async operations

## Troubleshooting

### Cannot connect to server
1. Verify server is running
2. Check IP address and port configuration
3. Use connection test in settings
4. For Android emulator, use `10.0.2.2` instead of `localhost`

### Login fails
1. Verify user is activated (check email for activation token)
2. Check API endpoint configuration
3. Ensure server is accessible

### Permission denied
- Check user role
- Some features require manager or admin role
- Contact administrator for role upgrade

## License

This project is part of a learning/development exercise.
