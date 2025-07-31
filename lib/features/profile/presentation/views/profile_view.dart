import 'package:eco_step/core/util/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:eco_step/features/profile/presentation/widgets/profile_card.dart';
import 'package:eco_step/features/profile/presentation/widgets/profile_skeleton.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<ProfileViewModel>();
    final colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Obx(() {
          if (viewModel.isLoading) {
            return const ProfileSkeleton();
          }
          
          if (viewModel.profile == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.errorMessage.isNotEmpty 
                        ? viewModel.errorMessage 
                        : '프로필을 불러올 수 없습니다.',
                    style: Typo.bodyRegular(context, color: colors.gray900),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadProfile(),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }
          
          return ProfileCard(
            profile: viewModel.profile!,
            onEditProfile: viewModel.onEditProfile,
            onSignOut: viewModel.signOut,
          );
        }),
      ),
    );
  }
}