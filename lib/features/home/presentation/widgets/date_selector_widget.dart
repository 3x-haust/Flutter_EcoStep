import 'package:easy_localization/easy_localization.dart';
import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/util/style/typography.dart';
import 'package:flutter/material.dart';

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({super.key});

  @override
  DateSelectorWidgetState createState() => DateSelectorWidgetState();
}

class DateSelectorWidgetState extends State<DateSelectorWidget> {
  int selectedIndex = DateTime.now().weekday % 7;

  final List<DateItem> dates = List.generate(7, (index) {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday % 7));
    final targetDate = startOfWeek.add(Duration(days: index));

    final dayNames = [
      'home.daySelector.sunday'.tr(),
      'home.daySelector.monday'.tr(),
      'home.daySelector.tuesday'.tr(),
      'home.daySelector.wednesday'.tr(),
      'home.daySelector.thursday'.tr(),
      'home.daySelector.friday'.tr(),
      'home.daySelector.saturday'.tr(),
    ];

    return DateItem(day: dayNames[index], date: '${targetDate.day}');
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dates.asMap().entries.map((entry) {
          final index = entry.key;
          final dateItem = entry.value;
          final isSelected = index == selectedIndex;

          return SizedBox(
            width: (MediaQuery.of(context).size.width - 60 - 20) / 7,
            child: Column(
              children: [
                Text(
                  dateItem.day,
                  style: Typo.bodyRegular(context, color: colors.gray90),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: isSelected ? colors.gray400 : colors.gray40,
                    borderRadius: BorderRadius.circular(46.12),
                  ),
                  child: Center(
                    child: Text(
                      dateItem.date,
                      style: Typo.bodyStrong(
                        context,
                        color: isSelected ? colors.gray0 : colors.gray200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DateItem {
  final String day;
  final String date;

  DateItem({required this.day, required this.date});
}
