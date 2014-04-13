//part of model;
library model;

//@MirrorsUsed(targets: const ['model'])
//import 'dart:mirrors';

class Formula {
  String name;

  num call() {

  }

}

class ModifierModel {
  final List<Modifier> modifiers = [];

//  addModifier(String field, String desc, Formula formula) {
//    modifiers.add(new Modifier(new Symbol(field), formula, desc));
//  }


//  View createInfoView(){
//    View view=new View();
//    view.width=200;
//
//  }
}

abstract class Modifier {
  //Symbol field;
  //Formula formula;
  String get desc;

  //Modifier();

  void modify() {
    onModify(formula());
    //reflect(target).setField(field, formula());
  }

  void unmodify(target) {
    onModify(-formula());
    //reflect(target).setField(field, -1 * formula());
  }

  void onModify(num value);

  num formula();
}

abstract class Effect {
  String get desc;

  void effect();

//  void onEffect();
}

class Model {
  bool _die;

  bool get die => _die;


  void update() {
  }

//
//  @override
//  add(View child) {
//    if (child is State) {
//      var me = this as StateHost;
//      me._addState(child);
//    } else if (child is Action) {
//      var me = this as ActionHost;
//      me._addAction(child);
//    } else if (child is Monster) {
//      var me = this as Game;
//      me._addMonster(child);
//    } else if (child is Role) {
//      var me = this as RoleHost;
//      me._addRole(child);
//      me.teamPanel.addRole(child);
//    } else if (child is Item) {
//      var me = this as ItemHost;
//      me._addItem(child);
//    } else {
//      super.addChild(child);
//    }
//  }
//
//
//  @override
//  remove(View child) {
//
//    if (child is State) {
//      var me = this as StateHost;
//      me._removeState(child);
//    } else if (child is Action) {
//      var me = this as ActionHost;
//      me._removeAction(child);
//    } else if (child is Monster) {
//      var me = this as Game;
//      me._removeMonster(child);
//    } else if (child is Role) {
//      var me = this as RoleHost;
//      me._removeRole(child);
//      me.teamPanel.removeRole(child);
//    } else if (child is Item) {
//      var me = this as ItemHost;
//      me._removeItem(child);
//    } else {
//      super.removeChild(child);
//    }
//  }

//  @override
//  GameEntity get parent => getGameParent(this);

//  GameEntity getGameParent(View entity) {
//    if (entity.entityParent is GameEntity) return entity.entityParent;
//    return getGameParent(entity.entityParent);
//  }
}
