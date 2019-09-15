part of game;

class StarField extends NodeWithSize{
  ui.Image _image;
  SpriteSheet _sprite;
  int _numberStar;
  bool _scroll;
  Paint _paint;
  List<Offset> _positions;
  List<Rect> _rects;
  List<Color> _colors;
  List<double> _scales;
  double _padding = 5;
  double _width = 0;
  double _height = 0;
  StarField(this._sprite,this._numberStar,[this._scroll=false]) : super(Size.zero){
    _image = _sprite.image;
    _paint = new Paint();
  }

  void addStars(){
    _positions = new List<Offset>();
    _rects = new List<Rect>();
    _colors = new List<Color>();
    _scales = new List<double>();
    Size size = spriteBox.visibleArea.size;
    _width = size.width - _padding*2;
    _height = size.height;
    for(int i=0;i<_numberStar;i++){
      _positions.add( Offset(_padding + _width*randomDouble(),_height*randomDouble()));
      _rects.add(_sprite["star_"+randomInt(2).toString()+".png"].frame);
      _scales.add(randomDouble()*0.4);
      _colors.add(new Color.fromARGB((255*(randomDouble()*0.5+0.5)).toInt(), 255, 255, 255));
    }
  }

  @override
  void spriteBoxPerformedLayout(){
    addStars();
  }

  void paint(Canvas canvas){
    List<RSTransform> transforms = new List<RSTransform>();
    
    for(int i=0;i<_numberStar;i++){
      double a = _scales[i];
      transforms.add(new RSTransform(_scales[i], 0, _positions[i].dx,_positions[i].dy));
    }
    canvas.drawAtlas(_image, transforms, _rects, _colors, BlendMode.modulate, null, _paint);
  }

  void update(double dt){
    if(_scroll == true){
      for(int i=0;i<_numberStar;i++){
        double dx = _positions[i].dx;
        double dy = _positions[i].dy + dt*50;
        if(dy > _height)
          dy -= _height;
        _positions[i] = Offset(dx,dy);
      }
    }
  }
}