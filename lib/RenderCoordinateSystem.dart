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
}