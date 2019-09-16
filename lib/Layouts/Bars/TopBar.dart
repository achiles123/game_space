part of game;

class TopBar extends StatefulWidget{
  PersistantGameState _gameState;
  SpriteSheet _uiSheet;
  TopBar(this._uiSheet){
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TopBarState();
  }
  
}

class TopBarState extends State<TopBar>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget._gameState = new PersistantGameState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15,
          left: 10,
          child: Text("Last Score",style: labelDarkStyle,),
        ),
        Positioned(
          top: 15,
          right: 5,
          child: Text("${widget._gameState.lastScore}",style: labelDarkStyle),
        ),
        Positioned(
          top: 50,
          left: 10,
          child: Text("Best Score",style: labelDarkStyle),
        ),
        Positioned(
          top: 50,
          right: 5,
          child: Text("${widget._gameState.bestScore}",style: labelDarkStyle),
          
        ),
        Positioned(
           bottom: 0,
           left: 10,
           child: TextureImage(height: 25,width: 15,texture: widget._uiSheet["icn_crystal.png"],),
        ),
        Positioned(
           bottom: 0,
           left: 30,
           child: Text("${widget._gameState.coin}", style: labelDarkStyle,),
        ),
      ],
    );
  }
  
}