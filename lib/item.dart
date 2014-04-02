part of model;

/*
道具有分裝備品、消耗品、和收藏品。

*/
class ItemPanel extends View {

  ItemPanel() {
    vertical = false;

    wrap = true;
    cellMargin = 15;
    bindList(inventoryItems, ItemView);
  }

  Map<Item, View> views = {
  };
/*
  @override
  void handleMsg(String msg, data) {
    if (msg == ADD_INVENTORY_ITEM) {
      ItemView view = new ItemView(data);
      add(view);
      views[data] = view;
    }
    if (msg == REMOVE_INVENTORY_ITEM) {
      //ItemView view = new ItemView(data);
      remove(views[data]);
      views.remove(data);
    }
  }*/
}

class ItemView extends View {

  final Item item;

  ItemView(this.item);

  init() {
    width = 100;
    height = 100;
    border = 1;


    add(text(item.name));

    onClick.listen((e) {
      if (game.currentItemIndex != -1) {
        int index = inventoryItems.indexOf(this.item);
        var item = inventoryItems[index];

        inventoryItems[index] = inventoryItems[game.currentItemIndex];

        inventoryItems[game.currentItemIndex] = item;

        //        itemPanel.children.sort((ItemView a, ItemView b) {
        //          if (inventoryItems.indexOf(a.item) > inventoryItems.indexOf(b.item)) {
        //            return 1;
        //          } else if (inventoryItems.indexOf(a.item) > inventoryItems.indexOf(b.item)) {
        //            return -1;
        //          } else return 0;
        //        });


        print(game.currentItemIndex);
        //        itemPanel.children.forEach((ItemView i) {
        //          itemPanel.element.append(i.element);
        //        });

        //TODO change


        game.currentItemIndex = -1;
        return;
      }
      //print(game.currentItemIndex);
      game.currentItemIndex = inventoryItems.indexOf(this.item);
      setToolTip(new Label()
        ..text = item.name);
    });
  }

  onShow() {
    game.currentItemIndex = -1;
  }
/* TODO for con
  @override
  init() {
    super.init();

    onClick.listen((e) {
      print("hi");
    });


  }*/
}

class WeaponSelectPanel extends View {

  WeaponSelectPanel() {
    vertical = false;
    wrap = true;
    cellPadding = 15;
    cellMargin = 5;
    width = 600;
    height = 400;
    top = 100;
    left = 100;
    layout = false;
    visible = false;
    style.backgroundColor = 'gray';
    style.zIndex = '2000';

    Button cancel = new Button();
    cancel.text = "取消";
    cancel.size = 30;
    cancel.layout = false;
    cancel.top = 330;
    cancel.left = 510;
    cancel.onClick.listen((e) {
      hideWeapons();
    });
    add(cancel);
    add(new WeaponView(Slot()));

    bindList(inventoryItems, WeaponView, (List list) => list.where((Item s) => s is Weapon).toList());
  }

  Map<Item, View> views = {
  };

//  @override
//  void handleMsg(String msg, data) {
//    if (msg == ADD_INVENTORY_ITEM && data is Weapon) {
//      WeaponView view = new WeaponView(data);
//
//      add(view);
//
//      views[data] = view;
//    } else if (msg == REMOVE_INVENTORY_ITEM && data is Weapon) {
//      remove(views[data]);
//      views.remove(data);
//    }
//  }
}

class WeaponView extends View {

  final Weapon item;

  WeaponView(this.item);

  init() {
    width = 100;
    height = 100;
    border = 1;

    add(text(item.name));

    onClick.listen((e) {

      if (parent is WeaponSelectPanel) {
        hideWeapons();
        unEquip(game.currentItem, game.currentRole);
        equip(this.item, game.currentRole);
      } else {
        game.currentItem = this.item;
        game.currentWeaponIndex = game.currentRole.weapons.indexOf(this.item);
        showWeapons();
      }

    });
  }
/* TODO for con
  @override
  init() {
    super.init();

    onClick.listen((e) {
      print("hi");
    });


  }*/
}

class Item extends Model {
  String name = "item";
  bool stack = true;
  int price = 0;


//  Effect onUse = null;


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

Item Slot() {
  Weapon item = new Weapon();
  item
    ..name = "空格";
  return item;
}

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

  //  Role _role;

  setlevel(int value, Role role) {
    //    Role role = _role;
    unequip(role);
    _level = value;
    equip(role);
  }


  void equip(Role role) {
    //    _role = role;
    for (var a in fomulas.keys) {
      a(role, fomulas[a]());
    }
    //onEquip(role);
  }

  void unequip(Role role) {
    //onEquip(role);
    for (var a in fomulas.keys) {
      a(role, -1 * fomulas[a]());
    }
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


}


class Treasure extends Item {
  int number;


  Effect onObtain = null;
//  Effect onLost = null;

}
