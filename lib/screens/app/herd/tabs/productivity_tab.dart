import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';

class ProductivityTab extends StatefulWidget {
  const ProductivityTab({super.key});

  @override
  State<ProductivityTab> createState() => _ProductivityTabState();
}

class _ProductivityTabState extends State<ProductivityTab> {
  String _activeSubTab = 'WEIGHT'; // WEIGHT, YIELD, MILK ANALYSIS

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopStatRow(),
          const SizedBox(height: 16),
          _buildSubTabSwitcher(),
          const SizedBox(height: 24),
          if (_activeSubTab == 'MILK ANALYSIS') ...[
            _buildMilkAnalysisData(),
            const SizedBox(height: 24),
            _buildMilkAnalysisChart(),
          ] else if (_activeSubTab == 'YIELD') ...[
            _buildMilkProductionChart(),
          ] else ...[
            _buildWeightGrowthChart(),
          ],
          const SizedBox(height: 24),
          _buildRecentActivity(),
          const SizedBox(height: 32),
          _buildStopLactationButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStopLactationButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.stop_circle_outlined, size: 20),
        label: const Text(
          'Зупинка лактації / (Запуск)',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildTopStatRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.scale, color: AppColors.textGold, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    '64.5',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  const Text('KG', style: TextStyle(color: AppColors.textGold, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 4),
              Container(height: 2, color: AppColors.textGold, width: 60),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.opacity, color: AppColors.textGold, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    '2.1',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  const Text('L', style: TextStyle(color: AppColors.textGold, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 4),
              Container(height: 2, color: AppColors.textGold, width: 60),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubTabSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildSubTabButton('WEIGHT'),
          _buildSubTabButton('YIELD'),
          _buildSubTabButton('MILK ANALYSIS'),
        ],
      ),
    );
  }

  Widget _buildSubTabButton(String label) {
    final isSelected = _activeSubTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeSubTab = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMilkAnalysisData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.opacity, color: AppColors.textGold, size: 18),
                SizedBox(width: 8),
                Text(
                  'Milk Analysis Data',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.textGold, size: 20),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildAnalysisCounter('FAT', '00.0', 'F')),
            const SizedBox(width: 12),
            Expanded(child: _buildAnalysisCounter('PROTEIN', '00.0', 'P')),
            const SizedBox(width: 12),
            Expanded(child: _buildAnalysisCounter('LACTOSE', '00.0', 'L')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildAnalysisCounter('SNF', '00.0', 'SNF')),
            const SizedBox(width: 12),
            Expanded(child: _buildAnalysisCounter('pH', '--', 'pH')),
            const SizedBox(width: 12),
            Expanded(child: _buildAnalysisCounter('CONDUCTIVITY', 'mS', 'C')),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalysisCounter(String label, String value, String short) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.opacity, color: AppColors.textGold, size: 10),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: AppColors.textGold, shape: BoxShape.circle),
                child: Text(short, style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
              ),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const Icon(Icons.add, color: AppColors.textGold, size: 14),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMilkAnalysisChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trends',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          height: 180,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: CustomPaint(painter: _MultiLineChartPainter()),
        ),
      ],
    );
  }

  Widget _buildWeightGrowthChart() {
    const barHeights = <double>[30, 42, 40, 52, 48, 65, 75, 90];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('WEIGHT GROWTH', style: TextStyle(color: Colors.black45, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('+2.4kg', style: TextStyle(color: Color(0xFF1C2D27), fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Text('avg', style: TextStyle(color: Colors.black38, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Icon(Icons.trending_up, color: Color(0xFF1C2D27), size: 22),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(barHeights.length, (index) {
                final opacity = 0.2 + (index * 0.1);
                return Container(
                  width: 32,
                  height: barHeights[index],
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2D27).withOpacity(opacity > 1.0 ? 1.0 : opacity),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilkProductionChart() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.02)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MILK PRODUCTION', style: TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('3.8L', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Text('peak', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Icon(Icons.equalizer, color: AppColors.textGold, size: 22),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(height: 80, width: double.infinity, child: CustomPaint(painter: _LineChartPainter())),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildActivityItem(
          title: 'Morning Milk Yield',
          subtitle: 'Дата',
          time: 'OCT 24, 07:15 AM',
          value: '2.1 L',
          icon: Icons.opacity,
          isGoldValue: true,
        ),
        const SizedBox(height: 12),
        _buildMilkAnalysisActivityItem(),
        const SizedBox(height: 12),
        _buildActivityItem(
          title: 'Weight Check',
          subtitle: 'Дата',
          time: 'OCT 23, 05:00 PM',
          value: '64.5 KG',
          icon: Icons.scale,
          isGoldValue: false,
        ),
      ],
    );
  }

  Widget _buildMilkAnalysisActivityItem() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
            child: const Icon(Icons.biotech_outlined, color: AppColors.textGold, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Milk Analysis Done', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text('Дата', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    const SizedBox(width: 8),
                    const Text('OCT 24, 10:15 AM', style: TextStyle(color: Colors.white30, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildMiniIndicator('F'),
              const SizedBox(width: 4),
              _buildMiniIndicator('P'),
              const SizedBox(width: 4),
              _buildMiniIndicator('C'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniIndicator(String label) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(color: AppColors.textGold, shape: BoxShape.circle),
      child: Center(child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String subtitle,
    required String time,
    required String value,
    required IconData icon,
    required bool isGoldValue,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, color: isGoldValue ? AppColors.textGold : AppColors.textMuted, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    const SizedBox(width: 8),
                    Text(time, style: const TextStyle(color: Colors.white30, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          Text(value, style: TextStyle(color: isGoldValue ? AppColors.textGold : Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()..color = AppColors.textGold..style = PaintingStyle.stroke..strokeWidth = 3.0;
    final paintGradient = Paint()..style = PaintingStyle.fill..shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.textGold.withOpacity(0.15), AppColors.textGold.withOpacity(0.0)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path()..moveTo(0, size.height * 0.85)..cubicTo(size.width * 0.3, size.height * 0.85, size.width * 0.4, size.height * 0.3, size.width, size.height * 0.2);
    final pathGradient = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(pathGradient, paintGradient);
    canvas.drawPath(path, paintLine);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MultiLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawPath(canvas, size, [0.8, 0.6, 0.7, 0.4, 0.5, 0.3], AppColors.textGold, 3.0);
    _drawPath(canvas, size, [0.6, 0.7, 0.5, 0.6, 0.4, 0.5], Colors.white.withOpacity(0.5), 2.0);
    _drawPath(canvas, size, [0.4, 0.3, 0.4, 0.2, 0.3, 0.1], Colors.white.withOpacity(0.2), 1.5);
  }

  void _drawPath(Canvas canvas, Size size, List<double> points, Color color, double width) {
    final paint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = width;
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = size.width * (i / (points.length - 1));
      final y = size.height * points[i];
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
