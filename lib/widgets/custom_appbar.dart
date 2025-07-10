// lib/widgets/custom_appbar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final VoidCallback? onLogout;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.onToggleTheme,
    this.onLogout,
    required List<IconButton> actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          tooltip: isDarkMode ? 'Mode Terang' : 'Mode Gelap',
          onPressed: onToggleTheme,
        ),
        if (onLogout != null)
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: onLogout,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
