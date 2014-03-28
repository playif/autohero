/*
分成被動和靈氣
被動在特殊情況會發動，例如進攻時。

行為本身有等級之分，
*/

part of dungeon;


class Action extends Entity with Updatable{
  int level=1;
  
  
  Action(){
    
  }
  
  
}


class Attack extends Action{
  
}







