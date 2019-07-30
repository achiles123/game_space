part of game;

class RepeatImage extends Node{
  Sprite _sprite0;
  Sprite _sprite1;
  RepeatImage(ui.Image image,[ui.BlendMode mode]){
    _sprite0 = new Sprite.fromImage(image);
    _sprite0.size = new Size(1024,1024);
    _sprite0.pivot = Offset.zero;

    _sprite1 = new Sprite.fromImage(image);
    _sprite1.size = new Size(1024,1024);
    _sprite1.pivot = Offset.zero;
    _sprite1.position = new Offset(0, -1024);
    if(mode != null){
      _sprite0.transferMode = mode;
      _sprite1.transferMode = mode;
    }
    addChild(_sprite0);
    addChild(_sprite1);
  }

  void move(double dy){
    double dyPos = (position.dy + dy)%1024;
    position = new Offset(0.0, dyPos);
  }
}