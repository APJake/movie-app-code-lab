import 'package:flutter/material.dart';
import 'package:movie_app/ui/model/person.dart';
import '../theme.dart';
import 'components/big_text.dart';
import 'components/custom_image.dart';
import 'components/small_text.dart';

class PersonListSession extends StatelessWidget {
  final List<Person> persons;
  const PersonListSession(this.persons, {Key? key}) : super(key: key);

  _personItem(Person person) => Container(
        margin: const EdgeInsets.only(left: 16),
        width: AppSizes.profileItemWidth,
        child: Stack(
          children: [
            CustomImage(
              imageUrl: person.profilePath,
              errorIcon: Icons.person,
              errorIconColor: AppColors.hint,
              width: AppSizes.profileItemWidth,
              height: AppSizes.profileItemHeight,
              isGradient: true,
              colorsForGradient: const [
                Colors.transparent,
                Colors.transparent,
                AppColors.backgroundPale
              ],
            ),
            Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: AppColors.text,
                    ))),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    person.name,
                    size: AppSizes.smallFont,
                    fontWeight: FontWeight.w900,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        color: AppColors.primary,
                        size: AppSizes.xxSmallIcon,
                      ),
                      const SizedBox(width: 5),
                      SmallText(
                        "YOU LIKED ${person.id % 10} MOVIES",
                        size: AppSizes.xxSmallFont,
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _movieList(List<Person> persons) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: ((context, index) => _personItem(persons[index])),
        itemCount: persons.length,
        scrollDirection: Axis.horizontal,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.profileItemHeight,
      child: _movieList(persons),
    );
  }
}
