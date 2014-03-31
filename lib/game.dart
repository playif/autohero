library model;
import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'view.dart';

part 'action.dart';
part 'item.dart';
part 'monster.dart';
part 'team.dart';
part 'role.dart';

part 'site.dart';
part 'state.dart';
part 'dict.dart';

Game game;

class GameEntity extends View {

  @override
  add(View child) {
    if (child is State) {
      var me = this as StateHost;
      me._addState(child);
    } else if (child is Action) {
      var me = this as ActionHost;
      me._addAction(child);
    } else if (child is Monster) {
      var me = this as Game;
      me._addMonster(child);
    } else if (child is Role) {
      var me = this as RoleHost;
      me._addRole(child);
    } else if (child is Item) {
      var me = this as ItemHost;
      me._addItem(child);
    } else {
      super.addChild(child);
    }
  }


  @override
  remove(View child) {

    if (child is State) {
      var me = this as StateHost;
      me._removeState(child);
    } else if (child is Action) {
      var me = this as ActionHost;
      me._removeAction(child);
    } else if (child is Monster) {
      var me = this as Game;
      me._removeMonster(child);
    } else if (child is Role) {
      var me = this as RoleHost;
      me._removeRole(child);
    } else if (child is Item) {
      var me = this as ItemHost;
      me._removeItem(child);
    } else {
      super.removeChild(child);
    }
  }

  @override
  GameEntity get parent => getGameParent(this);

  GameEntity getGameParent(View entity) {
    if (entity.entityParent is GameEntity) return entity.entityParent;
    return getGameParent(entity.entityParent);
  }
}

class RoleHost {
  final List<Role> roles = [];
  final View rolePanel = new View();

  void _addRole(Role role) {
    role.init();
    roles.add(role);
    rolePanel.addChild(role);
  }

  void _removeRole(Role role) {
    roles.remove(role);
    rolePanel.removeChild(role);
  }
}

class SiteHost {
  final View infoPanel = new View();
  Site _currentSite = StartLand();

  Site get currentSite => _currentSite;

  int get siteLevel => _currentSite.level;

  List<Site> _sites = [StartLand(), StartLand2()];

  List<Site> get sites => _sites;

  View sitePanel = new View();

  set siteLevel(int level) {
    _currentSite.level = level;
  }

  void setSite(Site site) {
    infoPanel.remove(_currentSite);
    infoPanel.add(site);
    //_currentSite

    _currentSite = site;

    //site.init();
    //sites.add(site);
    //sitePanel.addChild(role);
  }


//  void _removeSite(Site site) {
//    //roles.remove(role);
//    //rolePanel.removeChild(role);
//  }
}


abstract class Game extends GameEntity with RoleHost, SiteHost, ItemHost {
  num _dt;

  num get deltaTime => _dt;

  Map<String, int> _items = new Map<String, int>();

  //  Map<String, int> get items => _items;
  List<Monster> _monsters = new List<Monster>();

  List<Monster> get monsters => _monsters;


  int money = 0;

  //int get money => _money;
  int _research = 0;

  int get research => _research;

  View menuPanel = new View();
  View contentPanel = new View();

  View monsterPanel = new View();
  View battlePanel = new View();


  View currentPanel;

  //  Entity itemPanel = new Entity();
  //View root = new View();

  View body = new View();

  bindBodyPanel(View panel) {
    panel.watch('width', body, 'width');
    panel.watch('height', body, 'height');
    body.add(panel);
  }

