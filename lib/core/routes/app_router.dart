import 'package:go_router/go_router.dart';
import 'package:statusify/features/captions/domain/entities/caption_filters.dart';
import 'package:statusify/features/captions/presentation/pages/results_page.dart';

import '../../features/captions/presentation/pages/filters_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'filters',
      builder: (context, state) => const FiltersPage(),
    ),
    GoRoute(
      path: '/results',
      name: 'results',
      builder: (context, state) {
        final filters = state.extra as CaptionFilters;
        return ResultsPage(filters: filters);
      },
    ),
  ],
);
