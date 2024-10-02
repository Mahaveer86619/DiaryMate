import 'package:diary_mate/core/themes/pallet.dart';
import 'package:diary_mate/features/movie_recomendation/domain/entities/movie_recomendation_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovieTile extends StatelessWidget {
  final MovieRecomendationEntity movieRecomendationEntity;

  const MovieTile({
    super.key,
    required this.movieRecomendationEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(
          text: movieRecomendationEntity.movieName,
        ));
      },
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    movieRecomendationEntity.movieName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.copy,
                    color: Pallete.greyColor,
                  ),
                ),
              ],
            ),
            Text(
              movieRecomendationEntity.movieRating,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Pallete.greyColor,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              movieRecomendationEntity.abstract,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Pallete.greyColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
