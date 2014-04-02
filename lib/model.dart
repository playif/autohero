//part of model;
library model;

@MirrorsUsed(targets: const ['model'])
import 'dart:mirrors';

typedef num Formula();

Map<String, String> AttributeName = {
    'HP':'生命',
    'damage':'傷害',
    'damage2':'傷害',
};

//Map<String, List<num>> AttributeEffect = {
//    'HP':'生命',
//    'damage':'傷害',
//    'damage2':'傷害',
//
//};

//Map<String, Modifier> Modifiers = {
//    "": new Modifier('HP', [20]), };


const Modifier HPAdd =
const Modifier('HP', const [5, 10, 20]);

const Modifier DamageAdd =
const Modifier('HP', const [5, 10, 20]);


//class Formula {
//  String name;
//
//  num call() {
//
//  }
//
//}

class ModifierModel {
  int level = 1;
  final List<Modifier> _modifiers = [];

  addModifier(String field, List effect) {
    _modifiers.add(new Modifier(field, effect));
  }

  modify(target) {
    _modifiers.forEach((m) {
      m._setValue(target, level, 1);
    });

  }

  unmodify(target) {
    _modifiers.forEach((m) {
      m._setValue(target, level, -1);
    });
  }

//  View createInfoView(){
//    View view=new View();
//    view.width=200;
//
//  }
}

//class ModifierSet extends Modifier{
//
//}

class Modifier {
//  final String name;
//  final Symbol field;
  final String fieldName;

//  final String desc;
  final List<num> effect;

  //final Formula formula;

  const Modifier(String fieldName, this.effect):
  fieldName=fieldName;

//  field=new Symbol(fieldName);

//  modify(target) {
//    _setValue(target, formula());
//  }
//
//  unmodify(target) {
//    _setValue(target, -1 * formula());
//  }

  void _setValue(target, int level, int inv) {
    var im = reflect(target);
    var sym = new Symbol(fieldName);
    var val = im.getField(sym).reflectee;
    if (level > effect.length) {
      level = effect.length;
    }
    else if (level <= 0) {
      level = 1;
    }
    im.setField(sym, val + (effect[level - 1] * inv));
  }

  String get name => AttributeName[fieldName];
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