  Game() {
    //this.watch('width',this,'width');

    body.watch('width', this, 'width', transform:(s) => s - 200);
    body.watch('height', contentPanel, 'height');

    bindBodyPanel(battlePanel);
    bindBodyPanel(itemPanel);
    bindBodyPanel(sitePanel);

    itemPanel.vertical = false;
    itemPanel.wrap = true;

    battlePanel.vertical = false;
    battlePanel.add(rolePanel);
    battlePanel.add(monsterPanel);

    rolePanel.width = 200;
    rolePanel.watch('height', body, 'height');

    monsterPanel.watch('height', body, 'height');
    monsterPanel.watch('width', body, 'width', transform:(s) => s - rolePanel.width);
    monsterPanel.cellMargin = 5;
    monsterPanel.vertical = false;
    monsterPanel.wrap = true;

    menuPanel.height = 70;
    menuPanel.watch('width', this, 'width');
    menuPanel.cellMargin = 15;
    menuPanel.vertical = false;

    infoPanel.watch('height', contentPanel, 'height');
    infoPanel.width = 200;

    contentPanel.watch('height', this, 'height', transform:(s) => s - 70);
    contentPanel.watch('width', this, 'width');
    contentPanel.vertical = false;

    //infoPanel.vertical = false;

    add(menuPanel);
    add(contentPanel);
    contentPanel.add(infoPanel);
    contentPanel.add(body);


    showPanel(battlePanel);

    //    setSite(StartLand());
    //    var moneyLabel = ;

    infoPanel.border = 0;

    infoPanel.add(new Label()
      ..text = '資訊版面');

    infoPanel.add(new Label()
      ..name = "金幣: "
      ..watch('text', this, 'money', transform:(m) {
      return "<b>$m</b>";
    }));


    sites.forEach((s) {
      s.init();
      SiteButton siteButton = new SiteButton();
      siteButton.site = s;
      siteButton.init();
      sitePanel.add(siteButton);
    });

    setSite(sites[0]);
    //sitePanel.add()


    add(RedPotion());
    add(RedPotion());

    _resetWindowSize();
    window.onResize.listen((e) {
      _resetWindowSize();
    });
  }

  //  updateView() {
  //
  //
  //
  //    super.updateView();
  //  }


  void showPanel(View panel) {
    body.children.forEach((p) {
      p.visible = false;
    });
    //    battlePanel.visible = false;
    //    itemPanel.visible = false;
    //    sitePanel.visible = false;
    //    battlePanel.style.display = "none";
    //    itemPanel.style.display = "none";
    //    panel.style.display = "-webkit-flex";
    //    panel.style.display = "flex";


    //    battlePanel.height = 0;
    //    itemPanel.height = 0;

    panel.visible = true;
    //    panel.height = height - 140;
    currentPanel = panel;
    updateView();
  }


  _resetWindowSize() {
    height = window.innerHeight;
    width = window.innerWidth;
    document.body.style.height = '${height}';
    //    document.body.style.maxHeight = '${width}';
  }

  void removeAllMonsters() {
    monsters.forEach((m) => m.leave());
  }

  Monster getFirstMonster() {
    if (monsters.length > 0) {
      return monsters.firstWhere((m) => !m.die);
    } else return null;
  }

  List<Monster> getAllMonster() {
    if (monsters.length > 0) {
      return monsters.where((m) => !m.die);
    } else return null;
  }

  void _addMonster(Monster monster) {
    monster.init();
    monsters.add(monster);
    monsterPanel.addChild(monster);
  }

  void _removeMonster(Monster monster) {
    monsters.remove(monster);
    monsterPanel.removeChild(monster);
  }


  void obtainExp(num xp) {
    var n = roles.length;
    num rxp = xp / n;

    for (int i = 0;i < roles.length;i++) {
      roles[i].XP += rxp;
      roles[i].check();
    }
  }

  void obtainMoney(num money) {
    this.money += money;
  }

  void obtainLoot(Item item) {
    add(item);
  }

  Monster createMonster() {
    return currentSite.createMonster();
  }

  void init();

  void start([Duration dt = const Duration(milliseconds: 100)]) {
    init();
    document.body.children.add(element);
    this._dt = dt.inMilliseconds;
    Timer timer = new Timer.periodic(dt, _update);
  }

  void _update(Timer timer) {


    if (monsters.length == 0) {
      var max = rand.nextInt(currentSite.maxMonster);
      for (int i = 0;i < max;i++) {
        add(createMonster());
      }
      currentSite.progress();
    }


    checkBindings();
    _updateEntities(this);
  }

  void _updateEntities(View entity) {
    for (int i = 0; i < entity.children.length; i++) {
      var e = entity.children[i];
      if (e.die) {
        if (e.parent == null) {
          throw new Exception('No parent!');
        } else {
          e.parent.remove(e);
        }
        i--;
        continue;
      }
      if (e is Updatable) {
        e.update();
      }
      _updateEntities(e);
    }
    entity.updateView();
  }
}
