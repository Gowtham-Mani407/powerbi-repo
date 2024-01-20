import 'package:flutter/cupertino.dart';

class listnumprovider extends ChangeNotifier {
  List<int> num = [1, 2, 3, 4];

  void add() {
    num.add(num.last + 1);
    notifyListeners();
  }

  void restart() {
    if (num.length > 4) {
      num.remove(num.last);
    }
    notifyListeners();
  }
}
