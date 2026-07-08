import 'package:share_plus/share_plus.dart';

class ShareService {
  /// Opens the native OS share sheet with the provided URL.
  Future<void> shareLink(String url) async {
    await Share.share(
      'Check this product!\n$url',
      subject: 'Oriflame Product Recommendation',
    );
  }
}
