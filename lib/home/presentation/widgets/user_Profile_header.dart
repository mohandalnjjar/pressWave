import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          height: MediaQuery.sizeOf(context).height * 0.25,
          decoration: BoxDecoration(
            color: BlocProvider.of<ThemeCubit>(context).themeMode
                ? const Color(0xff22222E)
                : const Color(0xffCDE8E5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    border: Border.all(
                      color: Colors.green,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: CachedNetworkImage(
                      height: 100,
                      imageUrl:
                          'https://scontent.fcai11-1.fna.fbcdn.net/v/t39.30808-1/429897266_315090971555366_5332440714602139373_n.jpg?stp=c0.0.200.200a_dst-jpg_p200x200&_nc_cat=111&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEP4JPth_tDqE8GzPtHf2aPJhbzQZsUVUImFvNBmxRVQkEwKfa200iZMNHmtGG5_XxVdTg_1gCcY8CEGQlRiliF&_nc_ohc=1u89diX5sMAQ7kNvgGZuReM&_nc_oc=Adjv765aTgp83H4rQJ_4PVAvqnxylM7Lxfk9Fcbv4bq3cQAA8qXr0Ee_Bj9W-WBx-4eYdFKo7Ue1fS2OH9d62hlD&_nc_ht=scontent.fcai11-1.fna&oh=00_AfABlLO38Fpj28k7WrGmgnUvoq8Hke0KhR4WH-LOdHcjjw&oe=663AAE65',
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
                const Text(
                  'Muhannd Alnjjar',
                  style: AppStyles.styleSemiBold19,
                ),
                Text(
                  'Mmoalnjjar@gmail.com',
                  style: AppStyles.styleRegular15.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
