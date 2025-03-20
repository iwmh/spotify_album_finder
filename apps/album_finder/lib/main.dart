import 'dart:async';

import 'package:album_finder/router.dart';
import 'package:flutter/material.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(
        const AlbumFinder(),
      );
    },
    (error, stack) => '',
  );
}

/// AlbumFinder
class AlbumFinder extends StatefulWidget {
  /// AlbumFinder
  const AlbumFinder({super.key});

  @override
  State<AlbumFinder> createState() => _AlbumFinderState();
}

class _AlbumFinderState extends State<AlbumFinder> {
  // NavigatorKey

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: buildRouter(),
    );
  }
}
