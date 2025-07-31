import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:eco_step/features/profile/domain/entities/profile.dart';
import 'package:flutter_svg/svg.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback onEditProfile;
  final VoidCallback onSignOut;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.onEditProfile,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 66,
                height: 66,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.gray90, width: 2),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: profile.profileImageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: Image.network(
                            profile.profileImageUrl!,
                            width: 58,
                            height: 58,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultProfileIcon();
                            },
                          ),
                        )
                      : _buildDefaultProfileIcon(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  profile.name,
                  style: Typo.headingStrong(context, color: colors.gray900),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'My Point',
                    style: Typo.bodyRegular(context, color: colors.gray900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${profile.points} P',
                    style: Typo.headingRegular(context, color: colors.primary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              GestureDetector(
                onTap: onEditProfile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Profile',
                      style: Typo.bodyRegular(context, color: colors.gray90),
                    ),
                    SvgPicture.asset(
                      Assets.icons.arrowForward.path,
                      width: 6,
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onSignOut,
                child: Row(
                  children: [
                    Text(
                      'Logout',
                      style: Typo.bodyRegular(context, color: colors.negative),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultProfileIcon() {
    return SvgPicture.asset(Assets.icons.person.path);
  }
}
