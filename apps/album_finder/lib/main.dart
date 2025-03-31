import 'dart:async';
import 'dart:convert';

import 'package:album_finder/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_api/spotify_api.dart';
import 'package:spotify_repository/spotify_repository.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // secrets.jsonを読み込む
      final secrets = await rootBundle.loadString('assets/secrets.json');
      final secretMap = jsonDecode(secrets);
      final clientId = secretMap['client_id'];
      final redirectUrl = secretMap['redirect_url'];

      // spotify_api
      late final spotifyApi = SpotifyApi();

      // spotify_repository
      late final spotifyRepository = SpotifyRepository(
        spotifyApi: spotifyApi,
      );

      runApp(
        AlbumFinder(
          spotifyApi: spotifyApi,
          spotifyRepository: spotifyRepository,
        ),
      );
    },
    (error, stack) => '',
  );
}

/// AlbumFinder
class AlbumFinder extends StatefulWidget {
  /// AlbumFinder
  const AlbumFinder({
    required this.spotifyApi,
    required this.spotifyRepository,
    super.key,
  });

  /// spotify api
  final SpotifyApi spotifyApi;

  /// spotify repository
  final SpotifyRepository spotifyRepository;

  @override
  State<AlbumFinder> createState() => _AlbumFinderState();
}

class _AlbumFinderState extends State<AlbumFinder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: buildRouter(
        spotifyRepository: widget.spotifyRepository,
      ),
    );
  }
}
