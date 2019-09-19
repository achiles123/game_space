part of game;


typedef void UpgradePowerUpCallBack(PowerUpType type);
double bootSpeed = 1;

class MainScense extends StatefulWidget{
  PersistantGameState gameState;
  UpgradePowerUpCallBack onUpgradePowerUp;
  VoidCallback onUpgradeLaser;
  VoidCallback onStartLevelUp;
  VoidCallback onStartLevelDown;
  SpriteSheet spriteSheetUI;
  SpriteSheet spriteSheet;
  ImageMap imageMap;

  MainScense({this.onUpgradePowerUp,this.onUpgradeLaser,this.onStartLevelUp,this.onStartLevelDown,
              this.spriteSheet,this.spriteSheetUI,this.imageMap}){
    gameState = new PersistantGameState();
  }
  

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
        child: Stack(
          children: <Widget>[
              MainScenseBackground(spriteSheet: widget.spriteSheet,imageMap: widget.imageMap,),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: 320,
                    height: 105,
                    child: TopBar(widget.spriteSheetUI),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: MenuCenter(widget.spriteSheet,widget.spriteSheetUI,
                        laserUpdate: ()=>setState((){}),
                        powerUpdate: ()=>setState((){}),
                      ),
                    ),
                  ),
                  Container(
                    width: 320,
                    height: 70,
                    child: BottomBar(widget.spriteSheetUI)
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class MainScenseBackground extends StatefulWidget{
  SpriteSheet spriteSheet;
  ImageMap imageMap;
  MainScenseBackground({this.spriteSheet,this.imageMap});

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
    _backgroundNode = new MainScenseBackgroundNode(imageMap: widget.imageMap,spriteSheet: widget.spriteSheet);
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
  SpriteSheet spriteSheet;
  ImageMap imageMap;

  MainScenseBackgroundNode({this.spriteSheet,this.imageMap}) : super(new Size(320.0,320.0)){
    assert(spriteSheet.image != null);
    _background = new RepeatImage(imageMap["assets/starfield.png"]);
    addChild(_background);

    _nebula = new RepeatImage(imageMap["assets/nebula.png"]);
    addChild(_nebula);

    StarField stars = new StarField(spriteSheet, 250,true);
    addChild(stars);

    _top = new Sprite.fromImage(imageMap["assets/ui_bg_top.png"]);
    _top.size = Size(320,100);
    _top.pivot = Offset(0,0);
    addChild(_top);

    _bottom = new Sprite.fromImage(imageMap["assets/ui_bg_bottom.png"]);
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