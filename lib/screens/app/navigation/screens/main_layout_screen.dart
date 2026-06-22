import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/herd/herd_screen.dart';
import 'package:idgoat/screens/app/home/home_screen.dart';
import 'package:idgoat/screens/app/market/market_screen.dart';
import 'package:idgoat/screens/app/profile/profile_screen.dart';
import 'package:idgoat/theme/colors.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final _herdKey = GlobalKey<HerdScreenState>();
  int _currentIndex = 0;
  bool _isMyYardOpen = false;

  static const _tabs = <_NavTab>[
    _NavTab(label: 'Головна', icon: Icons.home_outlined, activeIcon: Icons.home),
    _NavTab(
      label: 'Стадо',
      iconAsset: 'assets/icon/my_goats.png',
      activeIconAsset: 'assets/icon/my_goats.png',
    ),
    _NavTab(
      label: 'Ринок',
      iconAsset: 'assets/icon/animal_market.png',
      activeIconAsset: 'assets/icon/animal_market.png',
    ),
    _NavTab(
      label: 'Профіль',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  void _openMyYard() => setState(() => _isMyYardOpen = true);

  void _closeMyYard() => setState(() => _isMyYardOpen = false);

  void _openMyGoats() {
    setState(() {
      _isMyYardOpen = false;
      _currentIndex = 1;
    });
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      _herdKey.currentState?.resetToList();
    }
    setState(() {
      _isMyYardOpen = false;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final noTabActive = _isMyYardOpen;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            showMyYard: _isMyYardOpen,
            onOpenMyYard: _openMyYard,
            onCloseMyYard: _closeMyYard,
            onOpenMyGoats: _openMyGoats,
          ),
          HerdScreen(key: _herdKey),
          const MarketScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.cardBackground,
        selectedItemColor:
            noTabActive ? AppColors.textMuted : AppColors.textGold,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: noTabActive ? FontWeight.normal : FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          for (final tab in _tabs)
            BottomNavigationBarItem(
              icon: tab.iconAsset != null
                  ? Image.asset(
                      tab.iconAsset!,
                      width: 32,
                      height: 32,
                    )
                  : Icon(tab.icon),
              activeIcon: tab.activeIconAsset != null
                  ? Image.asset(
                      tab.activeIconAsset!,
                      width: 32,
                      height: 32,
                    )
                  : Icon(noTabActive ? tab.icon : tab.activeIcon),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}

class _NavTab {
  const _NavTab({
    required this.label,
    this.icon,
    this.activeIcon,
    this.iconAsset,
    this.activeIconAsset,
  });

  final String label;
  final IconData? icon;
  final IconData? activeIcon;
  final String? iconAsset;
  final String? activeIconAsset;
}
