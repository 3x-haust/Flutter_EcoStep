import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/core/widgets/common/google_sign_in_button.dart';
import 'package:eco_step/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final loginViewModel = Get.find<LoginViewModel>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 140),
                  
                  _buildLogoSection(context),
                  
                  const SizedBox(height: 203),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Obx(() => GoogleSignInButton(
                      onTap: loginViewModel.signInWithGoogle,
                      isLoading: loginViewModel.isLoading,
                      isDarkMode: isDarkMode,
                    )),
                  ),
                  
                  const SizedBox(height: 177),
                  Obx(() {
                    if (loginViewModel.errorMessage.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          loginViewModel.errorMessage,
                          style: Typo.labelRegular(context, color: const Color(0xFFFF6B6B)),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildLogoSection(BuildContext context) {
    final colors = ThemeColors.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        Container(
          width: 130,
          height: 146.91,
          child: Image.asset(
            'assets/images/step.png',
            fit: BoxFit.contain,
          ),
        ),
        
        const SizedBox(height: 24),
        
        Text(
          'Eco Step',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ClimateCrisis',
            fontSize: 36,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 1.0,
            color: colors.primary,
          ),
        ),
      ],
    );
  }




}