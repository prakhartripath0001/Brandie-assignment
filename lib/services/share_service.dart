import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> shareLink(String url) async {
    await Share.share(
      'Check this product!\n$url',
      subject: 'Oriflame Product Recommendation',
    );
  }
}
