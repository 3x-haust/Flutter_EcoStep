import 'package:eco_step/core/util/style/colors.dart';
import 'package:flutter/material.dart';

class HistorySkeleton extends StatefulWidget {
  const HistorySkeleton({super.key});

  @override
  State<HistorySkeleton> createState() => _HistorySkeletonState();
}

class _HistorySkeletonState extends State<HistorySkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          _buildSkeletonItem(colors, isSpecial: true),
          const SizedBox(height: 10),
          ...List.generate(
            6,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildSkeletonItem(colors),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonItem(ThemeColors colors, {bool isSpecial = false}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: colors.gray10,
            borderRadius: BorderRadius.circular(16),
          ),
          child: isSpecial
              ? _buildSpecialSkeletonContent()
              : _buildNormalSkeletonContent(),
        );
      },
    );
  }

  Widget _buildSpecialSkeletonContent() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(_animation.value * 0.3),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(
                            _animation.value * 0.3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 30,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(
                            _animation.value * 0.3,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(
                            _animation.value * 0.3,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(_animation.value * 0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 138,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(_animation.value * 0.3),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }

  Widget _buildNormalSkeletonContent() {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(_animation.value * 0.3),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 19),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(_animation.value * 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(_animation.value * 0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
