part of dungeon;


class Monster extends Entity with StateTarget {
  String name="monster";
  num HP=10;
  num MHP=10;

  int level=1;


  @override
  add(Entity child) {
    super.add(child);
    if (child is State) {
      _attachState(child);
    }
  }

  @override
  remove(Entity child) {
    super.remove(child);
    if (child is State) {
      _detachState(child);
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