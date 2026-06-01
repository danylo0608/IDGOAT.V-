import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/herd/goat_detail_screen.dart';
import 'package:idgoat/screens/app/herd/goat_lineage_screen.dart';
import 'package:idgoat/screens/app/herd/goat_profile_screen.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/screens/app/herd/my_goats_screen.dart';
import 'package:idgoat/screens/app/navigation/widgets/app_drawer.dart';
import 'package:idgoat/screens/app/navigation/widgets/main_app_bar.dart';
import 'package:idgoat/theme/colors.dart';

enum _HerdView { list, detail, lineage, profile }

class HerdScreen extends StatefulWidget {
  const HerdScreen({super.key});

  @override
  State<HerdScreen> createState() => HerdScreenState();
}

class HerdScreenState extends State<HerdScreen> {
  Goat? _selectedGoat;
  _HerdView _view = _HerdView.list;

  void resetToList() {
    if (_view != _HerdView.list) {
      setState(() {
        _selectedGoat = null;
        _view = _HerdView.list;
      });
    }
  }

  void _openGoat(Goat goat) => setState(() {
        _selectedGoat = goat;
        _view = _HerdView.detail;
      });

  void _closeGoat() => setState(() {
        _selectedGoat = null;
        _view = _HerdView.list;
      });

  void _openLineage() => setState(() => _view = _HerdView.lineage);

  void _openProfile() => setState(() => _view = _HerdView.profile);

  void _backToDetail() => setState(() => _view = _HerdView.detail);

  void _handleBack() {
    switch (_view) {
      case _HerdView.profile:
      case _HerdView.lineage:
        _backToDetail();
      case _HerdView.detail:
        _closeGoat();
      case _HerdView.list:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final showMainAppBar =
        _view == _HerdView.list || _view == _HerdView.detail || _view == _HerdView.lineage;

    return PopScope(
      canPop: _view == _HerdView.list,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const AppDrawer(),
        appBar: showMainAppBar ? const MainAppBar() : null,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_view) {
      case _HerdView.list:
        return MyGoatsScreen(onGoatTap: _openGoat);
      case _HerdView.lineage:
        return GoatLineageScreen(goat: _selectedGoat!);
      case _HerdView.profile:
        return GoatProfileScreen(
          goat: _selectedGoat!,
          onBack: _backToDetail,
        );
      case _HerdView.detail:
        return GoatDetailScreen(
          goat: _selectedGoat!,
          onOpenLineage: _openLineage,
          onOpenProfile: _openProfile,
        );
    }
  }
}
