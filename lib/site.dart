part of dungeon;

//Map<String, Site> SiteMap = {
//  "a": new Site(),
//};



class Site extends Entity {
  int level=1;
  Dict<Creator<Monster>> monsters;

}


Site StartLand(){
  Site site=new Site();
  site
    ..monsters=new Dict<Creator<Monster>>(MonsterProb,[Mouse]);
//    ..monsters

}

