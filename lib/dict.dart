part of dungeon;

int PROB = 100;

Random rand = new Random();

typedef T Creator<T>();


//class Dict<T> {
//  Map<Creator<T>, int> _map;
//
//  List<Creator<T>> _list;
//
//  int _max = 0;
//
//  Dict(this._map, this._list) {
//    for (var i in _list) {
//      if (_map.containsKey(i)) {
//        _max += _map[i];
//      } else {
//        _max += PROB;
//      }
//    }
//  }
//
//  T pick() {
//    int r = rand.nextInt(_max);
//    for (var i in _list) {
//      int cp = 0;
//      if (_map.containsKey(i)) {
//        cp = _map[i];
//      } else {
//        cp = PROB;
//      }
//
//      if (cp > r) {
//        return i();
//      } else {
//        r -= cp;
//      }
//    }
//    return null;
//  }
//
//  List<T> pickN(int n){
//    List<T> list=[];
//    for(int i=0;i<n;i++){
//      list.add(pick());
//    }
//    return list;
//  }
//}

class Dict<T> {
  Map<T, int> _map;

  List<T> _list;

  int _max = 0;

  Dict(this._map, this._list) {
    for (var i in _list) {
      if (_map.containsKey(i)) {
        _max += _map[i];
      } else {
        _max += PROB;
      }
    }
  }

  T pick() {
    int r = rand.nextInt(_max);
    for (var i in _list) {
      int cp = 0;
      if (_map.containsKey(i)) {
        cp = _map[i];
      } else {
        cp = PROB;
      }

      if (cp > r) {
        return i;
      } else {
        r -= cp;
      }
    }
    return null;
  }

  List<T> pickN(int n) {
    List<T> list = [];
    for (int i = 0;i < n;i++) {
      list.add(pick());
    }
    return list;
  }

  List<T> pickNUnique(int n) {
    if (n > _list.length)n = _list.length;
    List<T> list = [];
    for (int i = 0;i < n;i++) {
      T p = pick();
      if (list.contains(p)) {
        i--;
        continue;
      }
      list.add(p);
    }
    return list;
  }
}