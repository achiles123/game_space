part of game;

class MenuCenter extends StatefulWidget{
  PersistantGameState _gameState;
  SpriteSheet _spriteSheet;
  SpriteSheet _spriteSheetUI;
  VoidCallback laserUpdate;
  VoidCallback powerUpdate;

  MenuCenter(this._spriteSheet,this._spriteSheetUI,{this.laserUpdate,this.powerUpdate}){
    _gameState = new PersistantGameState();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MenuCenterState();
  }
  
}

class MenuCenterState extends State<MenuCenter>{
  Size powerSize;
  double powerFontsize = 11.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    powerSize = new Size(55,70);
  }

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
            behavior: HitTestBehavior.translucent,
            onTap: (){
              setState(() {
                widget._gameState.addCoin(10000);
                widget._gameState.upgradeLaser();
              });
              widget.laserUpdate();
              
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
                        child: Text("${widget._gameState.laserUpgradePrice()}",style: labelDarkStyle(fontSize: 15.0),),
                      ),
                      Positioned(
                        top: 30,
                        left: 36,
                        child: SizedBox(
                          child: SpriteWidget(LaserDisplay(widget._spriteSheet,widget._gameState.laserLevel)),
                          width: 26.0,
                          height: 26.0
                        )
                      ),
                      Positioned(
                        top: 30,
                        right: 9,
                        child: SizedBox(
                          child: SpriteWidget(LaserDisplay(widget._spriteSheet,widget._gameState.laserLevel + 1)),
                          width: 26.0,
                          height: 26.0
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
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  setState(() {
                    widget._gameState.upgradePower(PowerUpType.sheild);
                  });
                  widget.powerUpdate();
                },
                child: Container(
                  width: powerSize.width,
                  height: powerSize.height,
                  child: LayoutBuilder(builder: (layoutContext,constrains){
                    return Stack(
                      children: <Widget>[
                        TextureImage(
                          height: constrains.maxHeight - 15,
                          width: constrains.maxWidth,
                          texture: widget._spriteSheetUI["btn_powerup_0.png"],
                        ),
                        Positioned(
                          left: constrains.maxWidth/2 -8,
                          bottom: 16,
                          child: Text(widget._gameState.getPowerUpPrice(PowerUpType.sheild).toString(),style: labelDarkStyle(fontSize: powerFontsize),),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: constrains.maxWidth,
                            alignment: Alignment.center,
                            child: Text("Lvl ${widget._gameState.getPowerUpLevel(PowerUpType.sheild)}",style: labelDarkStyle(fontSize: powerFontsize,color: 0xffffffff),),
                       
                          )
                        )
                      ],
                    );
                  },),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    widget._gameState.upgradePower(PowerUpType.sideLaser);
                  });
                  widget.powerUpdate();
                },
                child: Container(
                  width: powerSize.width,
                  height: powerSize.height,
                  child: LayoutBuilder(builder: (layoutContext,constrains){
                    return Stack(
                      children: <Widget>[
                        TextureImage(
                          height: constrains.maxHeight - 15,
                          width: constrains.maxWidth,
                          texture: widget._spriteSheetUI["btn_powerup_1.png"],
                        ),
                        Positioned(
                          left: constrains.maxWidth/2 -8,
                          bottom: 16,
                          child: Text(widget._gameState.getPowerUpPrice(PowerUpType.sideLaser).toString(),style: labelDarkStyle(fontSize: powerFontsize),),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: constrains.maxWidth,
                            alignment: Alignment.center,
                            child: Text("Lvl ${widget._gameState.getPowerUpLevel(PowerUpType.sideLaser)}",style: labelDarkStyle(fontSize: powerFontsize,color: 0xffffffff),),
                       
                          )
                        )
                      ],
                    );
                  },),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    widget._gameState.upgradePower(PowerUpType.speedBoot);
                  });
                  widget.powerUpdate();
                },

                child: Container(
                  width: powerSize.width,
                  height: powerSize.height,
                  decoration: BoxDecoration(

                  ),
                  child: LayoutBuilder(builder: (layoutContext,constrains){
                    return Stack(
                      children: <Widget>[
                        TextureImage(
                          height: constrains.maxHeight - 15,
                          width: constrains.maxWidth,
                          texture: widget._spriteSheetUI["btn_powerup_2.png"],
                        ),
                        Positioned(
                          left: constrains.maxWidth/2 -8,
                          bottom: 16,
                          child: Text(widget._gameState.getPowerUpPrice(PowerUpType.speedBoot).toString(),style: labelDarkStyle(fontSize: powerFontsize),),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: constrains.maxWidth,
                            alignment: Alignment.center,
                            child: Text("Lvl ${widget._gameState.getPowerUpLevel(PowerUpType.speedBoot)}",style: labelDarkStyle(fontSize: powerFontsize,color: 0xffffffff),),
                       
                          )
                        ),
                      ],
                    );
                  },),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    widget._gameState.upgradePower(PowerUpType.speedLaser);
                  });
                  widget.powerUpdate();
                },
                child: Container(
                  width: powerSize.width,
                  height: powerSize.height,
                  child: LayoutBuilder(builder: (layoutContext,constrains){
                    return Stack(
                      children: <Widget>[
                        TextureImage(
                          height: constrains.maxHeight - 15,
                          width: constrains.maxWidth,
                          texture: widget._spriteSheetUI["btn_powerup_3.png"],
                        ),
                        Positioned(
                          left: constrains.maxWidth/2 -8,
                          bottom: 16,
                          child: Text(widget._gameState.getPowerUpPrice(PowerUpType.speedLaser).toString(),style: labelDarkStyle(fontSize: powerFontsize),),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: constrains.maxWidth,
                            alignment: Alignment.center,
                            child: Text("Lvl ${widget._gameState.getPowerUpLevel(PowerUpType.speedLaser)}",style: labelDarkStyle(fontSize: powerFontsize,color: 0xffffffff),),
                       
                          )
                        ),
                      ],
                    );
                  },),
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
  
}