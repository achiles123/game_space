part of game;

class GameScense extends StatefulWidget{
  PersistantGameState _gameState;
  SpriteSheet spriteSheetUI;
  SpriteSheet spriteSheet;
  ImageMap imageMap;
  GameScense({this.imageMap,this.spriteSheet,this.spriteSheetUI}){
    _gameState = new PersistantGameState();
  }

  @override
  State<StatefulWidget> createState(){
    return GameScenseState();
  }
}
class GameScenseState extends State<GameScense>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return CoordinateSystem(
      systemSize: Size(320,320),
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: "Orbitron", fontSize:20.0),
        child: Stack(
          children: <Widget>[
            GameScenseBackground(spriteSheet: widget.spriteSheet,imageMap: widget.imageMap)
          ],
        ),
      ),
    );
  }
}

class GameScenseBackground extends StatefulWidget{
  SpriteSheet spriteSheet;
  ImageMap imageMap;
  
  GameScenseBackground({this.spriteSheet,this.imageMap});
  @override
  State<StatefulWidget> createState(){
    return GameScenseBackgroundState();
  }
}

class GameScenseBackgroundState extends State<GameScenseBackground>{
  GameScenseBackgroundNode _gameScenseBackgroundNode;
  @override
  void initState(){
    super.initState();
    _gameScenseBackgroundNode = new GameScenseBackgroundNode(spriteSheet: widget.spriteSheet,imageMap: widget.imageMap);
  }

  @override
  Widget build(BuildContext context){
    return SpriteWidget(_gameScenseBackgroundNode,SpriteBoxTransformMode.fixedHeight);
  }
}

class GameScenseBackgroundNode extends NodeWithSize{
  RepeatImage _nebula;
  RepeatImage _background;
  StarField _starField;
  ImageMap imageMap;
  SpriteSheet spriteSheet;

  GameScenseBackgroundNode({this.spriteSheet,this.imageMap}) : super(Size(320,320)){
    _background = new RepeatImage(imageMap["assets/starfield.png"]);
    addChild(_background);
    
    _nebula = new RepeatImage(imageMap["assets/nebula.png"]);
    addChild(_nebula);

    _starField = new StarField(spriteSheet, 100,true);
    addChild(_starField);

  }

}