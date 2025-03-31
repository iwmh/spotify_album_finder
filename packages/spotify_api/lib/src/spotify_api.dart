import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_api/src/constants.dart';

/// SpotifyApi
/// 認証からWebApiへのアクセスまで担当
class SpotifyApi {
  /// SpotifyApi
  /// 認証からWebApiへのアクセスまで担当
  SpotifyApi();

  /// AppAuth
  final FlutterAppAuth appAuth = const FlutterAppAuth();

  /// authorizationEndpoint
  static const String authorizationEndpoint =
      'https://accounts.spotify.com/authorize';

  /// tokenEndpoint
  static const String tokenEndpoint = 'https://accounts.spotify.com/api/token';

  /// authorizationCodeが含まれたレスポンスを取得する
  Future<AuthorizationResponse> exchangeAuthorizationCode(
    String clientId,
    String redirectUrl,
  ) async {
    return appAuth.authorize(
      AuthorizationRequest(
        clientId,
        redirectUrl,
        serviceConfiguration: const AuthorizationServiceConfiguration(
          authorizationEndpoint: authorizationEndpoint,
          tokenEndpoint: tokenEndpoint,
        ),
        scopes: [
          'user-modify-playback-state',
          'user-library-modify',
          'playlist-read-private',
          'playlist-read-collaborative',
          'playlist-modify-public',
          'playlist-modify-private',
          'user-read-playback-state',
          'user-read-currently-playing',
        ],
      ),
    );
  }

  /// authorizationCodeとcodeVerifierを引き換えに、accessTokenとrefreshTokenが含まれた
  /// レスポンスを取得する
  Future<TokenResponse> exchangeToken(
    String authorizationCode,
    String codeVerifier,
    String clientId,
    String redirectUrl,
  ) async {
    return appAuth.token(
      TokenRequest(
        clientId,
        redirectUrl,
        serviceConfiguration: const AuthorizationServiceConfiguration(
          authorizationEndpoint: authorizationEndpoint,
          tokenEndpoint: tokenEndpoint,
        ),
        authorizationCode: authorizationCode,
        codeVerifier: codeVerifier,
      ),
    );
  }

  /// refreshTokenと引き換えに、accessTokenとrefreshTokenが含まれたレスポンスを取得する
  Future<TokenResponse> refreshToken(
    String refreshToken,
    String clientId,
    String redirectUrl,
  ) async {
    return appAuth.token(
      TokenRequest(
        clientId,
        redirectUrl,
        grantType: GrantType.refreshToken,
        serviceConfiguration: const AuthorizationServiceConfiguration(
          authorizationEndpoint: authorizationEndpoint,
          tokenEndpoint: tokenEndpoint,
        ),
        refreshToken: refreshToken,
      ),
    );

    /*
    final body = {
      'grant_type': GrantType.refreshToken,
      'refresh_token': refreshToken,
      'client_id': clientId,
    };

    final header = {'Content-Type': 'application/x-www-form-urlencoded'};

    final response = await http.post(
      'https://accounts.spotify.com/api/token',
      body: body,
      headers: header,
    );

    final resString = response.body;
    Map authMap = await jsonDecode(resString);
    final auth = Auth.fromJson(authMap);

    return TokenResponse(
      auth.accessToken,
      auth.refreshToken,
      DateTime.now().add(Duration(seconds: auth.expiresIn)),
      null,
      null,
      null,
    );
      */
  }

  /// ログインユーザーのプレイリスト一覧を取得
  Future<http.Response> requestToGetPlaylists(
    Map<String, String> authHeader,
  ) async {
    return http.get(
      Uri.parse(Constants.currentUsersPlaylists),
      headers: authHeader,
    );
  }

  /// プレイリストのトラック一覧を取得
  Future<http.Response> requestToGetTracksInPlaylist(
    Map<String, String> authHeader,
    String url,
  ) async {
    return http.get(Uri.parse(url), headers: authHeader);
  }

  /// ログインユーザーのプロフィールを取得
  Future<http.Response> requestToGetCurrentUserProfile(
    Map<String, String> authHeader,
  ) async {
    return http.get(
      Uri.parse(Constants.currentUsersProfile),
      headers: authHeader,
    );
  }

  /// プレイリストIDからプレイリスト名を取得
  Future<http.Response> requestToGetPlaylistName(
    Map<String, String> authHeader,
    String playlistId,
  ) async {
    return http.get(
      Uri.parse(Constants.playlistNameForAPlaylistId(playlistId)),
      headers: authHeader,
    );
  }

  /// プレイリストIDでプレイリストのsnapshot_idを取得
  Future<http.Response> requestToGetPlaylistSnapshotId(
    Map<String, String> authHeader,
    String playlistId,
  ) async {
    return http.get(
      Uri.parse(Constants.playlistSnapshotIdForAPaylistId(playlistId)),
      headers: authHeader,
    );
  }
}
