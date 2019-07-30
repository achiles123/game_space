part of game;

enum CoordinateSystemType {
  fixedWidth,
  fixedHeight,
  stretch,
}

class RenderCoordinateSystem extends RenderProxyBox{
  Size get systemSize => _systemSize;
  Size _systemSize;
  set systemSize(Size systemSize) {
    if (_systemSize == systemSize)
      return;
    _systemSize = systemSize;
    markNeedsPaint();
  }

  CoordinateSystemType get systemType => _systemType;
  CoordinateSystemType _systemType;
  set systemType(CoordinateSystemType systemType) {
    if (_systemType == systemType)
      return;
    _systemType = systemType;
    markNeedsPaint();
  }
  RenderCoordinateSystem({
    Size systemSize,
    CoordinateSystemType systemType,
    RenderBox child
  }) : super(child) {
    assert(systemSize != null);
    assert(systemType != null);
    this.systemSize = systemSize;
    this.systemType = systemType;
  }

  Matrix4 get _effectiveTransform{
    double scaleX = 1.0;
    double scaleY = 1.0;
    switch(systemType){
      case CoordinateSystemType.stretch: 
        scaleX = size.width/systemSize.width;
        scaleY = size.height/systemSize.height;
        break;
      case CoordinateSystemType.fixedWidth:
        scaleX = size.width/systemSize.width;
        scaleY = scaleX;
        break;
      case CoordinateSystemType.fixedHeight:
        scaleY = size.height/systemSize.height;
        scaleX = scaleY;
        break;
    }
    Matrix4 effectiveTransform = new Matrix4.identity();
    effectiveTransform.scale(scaleX,scaleY);
    return effectiveTransform;
  }

  void paint(PaintingContext context,Offset offset){
    if(child != null){
      Matrix4 transform = _effectiveTransform;
      Offset childOffset = MatrixUtils.getAsTranslation(transform);
      if(childOffset  == null){
        context.pushTransform(needsCompositing, offset, transform, super.paint);
      }else{
        super.paint(context, offset);
      }
      
    }
  }

  void applyPaintTransform(RenderObject child,Matrix4 transform){
    transform.multiply(_effectiveTransform);
    super.applyPaintTransform(child, transform);
  }

  bool get sizedByParent => true;

  void performResize() {
    size = constraints.biggest;
  }

  // Perform layout
  void performLayout() {
    double xScale = _effectiveTransform[0];
    double yScale = _effectiveTransform[5];

    if (child != null) {
      child.layout(new BoxConstraints.tightFor(width: size.width / xScale, height: size.height / yScale));
    }
  }
}