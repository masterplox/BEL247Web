/// Centralized asset paths for all mock data files
/// 
/// This file contains all asset paths used by mock repositories and services.
/// Update paths here to change them across the entire application.
class MockAssetPaths {
  MockAssetPaths._(); // Private constructor to prevent instantiation

  // Base path for all mock data assets
  static const String _basePath = 'assets/data';

  // Individual asset file paths
  static const String appData = '$_basePath/mock_app_data.json';
  static const String bills = '$_basePath/mock_bills.json';
  static const String consumption = '$_basePath/mock_consumption.json';
  static const String energyPrices = '$_basePath/mock_energy_prices.json';
  static const String user = '$_basePath/mock_user.json';
}

