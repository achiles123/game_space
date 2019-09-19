import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_space/PersistantGameState.dart';
import 'package:spritewidget/spritewidget.dart';
import 'LibraryGame.dart';



final AssetBundle _bundle = _initBundle();
SoundAssets _sounds = new SoundAssets();
SpriteSheet _spriteSheet;
SpriteSheet _spriteSheetUI;
ImageMap _imageMap;
PersistantGameState _gameState;
GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();
typedef void SelectTabCallback(int index);

AssetBundle _initBundle(){
  if(rootBundle != null)
    return rootBundle;
  return NetworkAssetBundle(Uri.directory(Uri.base.origin));
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
  _gameState = new PersistantGameState();
  await _gameState.load();
  _imageMap = new ImageMap(_bundle);
  await _imageMap.load(<String>[
    'assets/nebula.png',
    'assets/sprites.png',
    'assets/starfield.png',
    'assets/game_ui.png',
    'assets/ui_bg_top.png',
    'assets/ui_bg_bottom.png',
    'assets/ui_popup.png',
  ]);

  String json = await _bundle.loadString('assets/sprites.json');
  _spriteSheet = new SpriteSheet(_imageMap['assets/sprites.png'], json);

  json = await _bundle.loadString('assets/game_ui.json');
  _spriteSheetUI = new SpriteSheet(_imageMap['assets/game_ui.png'], json);

  assert(_spriteSheet.image != null);
  
  runApp(new GameDemo());
}

class GameDemo extends StatefulWidget {
  @override
  GameDemoState createState() => GameDemoState();
}

class GameDemoState extends State<GameDemo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Title(
        title: "",
        color: const Color(0xFF9900FF),
        key: _navigatorKey,
        child: Navigator(
          onGenerateRoute: (routes){
            switch(routes.name){
              case "/game":return _buildGameScenseRoute();
              default:return _buildMainSceneRoute();
            }
          },
        ),
      ),
      
    );
  }

  PageRoute _buildMainSceneRoute(){
    return new MaterialPageRoute(builder: (context){
      return MainScense(
        imageMap: _imageMap,
        spriteSheet: _spriteSheet,
        spriteSheetUI: _spriteSheetUI,
        onUpgradeLaser: (){

        },
        onUpgradePowerUp: (powerType){

        },
        onStartLevelUp: (){

        },
        onStartLevelDown: (){

        },
      );
    });
  }

  PageRoute _buildGameScenseRoute(){
    return new MaterialPageRoute(
      builder: (context){
        return GameScense(
          imageMap: _imageMap,
          spriteSheet: _spriteSheet,
          spriteSheetUI: _spriteSheetUI,
        );
      }
    );
  }
  
}




