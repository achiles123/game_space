part of game;

class SoundAssets{
  AssetBundle bundle;
  static AudioCache _audioCache;

  static AudioCache getAudio(){
    if(_audioCache == null)
      _audioCache = new AudioCache();
    return _audioCache;
  }

  SoundAssets({this.bundle}){
  if(_audioCache == null)
        _audioCache = new AudioCache();
  }

  void play(String name){
    _audioCache.play("assets/$name.wav");
  }

}