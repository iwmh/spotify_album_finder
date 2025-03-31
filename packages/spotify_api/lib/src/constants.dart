/// 定数
class Constants {

  /// https://developer.spotify.com/documentation/web-api/reference/get-a-list-of-current-users-playlists
  static const currentUsersPlaylists = 'https://api.spotify.com/v1/me/playlists';

  /// https://developer.spotify.com/documentation/web-api/reference/get-playlists-tracks
  static String tracksInPlaylist(String playlistId) => 'https://api.spotify.com/v1/playlists/$playlistId/tracks?';

  /// https://developer.spotify.com/documentation/web-api/reference/get-playlist
  static String playlistNameForAPlaylistId(String playlistId) =>
      'https://api.spotify.com/v1/playlists/$playlistId?fields=name';

  /// https://developer.spotify.com/documentation/web-api/reference/get-playlist
  static String playlistSnapshotIdForAPaylistId(String playlistId) =>
      'https://api.spotify.com/v1/playlists/$playlistId?fields=snapshot_id';

  /// "fields" query for playlist-related GET request.
  static const String albums =
      'fields=items(added_at, track(album(artists, id, images, name, release_date, total_tracks))),next';

  ///
  static const String currentUsersProfile = 'https://api.spotify.com/v1/me';

}
