import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Шапка меню з інформацією про користувача (бонус для краси)
            _buildDrawerHeader(),
            
            const Divider(color: AppColors.borderGold, thickness: 0.5),

            // Список пунктів меню (твої розділи)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                children: [
                  _buildDrawerItem(
                    icon: Icons.settings,
                    title: 'Налаштування аккаунта або ферми',
                    onTap: () => _showPlaceholderDialog(context, 'Налаштування аккаунта або ферми'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.credit_card,
                    title: 'Історія транзакцій / Деталі Premium',
                    // iconColor: AppColors.textGold, // Підсвітимо золотим, бо пов'язано з Преміумом
                    onTap: () => _showPlaceholderDialog(context, 'Історія транзакцій чи деталі підписки "Premium"'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.help_outline,
                    title: 'Технічна підтримка / Довідка',
                    onTap: () => _showPlaceholderDialog(context, 'Технічна підтримка / Довідка'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_outline,
                    title: 'Про додаток (правила, політика)',
                    onTap: () => _showPlaceholderDialog(context, 'Про додаток (правила, політика конфіденційності)'),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white10),

            // Кнопка виходу в самому низу
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildDrawerItem(
                icon: Icons.logout,
                title: 'Вихід з профілю (Log out)',
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                onTap: () => _showPlaceholderDialog(context, 'Вихід з профілю (Log out)'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Віджет для заголовка бургер-меню
  Widget _buildDrawerHeader() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.cardBackground,
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Мирослав Кравченко',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'ID: IDG-MYROSLAV',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Елемент списку (пункт меню)
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppColors.textMuted,
    Color textColor = Colors.white,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 15),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white10, size: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }

  // Функція показу заглушки (Dialog)
  void _showPlaceholderDialog(BuildContext context, String title) {
    // Спочатку закриваємо сам Drawer, щоб він не висів на фоні
    Navigator.pop(context); 

    // Показуємо діалогове вікно-заглушку
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.borderGold),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Цей розділ знаходиться в розробці',
          style: TextStyle(color: AppColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ЗРОЗУМІЛО', style: TextStyle(color: AppColors.textGold)),
          ),
        ],
      ),
    );
  }
}