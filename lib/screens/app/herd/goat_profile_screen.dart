import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/screens/app/herd/tabs/administration_tab.dart';
import 'package:idgoat/screens/app/herd/tabs/productivity_tab.dart';
import 'package:idgoat/screens/app/herd/tabs/reproduction_tab.dart';
import 'package:idgoat/screens/app/herd/tabs/veterinary_tab.dart';
import 'package:idgoat/theme/colors.dart';

class GoatProfileScreen extends StatelessWidget {
  const GoatProfileScreen({
    super.key,
    required this.goat,
    required this.onBack,
  });

  final Goat goat;
  final VoidCallback onBack;

  // static const _textSoftWhite = Color(0xFFBCBCBC);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          _GoatProfileAppBar(goat: goat, onBack: onBack),
          Expanded(
            child: TabBarView(
              children: [
                AdministrationTab(),
                VeterinaryTab(),
                ProductivityTab(),
                ReproductionTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoatProfileAppBar extends StatelessWidget {
  const _GoatProfileAppBar({required this.goat, required this.onBack});

  final Goat goat;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textMuted),
                onPressed: onBack,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          goat.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF88D49E),
                        size: 18,
                      ),
                    ],
                  ),
                  Text(
                    goat.displayId.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share, color: AppColors.textMuted),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.badge, color: AppColors.textMuted),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: AppColors.textMuted),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
            const TabBar(
              isScrollable: true,
              indicatorColor: AppColors.textGold,
              indicatorWeight: 2,
              labelColor: AppColors.textGold,
              unselectedLabelColor: AppColors.textMuted,
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
              tabs: [
                Tab(text: 'АДМІНІСТРУВАННЯ'),
                Tab(text: 'ВЕТЕРИНАРІЯ'),
                Tab(text: 'ПРОДУКТИВНІСТЬ'),
                Tab(text: 'РЕПРОДУКЦІЯ'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
