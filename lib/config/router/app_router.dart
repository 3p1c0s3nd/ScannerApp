import 'package:go_router/go_router.dart';
import 'package:scannerpuertos/screens/scann_network.dart';
import 'package:scannerpuertos/screens/scann_urls_wayback_machine.dart';
import 'package:scannerpuertos/screens/screen_home.dart';

import '../../screens/scanner_puertos.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const ScreenHome(),
  ),
  GoRoute(
    path: '/scanports',
    builder: (context, state) => const ScannerPuertos(),
  ),
  GoRoute(
    path: '/scannetwork',
    builder: (context, state) => ScannNetwork(),
  ),
  GoRoute(
      path: '/waybackmachine',
      builder: (context, state) => ScannUrlsWaybackMachine())
]);
