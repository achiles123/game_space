part of game;

class BottomBar extends StatefulWidget{
  PersistantGameState _gameState;
  SpriteSheet spriteSheet;
  BottomBar(this.spriteSheet){
    _gameState = new PersistantGameState();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomBarState();
  }
}

class BottomBarState extends State<BottomBar>{
  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        Positioned(
          left: 10,
          top: 5,
          child: TextureImage(
            height: 60,
            width: 60,
            texture: widget.spriteSheet["level_display.png"],
          ),
        ),
        Positioned(
          left: 15,
          top: 10,
          child: TextureImage(
            height: 50,
            width: 50,
            texture: widget.spriteSheet["level_display_${widget._gameState.currentStartingLevel}.png"],
          ),
        ),
        Positioned(
          left: 75,
          top: 7,
          child: GestureDetector(
            onTap: (){
              setState(() {
                widget._gameState.reachedLevel(widget._gameState.currentStartingLevel + 1);
              }); 
            },
            child: TextureImage(
                height: 25,
                width: 25,
                texture: widget.spriteSheet["btn_level_up.png"],
              ),
          )
          
          
        ),
        Positioned(
          left: 75,
          top: 40,
          child: GestureDetector(
            onTap: (){
              setState(() {
                widget._gameState.reachedLevel(widget._gameState.currentStartingLevel - 1);
              }); 
            },
            child: TextureImage(
                height: 25,
                width: 25,
                texture: widget.spriteSheet["btn_level_down.png"],
              ),
          )
        ),
        Positioned(
          left: 110,
          top: 7,
          child: GestureDetector(
            onTap: (){
              setState(() {
                Navigator.of(context).pushNamed("/game");
              }); 
            },
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width/2,
              child: Stack(
                children: <Widget>[
                  TextureImage(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    texture: widget.spriteSheet["btn_play.png"],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text("PLAY",style: TextStyle(fontSize: 28),),
                  )
                ],
              ),
            )
            
            
            
          )
        ),
      ],
    );
  }
}