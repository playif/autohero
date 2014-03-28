part of dungeon;


class Monster extends GameEntity with StateHost {
  String name="monster";
  num HP=10;
  num MHP=10;

  int level=1;


  //  @override
  //  add(Entity child) {
  //    if (child is State) {
  //      _attachState(this,child);
  //    }
  //    else if (child is Action){
  //
  //    }
  //  }

  @override
  remove(Entity child) {
    if (child is State) {
      _removeState(this, child);
    }
  }


}


Map<Creator<Monster>, int> MonsterProb = {};


Monster Mouse() {
  Monster monster = new Monster();
  monster
    ..name = "老鼠"
    ..MHP=10;
  return monster;
}


////rock door etc.
//class Natural extends Monster{
//
//}
//
//class Chest extends Monster{
//
//}