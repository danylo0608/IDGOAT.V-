import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';

class ReproductionTab extends StatelessWidget {
  const ReproductionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. ВЕРХНІЙ БЛОК: Поточний статус охоти/запліднення
          _buildCurrentStatusCard(),

          const SizedBox(height: 24),

          // 2. ЗАГОЛОВОК «Архів окотів»
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Архів окотів',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.textGold,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3. СВІТЛА КАРТКА ОКОТУ (Kidding Record)
          _buildKiddingRecordCard(),

          const SizedBox(height: 16),

          // 4. НИЖНІ СТАТИСТИЧНІ КАРТКИ (Генетична чистота та Розмір приплоду)
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  label: 'GENETIC PURITY',
                  value: '98.4%',
                  icon: Icons.account_tree_outlined,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildStatCard(
                  label: 'AVG. LITTER SIZE',
                  value: '2.1',
                  icon: Icons.face_retouching_natural, // Альтернатива смайлику
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // --- 1. ПЛАШКА СТАТУСУ ЗАПЛІДНЕННЯ ---
  Widget _buildCurrentStatusCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.calendar_today, color: Color(0xFFB4C8C1), size: 20),
            SizedBox(width: 8),
            Text(
              'Журнал охот',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.02)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Кругла іконка зі знаком оклику/інформації
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFE4C362), // Приглушений жовтий з макету
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.priority_high,
                  color: Colors.black,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Запліднена',
                          style: TextStyle(
                            color: AppColors.textGold,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Today',
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Expected Kidding Date: 20.08.2024',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.image_aspect_ratio,
                            color: Colors.white38, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'Status: High Precision',
                          style: TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 3. ВЕЛИКА СВІТЛА КАРТКА АРХІВУ ОКОТІВ ---
  Widget _buildKiddingRecordCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3EE), // Світла кремова плашка з макету
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Шапка картки (Дата та кількість дітей)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KIDDING RECORD',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '15.03.2024',
                    style: TextStyle(
                      color: Color(0xFF1C2D27),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEDCBE), // Бежевий овал кількості дітей
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '2 kids',
                  style: TextStyle(
                    color: Color(0xFFC29B53),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(color: Colors.black12, height: 1),
          ),

          // Секція батьків (MOTHER + FATHER)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildParentAvatar('MOTHER'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildParentAvatar('FATHER'),
            ],
          ),

          const SizedBox(height: 16),

          // Секція приплоду (OFFSPRING PORTFOLIO)
          const Center(
            child: Text(
              'OFFSPRING PORTFOLIO',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Горизонтальний ряд козенят
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOffspringMiniCard('ID-042'),
              const SizedBox(width: 8),
              _buildOffspringMiniCard('ID-043'),
              const SizedBox(width: 8),
              // Кнопка додавання нового козеняти (пунктирний квадрат)
              Container(
                width: 50,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black26,
                    style: BorderStyle.solid,
                  ), // Для кастомізації дашу можна використати пакети, але солід теж виглядає чисто
                ),
                child: const Icon(Icons.add, color: Colors.black54, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Помічник для великих круглих батьківських аватарів всередині світлої картки
  Widget _buildParentAvatar(String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Color(0xFFC29B53),
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(Icons.pets, color: Colors.black38, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // Помічник для квадратних карток козенят
  Widget _buildOffspringMiniCard(String id) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            child: Icon(Icons.pets, color: Colors.black12, size: 24),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          id,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // --- 4. УНІВЕРСАЛЬНА КАРТКА НИЖНЬОЇ СТАТИСТИКИ ---
  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.textGold, size: 20),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
