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
double bootSpeed = 1;
typedef void SelectTabCallback(int index);
typedef void UpgradePowerUpCallBack(PowerUpType type);

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
              case "/game":break;
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
        gameState: _gameState,
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
  
}

class MainScense extends StatefulWidget{
  PersistantGameState gameState;
  UpgradePowerUpCallBack onUpgradePowerUp;
  VoidCallback onUpgradeLaser;
  VoidCallback onStartLevelUp;
  VoidCallback onStartLevelDown;

  MainScense({this.gameState,this.onUpgradePowerUp,this.onUpgradeLaser,this.onStartLevelUp,this.onStartLevelDown});
  

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainScenseState();
  }
}

class MainScenseState extends State<MainScense>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CoordinateSystem(
      systemSize: Size(360.0,360.0),
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: "Orbitron", fontSize:20.0),
        child: GestureDetector(
          onTap: (){
            setState(() {
              bootSpeed += 0.1; 
            });
          },
          child: Stack(
            children: <Widget>[
                MainScenseBackground(),
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 320,
                      height: 105,
                      child: TopBar(_spriteSheetUI),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: MenuCenter(_spriteSheet,_spriteSheetUI),
                      ),
                    ),
                    Container(
                      width: 320,
                      height: 70,
                      child: BottomBar(_spriteSheetUI)
                    ),
                  ],
                ),
            ],
          ),
        )
        
        
      ),
    );
  }
}

class MainScenseBackground extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainScenseBackgroundState();
  }
}

class MainScenseBackgroundState extends State<MainScenseBackground>{
  MainScenseBackgroundNode _backgroundNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _backgroundNode = new MainScenseBackgroundNode();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SpriteWidget(_backgroundNode,SpriteBoxTransformMode.fixedWidth);
  }
}

class MainScenseBackgroundNode extends NodeWithSize{
  RepeatImage _background;
  RepeatImage _nebula;
  Sprite _top;
  Sprite _bottom;
  MainScenseBackgroundNode() : super(new Size(320.0,320.0)){
    assert(_spriteSheet.image != null);
    _background = new RepeatImage(_imageMap["assets/starfield.png"]);
    addChild(_background);

    _nebula = new RepeatImage(_imageMap["assets/nebula.png"]);
    addChild(_nebula);

    StarField stars = new StarField(_spriteSheet, 250,true);
    addChild(stars);

    _top = new Sprite.fromImage(_imageMap["assets/ui_bg_top.png"]);
    _top.size = Size(320,100);
    _top.pivot = Offset(0,0);
    addChild(_top);

    _bottom = new Sprite.fromImage(_imageMap["assets/ui_bg_bottom.png"]);
    _bottom.size = Size(320,70);
    _bottom.pivot = Offset(0,1);
    addChild(_bottom);
  }

  void spriteBoxPerformedLayout(){
    _bottom.position = Offset(0,spriteBox.visibleArea.size.height);
  }
  
  @override
  void update(double dt){
    _background.move(bootSpeed*10.0*dt);
    _nebula.move(bootSpeed*100.0*dt);
  }
}
