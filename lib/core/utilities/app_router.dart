import 'package:go_router/go_router.dart';
import 'package:pressWave/auth/presentation/views/login_View.dart';
import 'package:pressWave/auth/presentation/views/sign_up_view.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/main_view.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/views/home_view.dart';
import 'package:pressWave/home/presentation/views/news_details_view.dart';
import 'package:pressWave/home/presentation/views/root_view.dart';
import 'package:pressWave/home/presentation/views/saved_view.dart';
import 'package:pressWave/home/presentation/views/search_view.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: RouterConstance.kRootViewRouter,
        builder: (context, state) => const RootView(),
      ),
      GoRoute(
        path: RouterConstance.kHomeViewRouter,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: RouterConstance.kNewsDetailsViewRouter,
        builder: (context, state) => NewsDetailsView(
          newsModel: state.extra as NewsModel,
        ),
      ),
      GoRoute(
        path: RouterConstance.kSearchViewRouter,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: RouterConstance.kSavedViewRouter,
        builder: (context, state) => const SavedView(),
      ),
      GoRoute(
        path: RouterConstance.kLoginViewRouter,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RouterConstance.kSingUpViewRouter,
        builder: (context, state) => const SingUpView(),
      ),
      GoRoute(
        path: RouterConstance.kMainViewRouter,
        builder: (context, state) => const MainView(),
      ),
    ],
  );
}
