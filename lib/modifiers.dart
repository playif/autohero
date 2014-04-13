part of game;

Map a = {
    'x':() {
    },


};

Map target = {
};

const String caster = 'caster';

class AttackSingleTarget extends Effect {
  String get desc {
    return '';
  }

  //num amount=0;

  //num attack=1;

  effect() {
    var role = target[caster] as Role;
    var monster = target[target] as Monster;
    monster.HP -= role.damage;
  }

//  formula() {
//    var role=target[caster] as Role;
//    return role.damage;
//  }
//
//  onModify(num value){
//    var monster=target[target] as Monster;
//    monster.HP-=value;
//    //role.damage+=value;
//    //role.actions
//  }

}

class WeaponDamageBuff extends Modifier {

  String get desc {
    return '';
  }

  formula() {
    var weapon = target[caster] as Weapon;

    //var role=target[caster];
    return weapon.baseDamage * (0.9 + weapon.quality * 0.1) *
    pow((1.1 + weapon.levelQuality * 0.01), weapon.level) +
    weapon.levelBonus * weapon.level;
  }

  onModify(num value) {
    var role = target[target] as Role;
    role.damage += value;
  }
}
