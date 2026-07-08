import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/share_service.dart';
import '../widgets/generating_link_dialog.dart';

class ShareController {
  final ApiService _apiService = ApiService();
  final ShareService _shareService = ShareService();
  bool _isSharing = false;

  /// Orchestrates the entire share flow
  Future<void> onSharePressed(BuildContext context, String platformLabel) async {
    // Prevent multiple concurrent share requests
    if (_isSharing) return;
    _isSharing = true;

    // 1. Show Loading Dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return const GeneratingLinkDialog();
      },
    );

    try {
      // 2. Call Backend API to generate the link
      final shareUrl = await _apiService.generateShareLink(
        userId: '123',
        productId: '456',
      );

      // 3. Close the Loading Dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // 4. Open Native Share Sheet
      await _shareService.shareLink(shareUrl);
      
    } catch (e) {
      // Handle API failures gracefully
      if (context.mounted) {
        Navigator.of(context).pop(); // Close dialog on error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate link: $e')),
        );
      }
    } finally {
      _isSharing = false;
    }
  }
}
