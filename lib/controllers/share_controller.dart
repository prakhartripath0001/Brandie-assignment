import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  /// Generic handler for actions that need a loading dialog
  Future<void> _handleGenericAction({
    required BuildContext context,
    required String loadingMessage,
    required String successMessage,
    Future<void> Function()? action,
  }) async {
    if (_isSharing) return;
    _isSharing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GeneratingLinkDialog(message: loadingMessage);
      },
    );

    try {
      await Future.delayed(const Duration(seconds: 2));
      if (action != null) {
        await action();
      }

      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(successMessage)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action failed: $e')),
        );
      }
    } finally {
      _isSharing = false;
    }
  }

  Future<void> onCopyCaption(BuildContext context, String captionText) async {
    await _handleGenericAction(
      context: context,
      loadingMessage: 'Copying the caption to clipboard...',
      successMessage: 'Caption copied to clipboard!',
      action: () async {
        await Clipboard.setData(ClipboardData(text: captionText));
      },
    );
  }

  Future<void> onSaveToProfile(BuildContext context) async {
    await _handleGenericAction(
      context: context,
      loadingMessage: 'Saving to your profile...',
      successMessage: 'Successfully saved to profile!',
    );
  }

  Future<void> onPrepareContent(BuildContext context) async {
    await _handleGenericAction(
      context: context,
      loadingMessage: 'Preparing the content for social media...',
      successMessage: 'Content is ready for social media!',
    );
  }
}
