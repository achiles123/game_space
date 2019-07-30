part of game;


class CoordinateSystem extends SingleChildRenderObjectWidget{
  final Size systemSize;
  final CoordinateSystemType systemType;
  CoordinateSystem({ Key key, this.systemSize, this.systemType: CoordinateSystemType.fixedWidth, Widget child })
    : super(key: key, child: child) {
    assert(systemSize != null);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return new RenderCoordinateSystem(systemSize: systemSize,systemType: systemType);
  }

  void updateRenderObject(BuildContext context, RenderCoordinateSystem render){
    render.systemSize = this.systemSize;
    render.systemType = this.systemType;
  }
}