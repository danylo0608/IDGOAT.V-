import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/theme/colors.dart';
import 'package:intl/intl.dart';

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

  // Controllers
  final _nicknameController = TextEditingController();
  final _breederController = TextEditingController();
  final _ownerController = TextEditingController();
  final _darController = TextEditingController();
  final _electronicIdController = TextEditingController();
  final _currentWeightController = TextEditingController();
  final _litterSizeController = TextEditingController();
  final _birthWeightController = TextEditingController();

  // State variables
  bool _isDoe = true;
  bool _isOwnerBreeder = false;
  String? _reproductiveStatus;
  String? _hornType;
  String? _litterComposition;
  DateTime _birthDate = DateTime.now();
  final List<String> _selectedPhysiologicalStatuses = [];
  
  // Breed constructor state
  final List<Map<String, dynamic>> _breeds = [
    {'name': 'Англо-нубійська', 'purity': 100.0}
  ];

  void _addBreed() {
    setState(() {
      _breeds.add({'name': 'Нова порода', 'purity': 0.0});
    });
  }

  void _updateBreedPurity(int index, double purity) {
    setState(() {
      _breeds[index]['purity'] = purity;
    });
  }

  static const _hornTypes = ['Рогата', 'Комола', 'Обезрожена'];
  static const _litterCompositions = ['Одностатеві', 'Різностатеві'];

  static const _reproductiveStatusesDoe = [
    'Репродуктивна',
    'Стерилізована'
  ];

  static const _reproductiveStatusesBuck = [
    'Репродуктивний',
    'Кастрат',
  ];

  static const _physiologicalStatuses = [
    'Запліднена (Pregnant)',
    'Лактація (In Milk)',
    'Полювання (In Heat)',
    'Абортована'
  ];

  @override
  void dispose() {
    _nicknameController.dispose();
    _breederController.dispose();
    _ownerController.dispose();
    _darController.dispose();
    _electronicIdController.dispose();
    _currentWeightController.dispose();
    _litterSizeController.dispose();
    _birthWeightController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final tagId = 'ID-${DateTime.now().millisecondsSinceEpoch % 1000000}';
    
    final breedString = _breeds.map((b) => '${b['name']} ${b['purity']}%').join(', ');
    final bloodline = _breeds.length == 1 ? '${_breeds[0]['purity']}%' : 'Змішана';

    widget.onSubmit(
      Goat(
        name: _nicknameController.text.trim(),
        tagId: tagId,
        category: _isDoe ? GoatCategory.doe : GoatCategory.buck,
        breed: breedString,
        bloodline: bloodline,
        darNumber: _darController.text.trim(),
        birthDate: _birthDate,
        birthYear: _birthDate.year,
        currentWeightKg: double.tryParse(_currentWeightController.text.trim().replaceAll(',', '.')),
        birthWeightKg: double.tryParse(_birthWeightController.text.trim().replaceAll(',', '.')),
        litterSize: int.tryParse(_litterSizeController.text.trim()),
        litterComposition: _litterComposition,
        hornType: _hornType,
        breeder: _breederController.text.trim(),
        owner: _isOwnerBreeder ? _breederController.text.trim() : _ownerController.text.trim(),
        isDoe: _isDoe,
        reproductiveStatus: _reproductiveStatus,
        physiologicalStatus: _selectedPhysiologicalStatuses,
        electronicId: _electronicIdController.text.trim(),
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.textGold,
              onPrimary: Colors.black,
              surface: AppColors.cardBackground,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
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
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPhotoPlaceholder(),
                      const SizedBox(height: 24),
                      
                      _buildSectionTitle('ОСНОВНА ІНФОРМАЦІЯ'),
                      _buildField(
                        label: 'Кличка тварини',
                        controller: _nicknameController,
                        hint: 'Введіть ім\'я',
                        isRequired: true,
                        validator: (v) => v?.isEmpty ?? true ? 'Обов\'язково' : null,
                      ),
                      
                      _buildReadOnlyField(
                        label: 'Системний ID номер',
                        value: 'Генерується автоматично',
                        isRequired: true,
                      ),

                      _buildOwnerField(),

                      _buildIsBreederCheckbox(),

                      _buildField(
                        label: 'Заводчик',
                        controller: _breederController,
                        hint: 'Назва господарства',
                        isRequired: true,
                        validator: (v) => v?.isEmpty ?? true ? 'Обов\'язково' : null,
                      ),

                      _buildGenderToggle(),

                      _buildDropdown(
                        label: 'Репродуктивний статус',
                        value: _reproductiveStatus,
                        items: _isDoe ? _reproductiveStatusesDoe : _reproductiveStatusesBuck,
                        isRequired: true,
                        onChanged: (v) => setState(() => _reproductiveStatus = v),
                      ),

                      _buildBreedConstructor(),

                      if (_isDoe && (_reproductiveStatus == 'Дійне стадо' || _reproductiveStatus == 'Сухостійна'))
                        _buildPhysiologicalStatusCheckboxes(),

                      

                      const SizedBox(height: 16),
                      _buildSectionTitle('ДОДАТКОВІ ДАНІ'),
                      
                      _buildField(
                        label: 'Номер ДАР (Державний аграрний реєстр)',
                        controller: _darController,
                        hint: 'UA XXXXXXXX',
                        isRequired: false,
                      ),

                      _buildField(
                        label: 'Електронний ідентифікатор',
                        controller: _electronicIdController,
                        hint: 'Номер чіпу або бирки',
                      ),

                      _buildDatePickerField(),

                      _buildField(
                        label: 'Поточна вага (кг)',
                        controller: _currentWeightController,
                        hint: '0.0',
                        isRequired: true,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))],
                      ),

                      const SizedBox(height: 16),
                      _buildSectionTitle('ПЕРВИННІ ДАНІ'),

                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              label: 'Кількість у окоті',
                              controller: _litterSizeController,
                              hint: '1',
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDropdown(
                              label: 'Склад окоту',
                              value: _litterComposition,
                              items: _litterCompositions,
                              onChanged: (v) => setState(() => _litterComposition = v),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              label: 'Вага при народженні (кг)',
                              controller: _birthWeightController,
                              hint: '0.0',
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDropdown(
                              label: 'Тип рогів',
                              value: _hornType,
                              items: _hornTypes,
                              onChanged: (v) => setState(() => _hornType = v),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),
                      _buildSubmitButton(),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Реєстрація тварини',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.textGold, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }

  Widget _buildPhotoPlaceholder() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10, width: 2),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, color: AppColors.textMuted, size: 32),
            SizedBox(height: 4),
            Text('Фото', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool isRequired = false,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, isRequired),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: _inputDecoration(hint),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({required String label, required String value, bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, isRequired),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Text(value, style: const TextStyle(color: AppColors.textMuted, fontSize: 15)),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, bool isRequired) {
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        if (isRequired) ...[
          const SizedBox(width: 4),
          const Text('🔴', style: TextStyle(fontSize: 8)),
        ],
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.textMuted.withOpacity(0.5), fontSize: 14),
      filled: true,
      fillColor: AppColors.cardBackground,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.06)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.textGold),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }

  Widget _buildIsBreederCheckbox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Transform.translate(
        offset: const Offset(-8, 0),
        child: Row(
          children: [
            Checkbox(
              value: _isOwnerBreeder,
              onChanged: (v) => setState(() => _isOwnerBreeder = v ?? false),
              activeColor: AppColors.textGold,
              checkColor: Colors.black,
              side: const BorderSide(color: AppColors.textMuted),
            ),
            const Text('Я є заводчиком цієї тварини',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField(
          label: 'Власник',
          controller: _ownerController,
          hint: 'ПІБ або назва ферми',
          isRequired: true,
          validator: (v) =>
              !_isOwnerBreeder && (v?.isEmpty ?? true) ? 'Обов\'язково' : null,
        ),
      ],
    );
  }

  Widget _buildGenderToggle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Стать', true),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildToggleButton('Коза', _isDoe, () => setState(() { _isDoe = true; _reproductiveStatus = null; })),
              const SizedBox(width: 12),
              _buildToggleButton('Козел', !_isDoe, () => setState(() { _isDoe = false; _reproductiveStatus = null; })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.textGold : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? AppColors.textGold : Colors.white10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    bool isRequired = false,
    void Function(String?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, isRequired),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            items: items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: onChanged,
            dropdownColor: AppColors.cardBackground,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: _inputDecoration('Оберіть'),
          ),
        ],
      ),
    );
  }

  Widget _buildBreedConstructor() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Порода та Кровність', true),
          const SizedBox(height: 8),
          ..._breeds.asMap().entries.map((entry) {
            final index = entry.key;
            final breed = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(8)),
                      child: Text(breed['name'], style: const TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(8)),
                      child: Text('${breed['purity']}%', style: const TextStyle(color: AppColors.textGold, fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  if (_breeds.length > 1)
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                      onPressed: () => setState(() => _breeds.removeAt(index)),
                    ),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: _addBreed,
            icon: const Icon(Icons.add_circle_outline, size: 18, color: AppColors.textGold),
            label: const Text('Додати частку породи', style: TextStyle(color: AppColors.textGold, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildPhysiologicalStatusCheckboxes() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Фізіологічний статус', true),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _physiologicalStatuses.map((status) {
              final isSelected = _selectedPhysiologicalStatuses.contains(status);
              return FilterChip(
                label: Text(status, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 12)),
                selected: isSelected,
                onSelected: (v) {
                  setState(() {
                    if (v) _selectedPhysiologicalStatuses.add(status);
                    else _selectedPhysiologicalStatuses.remove(status);
                  });
                },
                selectedColor: AppColors.textGold,
                backgroundColor: AppColors.cardBackground,
                checkmarkColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Вік / Дата народження', true),
          const SizedBox(height: 8),
          InkWell(
            onTap: _selectDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.06)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: AppColors.textGold, size: 18),
                  const SizedBox(width: 12),
                  Text(
                    DateFormat('dd.MM.yyyy').format(_birthDate),
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const Spacer(),
                  const Text('Розрахувати вік', style: TextStyle(color: AppColors.textGold, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.textGold,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
      ),
      child: const Text('ЗАРЕЄСТРУВАТИ ТВАРИНУ',
          style: TextStyle(
              fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 15)),
    );
  }
}
