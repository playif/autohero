part of model;

class GameInfoPanel extends View {


  init() {
    border = 0;

    add(new Label()
      ..text = '資訊版面'
      ..style.backgroundColor = 'gray'
      ..size = 32);
    //infoPanel.breakLine();
    add(new Label()
      ..name = "金幣: "
      ..watch('text', game, 'money', transform:(m) {
      return "<b>$m</b>";
    }));

  }
}



