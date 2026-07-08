import 'package:flutter/material.dart';

class SubNavigationRow extends StatelessWidget {
  const SubNavigationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      color: Colors.white,
      child: Column(
        children: [
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NavItem(title: 'Smart Post', isSelected: true),
                  NavItem(title: 'Library', isSelected: false),
                  NavItem(title: 'Communities', isSelected: false),
                  NavItem(title: 'Share&Win', isSelected: false),
                ],
              ),
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final String title;
  final bool isSelected;

  const NavItem({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click, // Show pointer cursor on hover
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
          color: _isHovered
              ? Colors.green
              : (widget.isSelected ? Colors.black : Colors.grey[600]),
        ),
      ),
    );
  }
}
