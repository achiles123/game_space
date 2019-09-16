part of game;

class TextureImage extends StatefulWidget{
  double width;
  double height;
  SpriteTexture texture;
  TextureImage({this.texture,this.width,this.height});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextureImageState();
  }
  
  
}

class TextureImageState extends State<TextureImage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: TexturePainter(texture: widget.texture,width: widget.width,height: widget.height,),
      ),
    );
  }
}

class TexturePainter extends CustomPainter{
  double width;
  double height;
  SpriteTexture texture;
  TexturePainter({this.texture,this.width,this.height});

  @override
  void paint(Canvas canvas,Size size){
    canvas.save();
    canvas.scale(size.width/texture.size.width,size.height/texture.size.height);
    texture.drawTexture(canvas, Offset.zero, Paint());
    canvas.restore();
  }

  @override
  bool shouldRepaint(TexturePainter oldPainter){
    return oldPainter.texture != texture || oldPainter.width != width || oldPainter.height != height;
  }
}