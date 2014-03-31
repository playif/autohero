library model;

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
