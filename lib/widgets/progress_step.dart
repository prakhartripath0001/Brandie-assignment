import 'package:flutter/material.dart';

class ProgressStep extends StatelessWidget {
  final String title;
  final bool loading;
  final bool completed;

  const ProgressStep({
    super.key,
    required this.title,
    required this.loading,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0), // Spacing between every step
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status Icon
          SizedBox(
            width: 24,
            height: 24,
            child: _buildIcon(),
          ),
          const SizedBox(width: 16),
          // Text
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: loading ? FontWeight.bold : FontWeight.w500,
                color: completed
                    ? Colors.black87
                    : (loading ? Colors.black : Colors.grey[400]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (completed) {
      // State 3: Check Icon
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 24,
      );
    } else if (loading) {
      // State 2: CircularProgressIndicator
      return const CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      );
    } else {
      // State 1: Empty Circle
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!, width: 2),
        ),
      );
    }
  }
}
