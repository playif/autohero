const DELTA_TIME = 100;

class TimeWatcher {
  int _activeTime = 0;
  int _timerCounter = 0;
  bool _timeUP = false;

  bool get timeUP => _timeUP;

  void init(int miniSecond, int delay) {
    _activeTime = miniSecond;
    _timerCounter = -delay;
    _timeUP = false;
  }

  bool update() {
    _timerCounter += DELTA_TIME;
    if (_timerCounter >= _activeTime) {
      _timeUP = true;
    }
    return _timeUP;
  }

  void reset([int delay=0]) {
    _timeUP = false;
    _timerCounter = -delay;
  }

//  void active() {
//  }
//
//  void timeUp() {
//  }
}