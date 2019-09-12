part of game;

class TextureImage extends StatelessWidget{
  double width;
  double height;
  SpriteTexture texture;
  TextureImage({this.texture,this.width,this.height});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: this.width,
      height: this.height,
      child: CustomPaint(
        
      ),
    );
  }
  
}