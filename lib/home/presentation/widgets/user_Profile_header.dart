import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.26,
          decoration: BoxDecoration(
            color: BlocProvider.of<ThemeCubit>(context).themeMode
                ? const Color(0xff22222E)
                : const Color(0xffCDE8E5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(
                      15,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.edit,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(
                        child: Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CachedNetworkImage(
                              height: 130,
                              imageUrl:
                                  'https://scontent.fcai11-1.fna.fbcdn.net/v/t39.30808-6/436306492_361233060274490_1043539174030441953_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeHkVR2me_KYPkhluHlBDq0TkwOqR5U00w6TA6pHlTTTDt4sApYyIeLvABHaUHAg1lE2-I6k4RlknwJSCh8qp7fk&_nc_ohc=46Wp8QVHM1gQ7kNvgFjjf9R&_nc_ht=scontent.fcai11-1.fna&oh=00_AYAAss5qJzRI5JM8_0y2M7MSDMcyJf1swM3hmT1bksnCGA&oe=66467530',
                              placeholder: (context, url) {
                                return const AspectRatio(
                                  aspectRatio: 1,
                                  child: ShimmerEffect(),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Image.asset(AppAssets.unKnownUser);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Muhannd Alnjjar',
                      style: AppStyles.styleSemiBold19,
                    ),
                    Text(
                      'Mmoalnjjar@gmail.com',
                      style:
                          AppStyles.styleRegular15.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
