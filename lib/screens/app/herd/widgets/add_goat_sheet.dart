import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/theme/colors.dart';

class AddGoatSheet extends StatefulWidget {
  const AddGoatSheet({super.key, required this.onSubmit});

  final ValueChanged<Goat> onSubmit;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<Goat> onSubmit,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddGoatSheet(onSubmit: onSubmit),
    );
  }

  @override
  State<AddGoatSheet> createState() => _AddGoatSheetState();
}

class _AddGoatSheetState extends State<AddGoatSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _breedController = TextEditingController();
  final _darController = TextEditingController();
  final _birthYearController = TextEditingController();
  final _birthWeightController = TextEditingController();
  final _litterSizeController = TextEditingController();

  String? _hornType;

  static const _hornTypes = [
    'Безрогі',
    'Рогаті',
    'Короткорогі',
  ];

  @override
  void dispose() {
    _nicknameController.dispose();
    _breedController.dispose();
    _darController.dispose();
    _birthYearController.dispose();
    _birthWeightController.dispose();
    _litterSizeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_hornType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Оберіть тип рогів')),
      );
      return;
    }

    final dar = _darController.text.trim();
    final tagId = dar.isNotEmpty
        ? dar.replaceAll(' ', '').toUpperCase()
        : 'UKR${DateTime.now().millisecondsSinceEpoch % 100000}';

    widget.onSubmit(
      Goat(
        name: _nicknameController.text.trim(),
        tagId: tagId,
        category: GoatCategory.doe,
        breed: _breedController.text.trim(),
        darNumber: dar,
        birthYear: int.tryParse(_birthYearController.text.trim()),
        birthWeightKg: double.tryParse(
          _birthWeightController.text.trim().replaceAll(',', '.'),
        ),
        litterSize: int.tryParse(_litterSizeController.text.trim()),
        hornType: _hornType!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
            top: BorderSide(color: AppColors.borderGold),
            left: BorderSide(color: AppColors.borderGold),
            right: BorderSide(color: AppColors.borderGold),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Додати козу',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildField(
                        label: 'Кличка',
                        controller: _nicknameController,
                        hint: 'Сніжинка id-001',
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Вкажіть кличку' : null,
                      ),
                      _buildField(
                        label: 'Порода',
                        controller: _breedController,
                        hint: 'Англо-нубійська',
                      ),
                      _buildField(
                        label: 'Номер ДАР',
                        controller: _darController,
                        hint: 'Офіційний номер державного реєстру',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              label: 'Рік народження',
                              controller: _birthYearController,
                              hint: '2024',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildField(
                              label: 'Вага при народженні (кг)',
                              controller: _birthWeightController,
                              hint: '3.5',
                              keyboardType: const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[\d.,]'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              label: 'Кількість у заплоді',
                              controller: _litterSizeController,
                              hint: '2',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: _buildHornTypeDropdown()),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textGold,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'ЗБЕРЕГТИ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.textMuted.withValues(alpha: 0.7),
                fontSize: 14,
              ),
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderGold),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHornTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Тип рогів',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _hornType,
            hint: const Text(
              'Оберіть',
              style: TextStyle(color: AppColors.textMuted, fontSize: 14),
            ),
            dropdownColor: AppColors.cardBackground,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            iconEnabledColor: AppColors.textMuted,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            ),
            items: _hornTypes
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _hornType = value),
          ),
        ],
      ),
    );
  }
}
