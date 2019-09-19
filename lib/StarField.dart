part of game;

class StarField extends NodeWithSize{
  SpriteSheet _spriteSheet;
  ui.Image _image;
  bool _scrolling;
  int _numStars;

  List<Rect> _rects;
  List<Offset> _positions;
  List<Color> _colors;
  List<double> _scales;

  Paint _paint;

  StarField(this._spriteSheet,this._numStars,[this._scrolling = false]) : super(Size.zero){
    _image = _spriteSheet.image;
    _paint = new Paint();
  }

  void addStars(){
    _rects = new List<Rect>();
    _positions = new List<Offset>();
    _colors = new List<Color>();
    _scales = new List<double>();
    Size size = spriteBox.visibleArea.size;

    for(int i=0;i<_numStars;i++){
      _rects.add(_spriteSheet["star_"+randomInt(2).toString()+".png"].frame);
      _positions.add(Offset(size.width*randomDouble(),size.height*1.0*randomDouble()));
      _colors.add(Color.fromARGB((randomInt(255)*(randomDouble() * 0.5 + 0.5)).toInt(), 255, 255, 255));
      _scales.add(randomDouble()*0.43);
    }
  }
  
  @override
  void spriteBoxPerformedLayout(){
    addStars();
  }

  void paint(Canvas canvas){
    List<RSTransform> transforms = new List<RSTransform>();  
    for(int i=0;i<_numStars;i++){
      RSTransform transform = new RSTransform(_scales[i], 0, _positions[i].dx, _positions[i].dy);
      transforms.add(transform);
    }
    canvas.drawAtlas(_image, transforms, _rects, _colors, BlendMode.modulate, null, _paint);
  }

  void update(double dt){
    if(_scrolling == true){
      Size size = spriteBox.visibleArea.size;
      for(int i=0;i<_numStars;i++){
        double dx= _positions[i].dx;
        double dy = _positions[i].dy;
        if(dy > size.height)
          dy = -dt*50-15;
        _positions[i] = Offset(dx,dy + dt*50);
      }
    }
  }
}