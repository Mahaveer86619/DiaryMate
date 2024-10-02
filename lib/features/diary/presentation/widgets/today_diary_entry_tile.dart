import 'package:diary_mate/core/resources/helpers.dart';
import 'package:diary_mate/core/themes/pallet.dart';
import 'package:diary_mate/features/diary/domain/entities/diary_entity.dart';
import 'package:flutter/material.dart';

class TodayDiaryEntryTile extends StatelessWidget {
  final DiaryEntity diaryEntry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TodayDiaryEntryTile({
    super.key,
    required this.diaryEntry,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            color: Pallete.borderColor,
            width: 1,
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 12.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diaryEntry.entryTitle,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  formatTimeOfDay(diaryEntry.date),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Pallete.greyColor,
                      ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete,
                color: Pallete.errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
