part of dungeon;



class Monster extends Entity{
  String name="monster";
  num HP=10;
  num MHP=10;

  int level=1;


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