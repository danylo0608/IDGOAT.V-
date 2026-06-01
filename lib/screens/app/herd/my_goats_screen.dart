import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/screens/app/herd/widgets/add_goat_sheet.dart';
import 'package:idgoat/theme/colors.dart';

enum _ViewMode { grid, list }

class MyGoatsScreen extends StatefulWidget {
  const MyGoatsScreen({super.key, required this.onGoatTap});

  final ValueChanged<Goat> onGoatTap;

  @override
  State<MyGoatsScreen> createState() => _MyGoatsScreenState();
}

class _MyGoatsScreenState extends State<MyGoatsScreen> {
  static const _filters = ['Всі', 'Кози', 'Козли', 'Кітні'];

  final List<Goat> _allGoats = [
    const Goat(
      name: 'Сніжинка',
      tagId: 'id-001',
      category: GoatCategory.pregnant,
      breed: 'Англо-нубійська',
      bloodline: '96.5% - American F5+',
      birthYear: 2021,
      birthWeightKg: 3.8,
      litterSize: 2,
      hornType: 'Рогата',
      statusLabel: '(запліднення)',
      countdownDays: 19,
    ),
    const Goat(name: 'Білянка', tagId: 'UKR00123', category: GoatCategory.doe),
    const Goat(name: 'Зоряна', tagId: 'UKR00124', category: GoatCategory.doe),
    const Goat(name: 'Грона', tagId: 'UKR00125', category: GoatCategory.pregnant),
    const Goat(name: 'Вітер', tagId: 'UKR00126', category: GoatCategory.buck),
    const Goat(name: 'Маліна', tagId: 'UKR00127', category: GoatCategory.doe),
    const Goat(name: 'Туман', tagId: 'UKR00128', category: GoatCategory.buck),
    const Goat(name: 'Лада', tagId: 'UKR00129', category: GoatCategory.pregnant),
    const Goat(name: 'Сніжка', tagId: 'UKR00130', category: GoatCategory.doe),
    const Goat(name: 'Буран', tagId: 'UKR00131', category: GoatCategory.buck),
    const Goat(name: 'Ясна', tagId: 'UKR00132', category: GoatCategory.pregnant),
  ];

  void _openAddGoatForm() {
    AddGoatSheet.show(
      context,
      onSubmit: (goat) {
        setState(() => _allGoats.insert(0, goat));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Козу «${goat.name}» додано')),
        );
      },
    );
  }

  final _searchController = TextEditingController();
  int _selectedFilterIndex = 0;
  _ViewMode _viewMode = _ViewMode.grid;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Goat> get _filteredGoats {
    final query = _searchController.text.trim().toLowerCase();
    return _allGoats.where((goat) {
      final matchesFilter = switch (_selectedFilterIndex) {
        0 => true,
        1 => goat.category == GoatCategory.doe,
        2 => goat.category == GoatCategory.buck,
        3 => goat.category == GoatCategory.pregnant,
        _ => true,
      };
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return goat.name.toLowerCase().contains(query) ||
          goat.tagId.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final goats = _filteredGoats;

    return Stack(
      children: [
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Пошук кози...',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isSelected = _selectedFilterIndex == index;
              return FilterChip(
                label: Text(_filters[index]),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedFilterIndex = index),
                backgroundColor: AppColors.cardBackground,
                selectedColor: AppColors.textGold.withOpacity(0.2),
                checkmarkColor: AppColors.textGold,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.textGold : AppColors.textMuted,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
                side: BorderSide(
                  color: isSelected ? AppColors.borderGold : Colors.transparent,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                showCheckmark: false,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Мої кози (45)',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              _buildViewModeButton(
                icon: Icons.grid_view_rounded,
                isActive: _viewMode == _ViewMode.grid,
                onTap: () => setState(() => _viewMode = _ViewMode.grid),
              ),
              const SizedBox(width: 8),
              _buildViewModeButton(
                icon: Icons.view_list_rounded,
                isActive: _viewMode == _ViewMode.list,
                onTap: () => setState(() => _viewMode = _ViewMode.list),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: goats.isEmpty
              ? const Center(
                  child: Text(
                    'Коз не знайдено',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                )
              : _viewMode == _ViewMode.grid
                  ? _buildGrid(goats)
                  : _buildList(goats),
        ),
      ],
    ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: _openAddGoatForm,
            backgroundColor: AppColors.textGold,
            foregroundColor: Colors.black,
            elevation: 4,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: 32),
          ),
        ),
      ],
    );
  }

  Widget _buildViewModeButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isActive
          ? AppColors.textGold.withOpacity(0.15)
          : AppColors.cardBackground,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 22,
            color: isActive ? AppColors.textGold : AppColors.textMuted,
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Goat> goats) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: goats.length,
      itemBuilder: (context, index) => _GoatCard(
        goat: goats[index],
        onTap: () => widget.onGoatTap(goats[index]),
      ),
    );
  }

  Widget _buildList(List<Goat> goats) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
      physics: const BouncingScrollPhysics(),
      itemCount: goats.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _GoatListTile(
        goat: goats[index],
        onTap: () => widget.onGoatTap(goats[index]),
      ),
    );
  }
}

class _GoatCard extends StatelessWidget {
  const _GoatCard({required this.goat, required this.onTap});

  final Goat goat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2321),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.pets,
                  color: AppColors.textGold,
                  size: 48,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Кличка: ${goat.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '#${goat.tagId}',
                  style: const TextStyle(
                    color: AppColors.textGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }
}

class _GoatListTile extends StatelessWidget {
  const _GoatListTile({required this.goat, required this.onTap});

  final Goat goat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
        children: [
          Container(
            width: 100,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2321),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.pets, color: AppColors.textGold, size: 40),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Кличка: ${goat.name}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '#${goat.tagId}',
                    style: const TextStyle(
                      color: AppColors.textGold,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }
}
