part of game;

class LaserDisplay extends NodeWithSize{
  SpriteSheet _spriteSheet;
  PersistantGameState _gameState;
  List<Color> laserColors = [
    Color(0xff338AFF),
    Color(0xff41DB5B),
    Color(0xffDBB341),
    Color(0xffFF0A0A),
    Color(0xff9B0060),
  ];
  LaserDisplay(this._spriteSheet,int level) : super(Size(16,16)){
    _gameState = new PersistantGameState();
    display(level: level);
  }
  
  void display({int level = 1}){
    int numsLaser = level % 2;
    if(numsLaser == 0)
      numsLaser = 2;

    int indexColor = level%10~/2 + level%2;
    if(level%10 == 0)
      indexColor = 5;
    indexColor -= 1;
    if(indexColor < 0){
      indexColor = 0;
    }
    Node node = new Node();
    node.scale = 0.8;
    node.position = position;
    for(int i=0;i<numsLaser;i++){
      Sprite laser = new Sprite(_spriteSheet["explosion_particle.png"]);
      laser.scale = 0.5;
      laser.colorOverlay = laserColors[indexColor];
      laser.transferMode = ui.BlendMode.plus;
      if(numsLaser > 1)
        laser.position += Offset( -3 + i*5.0,0);
      node.addChild(laser);
    }
    addChild(node);
  }
}