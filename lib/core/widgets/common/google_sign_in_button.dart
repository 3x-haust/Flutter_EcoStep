import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;
  final bool isDarkMode;

  const GoogleSignInButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: colors.gray20,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: colors.gray40, width: 3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.gray600),
                ),
              )
            else ...<Widget>[
              _buildGoogleIcon(),
              const SizedBox(width: 10),
              Text(
                '구글로 로그인',
                style: Typo.bodyStrong(
                  context,
                  color: colors.gray900,
                ).copyWith(height: 1.0),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return SizedBox(
      width: 20,
      height: 20,
      child: SvgPicture.asset(
        'assets/images/google.svg',
        width: 20,
        height: 20,
      ),
    );
  }
}
