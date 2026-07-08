import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: double.infinity,
      height: 106,
      child: Row(
        children: [
          // Empty expanded to balance the right icon and keep logo perfectly centered
          const Expanded(child: SizedBox()),
          
          // Centered Text Logo
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ORIFLAME',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
              Text(
                '—--- SWEDEN —---',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          
          // Camera Button on the right
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, size: 22),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  // TODO: Add camera action
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
