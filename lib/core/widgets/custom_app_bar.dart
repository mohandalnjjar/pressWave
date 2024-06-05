import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/home/presentation/managers/fetch_user_data_cubit/fetch_user_data_cubit.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.onpressed,
    this.iconSize = 24,
  });

  final String title;
  final double iconSize;

  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyles.styleSemiBold27(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            onPressed: onpressed,
            child: BlocBuilder<FetchUserDataCubit, FetchUserDataState>(
              builder: (context, state) {
                if (state is FetchUserDataSuccessful) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 42,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: state.data.get('userImage'),
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
                  );
                } else {
                  return const SizedBox(
                    height: 42,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: ShimmerEffect(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
