part of game;

class MenuCenter extends StatefulWidget{
  PersistantGameState _gameState;
  SpriteSheet _spriteSheet;
  SpriteSheet _spriteSheetUI;
  MenuCenter(this._spriteSheet,this._spriteSheetUI){
    _gameState = new PersistantGameState();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MenuCenterState();
  }
  
}

class MenuCenterState extends State<MenuCenter>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text("Upgrade Laser"),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
            child: GestureDetector(
            onTap: (){
              setState(() {
                widget._gameState.addCoin(10000);
                widget._gameState.upgradeLaser();
              });
            },
            child:  Container(
              width: 150,
              height: 70,
              child: LayoutBuilder(
                builder: (laserContext,constrain){
                  return Stack(
                    children: <Widget>[
                      TextureImage(
                        width: constrain.maxWidth,
                        height: constrain.maxHeight,
                        texture: widget._spriteSheetUI["btn_laser_upgrade.png"],
                      ),
                      Positioned(
                        bottom: 5,
                        left: constrain.maxWidth/2 -15,
                        child: Text("${widget._gameState.laserUpgradePrice()}",style: labelDarkStyleSmall,),
                      ),
                      Positioned(
                        top: 30,
                        left: 36,
                        child: IgnorePointer(
                          child:  SizedBox(
                            child: SpriteWidget(LaserDisplay(widget._spriteSheet,widget._gameState.laserLevel)),
                            width: 26.0,
                            height: 26.0
                          )
                        )
                      ),
                      Positioned(
                        top: 30,
                        right: 9,
                        child: IgnorePointer(
                          child:  SizedBox(
                            child: SpriteWidget(LaserDisplay(widget._spriteSheet,widget._gameState.laserLevel + 1)),
                            width: 26.0,
                            height: 26.0
                          )
                        )
                      ),
                    ],
                  );
                },
              )
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text("Upgrade Power-Ups"),
        ),
      ],
    );
  }
  
}