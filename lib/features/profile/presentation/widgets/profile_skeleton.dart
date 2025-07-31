import 'package:flutter/material.dart';

class SkeletonWidget extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<SkeletonWidget> createState() => _SkeletonWidgetState();
}

class _SkeletonWidgetState extends State<SkeletonWidget>
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(_animation.value * 0.3),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          ),
        );
      },
    );
  }
}

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 66,
                height: 66,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF8F98A8), width: 2),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const SkeletonWidget(
                  width: 50,
                  height: 50,
                  borderRadius: BorderRadius.all(Radius.circular(99)),
                ),
              ),
              const SizedBox(width: 12),
              const SkeletonWidget(
                width: 120,
                height: 24,
                borderRadius: BorderRadius.all(Radius.circular(99)),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SkeletonWidget(
                    width: 60,
                    height: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  const SizedBox(height: 8),
                  const SkeletonWidget(
                    width: 50,
                    height: 24,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SkeletonWidget(
                    width: 80,
                    height: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  const SkeletonWidget(
                    width: 6,
                    height: 10,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SkeletonWidget(
                    width: 50,
                    height: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
