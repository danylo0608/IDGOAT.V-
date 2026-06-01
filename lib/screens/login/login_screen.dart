import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';
import 'package:idgoat/screens/login/profile_selection_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // 1. Логотип та Назва додатка
              _buildLogoAndTitle(),
              const Spacer(flex: 2),
              // 2. Форма входу / Реєстрація (+ кнопки)
              _buildLoginMethods(),
              const Spacer(flex: 2),
              // 3. Політика та кнопка зареєструватися
              _buildPolicyAndRegister(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // --- 1. IDGOAT (Логотип та назва) ---
  Widget _buildLogoAndTitle() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white12, width: 1),
          ),
          // TODO: Замінити на Image.asset('assets/logo.png')
          child: const Center(
            child: Icon(
              Icons.g_mobiledata,
              color: AppColors.textGold,
              size: 50,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'IDGOAT',
          style: TextStyle(
            color: AppColors.textGold,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'HERITAGE PRECISION',
          style: TextStyle(
            color: AppColors.textWhite.withOpacity(0.6),
            fontSize: 12,
            letterSpacing: 3.0,
          ),
        ),
      ],
    );
  }

  // --- 2. Реєстрація (+ кнопки) ---
  Widget _buildLoginMethods() {
    return Column(
      children: [
        const Text(
          'Увійдіть в IDGOAT',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),

        // Кнопка Google
        SizedBox(
          width: double.infinity,
          height: 60,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.cardBackground,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.g_mobiledata, color: Colors.orange, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Продовжити з Google',
                  style: TextStyle(
                    color: AppColors.textWhite.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Кнопка Telegram
        SizedBox(
          width: double.infinity,
          height: 75,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.telegramButtonBg,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.send, color: AppColors.textGold, size: 24),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Увійти через Telegram Bot',
                      style: TextStyle(
                        color: AppColors.textGold,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '(SMS не потрібно)',
                      style: TextStyle(
                        color: AppColors.textMuted.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 3. Політика та зареєструватися ---
  Widget _buildPolicyAndRegister(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Політика конфіденційності',
            style: TextStyle(
              color: AppColors.textMuted,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 200,
          height: 45,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileSelectionScreen(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.borderGold, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'ЗАРЕЄСТРУВАТИСЯ',
              style: TextStyle(
                color: AppColors.textGold,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
