import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/core/util/app_state_manager.dart';
import 'package:eco_step/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ClimateMissionPage extends StatefulWidget {
  const ClimateMissionPage({super.key});

  @override
  ClimateMissionPageState createState() => ClimateMissionPageState();
}

class ClimateMissionPageState extends State<ClimateMissionPage> {
  final TextEditingController _storyController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _hasSelectedPhoto = false;

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.5),
          child: Container(color: colors.gray40, height: 2.5),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    buildTodoSection(colors),
                    const SizedBox(height: 30),
                    buildContentSection(colors),
                    const SizedBox(height: 38),
                    buildPhotoSection(colors),
                    const SizedBox(height: 107),
                    buildCompleteButton(colors),
                    const SizedBox(height: 68),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(ThemeColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              Assets.icons.arrowBack.path,
              width: 12,
              height: 22,
              colorFilter: ColorFilter.mode(colors.gray900, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTodoSection(ThemeColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Todo",
          style: Typo.bodyStrong(context, color: colors.gray900),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.gray30,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "Using Tumblr",
            style: Typo.bodyStrong(context, color: colors.gray900),
          ),
        ),
      ],
    );
  }

  Widget buildContentSection(ThemeColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Content", style: Typo.bodyStrong(context, color: colors.gray900)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.gray30,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: _storyController,
            maxLines: 8,
            maxLength: 1000,
            decoration: InputDecoration(
              hintText: "Please describe your story (up to 1,000 characters)",
              hintStyle: Typo.bodyRegular(context, color: colors.gray200),
              border: InputBorder.none,
              counterStyle: Typo.footnoteRegular(
                context,
                color: colors.gray200,
              ),
            ),
            cursorColor: colors.gray900,
            style: Typo.bodyRegular(context, color: colors.gray900),
          ),
        ),
      ],
    );
  }

  Widget buildPhotoSection(ThemeColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Photo (select 1)",
              style: Typo.bodyStrong(context, color: colors.gray900),
            ),
            const SizedBox(height: 4),
            Text(
              "Upload a photo.",
              style: Typo.footnoteRegular(context, color: colors.gray200),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _takePicture,
          child: Container(
            decoration: _selectedImage != null
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: 161,
                      height: 161,
                    ),
                  )
                : SvgPicture.asset(
                    Assets.icons.addPhoto.path,
                    width: 102.13,
                    height: 100,
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildCompleteButton(ThemeColors colors) {
    final bool canComplete =
        _storyController.text.isNotEmpty && _hasSelectedPhoto;

    return GestureDetector(
      onTap: canComplete ? handleComplete : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: canComplete ? colors.primary : colors.gray30,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Completed",
          style: Typo.titleStrong(
            context,
            color: canComplete ? colors.background : colors.gray200,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void handleComplete() {
    final colors = ThemeColors.of(context);

    AppStateManager.completeMission();
    Get.back();
    Get.snackbar(
      '미션 완료!',
      '기후 미션을 성공적으로 완료했습니다!',
      backgroundColor: colors.primary,
      colorText: colors.background,
    );
  }

  Future<void> _takePicture() async {
    final colors = ThemeColors.of(context);

    var cameraStatus = await Permission.camera.status;
    
    if (cameraStatus.isDenied) {
      cameraStatus = await Permission.camera.request();
    }
    
    if (cameraStatus.isPermanentlyDenied) {
      Get.dialog(
        AlertDialog(
          title: Text('카메라 권한 필요'),
          content: Text('사진을 찍기 위해 카메라 권한이 필요합니다.\n설정에서 권한을 허용해주세요.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                openAppSettings();
              },
              child: Text('설정으로 이동'),
            ),
          ],
        ),
      );
      return;
    }

    // 권한이 여전히 거부된 경우
    if (!cameraStatus.isGranted) {
      Get.snackbar(
        '권한 필요',
        '카메라 권한이 필요합니다.',
        backgroundColor: colors.negative,
        colorText: colors.background,
      );
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasSelectedPhoto = true;
        });
      }
    } catch (e) {
      Get.snackbar(
        '오류',
        '사진을 찍는 중 오류가 발생했습니다: $e',
        backgroundColor: colors.negative,
        colorText: colors.background,
      );
    }
  }
}
