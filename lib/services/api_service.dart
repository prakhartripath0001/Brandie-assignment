import 'dart:async';

class ApiService {
  /// Simulates a backend API call to generate a personalized share link.
  Future<String> generateShareLink({
    required String userId,
    required String productId,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate API response
    return 'https://yourapp.com/r/ABCD1234';
  }
}
