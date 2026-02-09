import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';
import '../bottom_navigation/view/bottom_navigation_page.dart';

class AppPermissionPage extends StatefulWidget {
  const AppPermissionPage({super.key});

  @override
  State<AppPermissionPage> createState() => _AppPermissionPageState();

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AppPermissionPage());
  }
}

class _AppPermissionPageState extends State<AppPermissionPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    SharedUtil.setBoolValue(isDisclosure, true);
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Branding.colors.primaryDark.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40.0),
                            
                            // Header Section
                            _buildHeaderSection(),
                            const SizedBox(height: 40.0),
                            
                            // Features List
                            _buildFeaturesList(),
                            const SizedBox(height: 32.0),
                            
                            // Settings Note
                            _buildSettingsNote(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Continue Button
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Branding.colors.primaryDark.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(
              Icons.location_on,
              size: 48.0,
              color: Branding.colors.primaryDark,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            tr("app_permission_title"),
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12.0),
          Text(
            tr("app_permission_subtitle"),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.how_to_reg_outlined,
        'text': tr("permission_feature_1"),
        'color': Colors.blue,
      },
      {
        'icon': Icons.straighten_outlined,
        'text': tr("permission_feature_2"),
        'color': Colors.green,
      },
      {
        'icon': Icons.track_changes_outlined,
        'text': tr("permission_feature_3"),
        'color': Colors.orange,
      },
      {
        'icon': Icons.trending_up_outlined,
        'text': tr("permission_feature_4"),
        'color': Colors.purple,
      },
    ];

    return Column(
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;
        
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _buildFeatureItem(
                  icon: feature['icon'] as IconData,
                  text: feature['text'] as String,
                  color: feature['color'] as Color,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              icon,
              size: 24.0,
              color: color,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey[800],
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsNote() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue[700],
            size: 20.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              tr("permission_settings_note"),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.blue[800],
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final navigator = instance<GlobalKey<NavigatorState>>().currentState!;
          navigator.pushAndRemoveUntil(
            BottomNavigationPage.route(),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Branding.colors.primaryDark,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Branding.colors.primaryDark.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr("continue"),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.arrow_forward,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
