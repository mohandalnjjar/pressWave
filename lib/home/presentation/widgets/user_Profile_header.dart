import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/constance/app_colors.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/home/presentation/managers/update_user_image_cubit/update_user_image_cubit_cubit.dart';
import 'package:pressWave/home/presentation/managers/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:pressWave/home/presentation/widgets/edit_profile_image_widget.dart';
import 'package:pressWave/home/presentation/widgets/edit_user_name_widget.dart';
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
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return const EditUserNameWidget();
                        });
                  },
                  icon: const Icon(
                    IconlyLight.edit,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        BlocBuilder<FetchUserDataCubit, FetchUserDataState>(
                          builder: (context, state) {
                            if (state is FetchUserDataSuccessful) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 130,
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
                                          return Image.asset(
                                              AppAssets.unKnownUser);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox(
                                height: 130,
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
                        Positioned(
                          bottom: 0,
                          right: 55,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => BlocConsumer<
                                    UpdateUserImageCubit,
                                    UpdateUserImageCubitState>(
                                  listener: (context, state) {
                                    if (state is UpdateUserImageCubitSuccess) {
                                      context.pop();
                                      showedScaffoldMessage(
                                          context: context,
                                          message: 'Image changed');
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is UpdateUserImageCubitLoading) {
                                      return const AbsorbPointer(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    } else {
                                      return const EditProfileImageWidget();
                                    }
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: BlocProvider.of<ThemeCubit>(context)
                                        .themeMode
                                    ? AppColors.navBarDarkModeColor
                                    : AppColors.navBarLightModeColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<FetchUserDataCubit, FetchUserDataState>(
                      builder: (context, state) {
                        if (state is FetchUserDataSuccessful) {
                          return Flexible(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    state.data.get('UserName'),
                                    style: AppStyles.styleSemiBold19(context),
                                  ),
                                  Text(
                                    state.data.get('Email'),
                                    style: AppStyles.styleRegular15(context)
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const Text('Loading');
                        }
                      },
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
