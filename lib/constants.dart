// File: lib/constants.dart

// API configuration constants
// Note: IP address is now managed through AppPreferences
// This file maintains backward compatibility but the app
// should use AppPreferences.getApiBaseUrl() for dynamic configuration

// Default values (can be overridden in settings)
const String defaultIpAddress = '127.0.0.1';
const String defaultPort = '8080';

