import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/share_controller.dart';

class SmartPostCard extends StatefulWidget {
  const SmartPostCard({super.key});

  @override
  State<SmartPostCard> createState() => _SmartPostCardState();
}

class _SmartPostCardState extends State<SmartPostCard> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final ShareController _shareController = ShareController();

  final List<String> _images = [
    'assets/post1.jpg',
    'assets/post1.jpg', // Placeholder for 2nd image
    'assets/post1.jpg', // Placeholder for 3rd image
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildSocialIcon(dynamic icon, List<Color> gradientColors, String label) {
    return GestureDetector(
      onTap: () => _shareController.onSharePressed(context, label),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))
                ],
              ),
              child: Center(
                child: icon is FaIconData
                    ? FaIcon(icon, color: Colors.white, size: 18)
                    : Icon(icon as IconData, color: Colors.white, size: 18),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 660,
      margin: const EdgeInsets.only(bottom: 24.0),
      // Clip behavior to keep children inside the rounded corners (optional)
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          // 1. BACKGROUND LAYER: Full-size Image Carousel
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal, // Standard carousel horizontal swipe
              itemCount: _images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  _images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          
          // 2. OVERLAY LAYER: Top Left Profile & Title
          Positioned(
            top: 16,
            left: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar with white border
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: const DecorationImage(
                      image: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "Ready to share" Pill
                    GestureDetector(
                      onTap: () => _shareController.onSharePressed(context, 'Ready to share'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE993B4), Color(0xFFC084D1)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Ready to share',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Username / Subtitle
                    const Text(
                      'High-converting in Oriflame Community',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          
          // 3. OVERLAY LAYER: Top Right Pagination Pill
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentPage + 1} of ${_images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 4. OVERLAY LAYER: Middle Right Vertical Dot Indicator
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_images.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? const Color(0xFF6EDDB0) : Colors.white,
                    ),
                  );
                }),
              ),
            ),
          ),

          // 5. OVERLAY LAYER: Bottom Content Area (Music, Caption, Sharing)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Music Recommended Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.music_note, color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Recommended: ',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                              TextSpan(
                                text: 'Unstoppable ',
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text: 'by Sia',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Main Caption Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
                      children: [
                        TextSpan(
                          text: '✨ Experience the elegance of Eclat Amour—a fragrance that captures the essence of romance and sophistication. Let every spritz wrap you in timeless charm and effortless allure. 💖\n',
                        ),
                        TextSpan(
                          text: '#EclatAmour #TimelessElegance\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Use my referral code: UK-AMANDA3012\nUse my referral link: www.oriflame.com/giordani/amada3012',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // New Action Buttons (Copy, Save, Prepare)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      labelStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      avatar: const Icon(Icons.copy, color: Colors.white, size: 14),
                      label: const Text('Copy Caption'),
                      onPressed: () => _shareController.onCopyCaption(
                        context, 
                        '✨ Experience the elegance of Eclat Amour... #EclatAmour Use my referral code: UK-AMANDA3012'
                      ),
                    ),
                    ActionChip(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      labelStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      avatar: const Icon(Icons.bookmark_border, color: Colors.white, size: 14),
                      label: const Text('Save to Profile'),
                      onPressed: () => _shareController.onSaveToProfile(context),
                    ),
                    ActionChip(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      labelStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      avatar: const Icon(Icons.auto_fix_high, color: Colors.white, size: 14),
                      label: const Text('Prepare Content'),
                      onPressed: () => _shareController.onPrepareContent(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Quick Share Row
                Row(
                  children: [
                    const Text(
                      'Quick share to:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildSocialIcon(FontAwesomeIcons.instagram, [const Color(0xFFF58529), const Color(0xFFDD2A7B), const Color(0xFF8134AF)], 'IG Stories'),
                            _buildSocialIcon(FontAwesomeIcons.instagram, [const Color(0xFFF58529), const Color(0xFFDD2A7B), const Color(0xFF8134AF)], 'IG Post'),
                            _buildSocialIcon(FontAwesomeIcons.facebookF, [const Color(0xFF1877F2), const Color(0xFF1877F2)], 'FB Stories'),
                            _buildSocialIcon(FontAwesomeIcons.facebookF, [const Color(0xFF0055FF), const Color(0xFF0055FF)], 'FB Post'),
                            _buildSocialIcon(FontAwesomeIcons.facebookMessenger, [const Color(0xFF00B2FF), const Color(0xFF006AFF)], 'Messenger'),
                            _buildSocialIcon(FontAwesomeIcons.tiktok, [const Color(0xFF000000), const Color(0xFF000000)], 'TikTok'),
                            _buildSocialIcon(FontAwesomeIcons.whatsapp, [const Color(0xFF25D366), const Color(0xFF25D366)], 'WhatsApp'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
