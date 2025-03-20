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
class AlbumFinder extends StatelessWidget {
  /// AlbumFinder
  const AlbumFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: buildRouter(),
    );
  }
}
