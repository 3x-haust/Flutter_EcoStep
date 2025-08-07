import 'package:easy_localization/easy_localization.dart';
import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:eco_step/features/profile/domain/entities/profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: Image.asset(
                            Assets.images.defaultProfile.path,
                            width: 58,
                            height: 58,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultProfileIcon();
                            },
                          ),
                        )
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
                    context.tr('profile.pointTitle'),
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
                onTap: () => _showLanguageSelection(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.language.path,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        colors.gray900,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      context.tr('profile.languageSetting'),
                      style: Typo.bodyRegular(context, color: colors.gray900),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onSignOut,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.logout.path,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        colors.negative,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      context.tr('profile.logout'),
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

  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const LanguageSelectionBottomSheet();
      },
    );
  }
}

class LanguageSelectionBottomSheet extends StatefulWidget {
  const LanguageSelectionBottomSheet({super.key});

  @override
  State<LanguageSelectionBottomSheet> createState() => _LanguageSelectionBottomSheetState();
}

class _LanguageSelectionBottomSheetState extends State<LanguageSelectionBottomSheet> {
  static const List<Map<String, String>> languages = [
    {
      'code': 'en-US',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸',
    },
    {'code': 'ko-KR', 'name': 'Korean', 'nativeName': '한국어', 'flag': '🇰🇷'},
    {
      'code': 'id-ID',
      'name': 'Indonesian',
      'nativeName': 'Bahasa Indonesia',
      'flag': '🇮🇩',
    },
    {'code': 'th-TH', 'name': 'Thai', 'nativeName': 'ไทย', 'flag': '🇹🇭'},
    {
      'code': 'fil-PH',
      'name': 'Filipino',
      'nativeName': 'Filipino',
      'flag': '🇵🇭',
    },
    {'code': 'bn-BD', 'name': 'Bengali', 'nativeName': 'বাংলা', 'flag': '🇧🇩'},
    {'code': 'uz-UZ', 'name': 'Uzbek', 'nativeName': 'O\'zbek', 'flag': '🇺🇿'},
    {
      'code': 'rw-RW',
      'name': 'Kinyarwanda',
      'nativeName': 'Ikinyarwanda',
      'flag': '🇷🇼',
    },
  ];

  String _selectedLanguageCode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedLanguageCode.isEmpty) {
      _selectedLanguageCode = context.locale.toString();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colors.gray100, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr('profile.languageSetting'),
                  style: Typo.headingStrong(context, color: colors.gray900),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, size: 24, color: colors.gray900),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final languageCode = language['code']!;
                final currentLocale = context.locale.toString();
                final normalizedCurrentLocale = currentLocale.replaceAll('_', '-');
                final normalizedSelectedCode = _selectedLanguageCode.replaceAll('_', '-');
                
                final isSelected = languageCode == normalizedCurrentLocale || 
                                 languageCode == normalizedSelectedCode;

                return _buildLanguageItem(
                  context,
                  language,
                  isSelected,
                  () async {
                    if (!isSelected) {
                      setState(() {
                        _selectedLanguageCode = language['code']!;
                      });

                      final localeParts = language['code']!.split('-');
                      final newLocale = Locale(localeParts[0], localeParts[1]);

                      try {
                        await context.setLocale(newLocale);
                        
                        Get.updateLocale(newLocale);

                        await Future.delayed(const Duration(milliseconds: 100));
                        
                        if (mounted) {
                          Get.back();
                        }
                      } catch (e) {
                        debugPrint('언어 변경 중 오류 발생: $e');
                        if (mounted) {
                          Get.back();
                        }
                      }
                    } else {
                      Get.back();
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(
    BuildContext context,
    Map<String, String> language,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final colors = ThemeColors.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primary.withOpacity(0.08)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Text(language['flag']!, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language['nativeName']!,
                      style: Typo.bodyStrong(context).copyWith(
                        color: isSelected ? colors.primary : colors.gray800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      language['name']!,
                      style: Typo.bodyRegular(context).copyWith(
                        color: isSelected
                            ? colors.primary.withOpacity(0.8)
                            : colors.gray600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.check, size: 16, color: colors.background),
                ),
            ],
          ),
        ),
      ),
    );
  }
}