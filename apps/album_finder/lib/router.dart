import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// routing table を作成
GoRouter buildRouter() {
  return GoRouter(
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return ScaffoldWithBottomNavigationBar(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          // 「ホーム」タブ
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),
          // 「ライブラリ」タブ
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/libraries',
                builder: (BuildContext context, GoRouterState state) {
                  return const LibraryScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// BottomNavigationBar付きのScaffold
class ScaffoldWithBottomNavigationBar extends StatefulWidget {
  /// BottomNavigationBar付きのScaffold
  const ScaffoldWithBottomNavigationBar({
    required this.navigationShell,
    super.key,
  });

  /// BottomNavigationBarの上の画面本体
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithBottomNavigationBar> createState() =>
      _ScaffoldWithBottomNavigationBarState();
}

class _ScaffoldWithBottomNavigationBarState
    extends State<ScaffoldWithBottomNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: AlbumFinderBottomNavigationBar(
        navigationShell: widget.navigationShell,
      ),
    );
  }
}

/// アプリのBottomNavigationBar
class AlbumFinderBottomNavigationBar extends StatelessWidget {
  /// アプリのBottomNavigationBar
  const AlbumFinderBottomNavigationBar({
    required this.navigationShell,
    super.key,
  });

  /// BottomNavigationBarの上の画面本体
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'library',
          icon: Icon(Icons.library_books),
        ),
      ],
      currentIndex: navigationShell.currentIndex,
      onTap: onTap,
    );
  }

  /// タブタップ時
  void onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: const Center(
        child: Text(
          'home screen!!!!!!',
        ),
      ),
    );
  }
}

/// The library screen
class LibraryScreen extends StatelessWidget {
  /// Constructs a [LibraryScreen]
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library Screen')),
      body: const Center(
        child: Text(
          'library screen!!!!!!',
        ),
      ),
    );
  }
}
