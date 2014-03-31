part of model;

/*
道具有分裝備品、消耗品、和收藏品。

*/

class ItemHost {
  List<Item> items = [];
  final View itemPanel = new View();

  _addItem(Item item) {
    item.init();
    items.add(item);
    itemPanel.addChild(item);
  }

  _removeItem(Item item) {
    items.remove(item);
    itemPanel.removeChild(item);
    //owner.removeChild(action);
  }
}


class Item extends GameEntity {
  String name = "item";
  bool stack = true;
  int price = 0;


  //  Effect onUse = null;


  init() {
    width = 100;
    height = 100;
    border = 1;

    add(text(name));

  }

}


Consumable RedPotion() {
  Consumable item = new Consumable()
    ..name = "紅藥水";


  return item;
}


typedef void Attribute(Role role, num value);

Attribute DAMAGE = (Role role, num value) {
  role.damage += value;
};

Attribute DAMAGE_Modify = (Role role, num value) {
  role.damage += value;
};

Item Dagger() {
  Weapon item = new Weapon();
  item
    ..name = "匕首"
    ..fomulas[DAMAGE] = () {
    return 1 + item.level + item.quality;
  };
  return item;
}

Item ShortSword() {
  Weapon item = new Weapon();
  item
    ..name = "短劍"
    ..fomulas[DAMAGE] = () {
    return 4 + 2 * item.level * item.quality;
  };
  return item;
}

Item Sword() {
  Weapon item = new Weapon();
  item
    ..name = "劍"
    ..fomulas[DAMAGE] = () {
    return 12 + 4 * item.level * item.quality;
  };
  return item;
}


typedef void BuffFunc(Weapon item);

SuperStrong(Weapon item) {
  item
    ..name = "鋒利的 " + item.name
    ..fomulas[DAMAGE_Modify] = () {
    return item.level * item.quality;
  };
}

Potion(Weapon item) {
  item
    ..name = "劇毒 " + item.name
    ..fomulas[DAMAGE_Modify] = () {
    return item.level * item.quality;
  };
}

//5000 500 50 5 2 1
Map<BuffFunc, int> QualityProb = {
    Normal:300000, Rare:10000, Perfect:500, Epic:50, Legendary:10, Mystery:1
};

Dict<BuffFunc> QualityBuff = new Dict<BuffFunc>(QualityProb, [Normal, Rare, Perfect, Epic, Legendary, Mystery]);


//2~3稀有(藍) 4~5完美(綠) 6~8史詩(亮黃) 9~11傳奇(暗黃) 12~15神話(紅)

Normal(Weapon item) {
  item
    ..name = item.name
    ..quality = 1;
}

Rare(Weapon item) {
  item
    ..name = item.name + "(稀有)"
    ..quality = rand.nextInt(2) + 2;
}

Perfect(Weapon item) {
  item
    ..name = item.name + "(完美)"
    ..quality = rand.nextInt(2) + 4;
}

Epic(Weapon item) {
  item
    ..name = item.name + "(史詩)"
    ..quality = rand.nextInt(3) + 6;
}

Legendary(Weapon item) {
  item
    ..name = item.name + "(傳奇)"
    ..quality = rand.nextInt(3) + 9;
}

Mystery(Weapon item) {
  item
    ..name = item.name + "(神話)"
    ..quality = rand.nextInt(4) + 12;
}
//Map<String, Item> ItemMap = {
//  "a": new Item(),
//};
typedef void Effect(Role role);

typedef num Fomula();


class Weapon extends Item {
  final Map<Attribute, Fomula> fomulas = {
  };

  //  int operator []=(String fomula){
  //    return fomulas[fomula]();
  //  }

  int quality = 1;

  int _level = 1;

  int get level => _level;

  Role _role;

  set level(int value) {
    Role role = _role;
    unequip();
    _level = value;
    equip(role);
  }


  void equip(Role role) {
    _role = role;
    for (var a in fomulas.keys) {
      a(_role, fomulas[a]());
    }
    //onEquip(role);
  }

  void unequip() {
    //onEquip(role);
    for (var a in fomulas.keys) {
      a(_role, -1 * fomulas[a]());
    }
    _role = null;
  }


//  Effect onEquip = null;
//  Effect onUnequip = null;
}


class Consumable extends Item {
  int number;


  final Map<Attribute, Fomula> fomulas = {
  };

  use() {

  }

  //Effect onUse = null;

  @override
  init() {
    super.init();

    onClick.listen((e) {
      print("hi");
    });


  }
}


class Treasure extends Item {
  int number;


  Effect onObtain = null;
//  Effect onLost = null;

}
