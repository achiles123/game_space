import 'dart:convert';
import 'dart:io';

import 'package:game_space/LibraryGame.dart';
import 'package:path_provider/path_provider.dart';

class PersistantGameState{
  int coin = 0;
  List<int> _powerupLevels = <int>[0, 0, 0, 0];
  int _currentStartingLevel;
  int maxStartingLevel = 100;
  int laserLevel;
  int maxLaserLevel = 100;
  int lastScore = 0;
  int bestScore = 0;
  int get currentStartingLevel => _currentStartingLevel;
  set currentStartingLevel(int level){
    if(level <= maxStartingLevel && level >=0 ){
      _currentStartingLevel = level;
    }
  }

  PersistantGameState(){

  }

  Future load() async{
    String dataDir = (await getApplicationDocumentsDirectory()).path;
    File file = new File(dataDir+"/game_space.json");
    if(file.existsSync()){
      String dataString = file.readAsStringSync();
      JsonDecoder decoder = new JsonDecoder();
      Map data = decoder.convert(dataString);
      coin = data["coin"];
      _powerupLevels = data["powerupLevels"];
      _currentStartingLevel = data["currentStartingLevel"];
      maxStartingLevel = data["maxStartingLevel"];
      laserLevel = data["laserLevel"];
      lastScore = data["lastScore"];
      bestScore = data["bestScore"];
    }
  }

  Future store() async {
    String dataDir = (await getApplicationDocumentsDirectory()).path;
    File file = new File(dataDir+"/game_space.json");
    Map data = {
      "coin":coin,
      "powerupLevels":_powerupLevels,
      "currentStartingLevel":_currentStartingLevel,
      "maxStartingLevel":maxStartingLevel,
      "laserLevel":laserLevel,
      "lastScore":lastScore,
      "bestScore":bestScore,
    };
    JsonEncoder encoder = new JsonEncoder();
    String json = encoder.convert(data);
    file.writeAsStringSync(json);
  }

  int getPowerUpLevel(PowerUpType type) => _powerupLevels[type.index];
  int getPowerUpPrice(PowerUpType type){
    int level = getPowerUpLevel(type) + 1;
    return level*50 + 50;
  }
  int getPowerUpFrame(PowerUpType type){
    int level = getPowerUpLevel(type);
    if(type == PowerUpType.speedBoot)
      return 150 + 25*level;
    return 300 + 50*level;
  }

  void increaseLevel(PowerUpType type){
    _powerupLevels[type.index] += 1;
  }

  bool upgradePower(PowerUpType type){
    int price = getPowerUpPrice(type);
    if(coin - price >= 0){
      coin -= price;
      increaseLevel(type);
      store();
      return true;
    }
    return false;
  }

  int laserUpgradePrice() {
    return laserLevel * 100 + 200;
  }

  bool upgradeLaser() {
    if (coin >= laserUpgradePrice() && laserLevel < maxLaserLevel) {
      coin -= laserUpgradePrice();
      laserLevel++;
      store();
      return true;
    } else {
      return false;
    }
  }

  void reachedLevel(int level) {
    if (level < maxStartingLevel) {
      _currentStartingLevel = level;
    }
    store();
  }
}