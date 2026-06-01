import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, this.leading});

  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: leading ??
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textMuted),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
      title: const Text(
        'IDGOAT',
        style: TextStyle(
          color: AppColors.textGold,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textMuted),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: AppColors.textGold),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.textMuted),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
