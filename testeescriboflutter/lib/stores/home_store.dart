import 'package:flutter/material.dart';
import 'package:testeescriboflutter/controllers/home_controller.dart';

// aqui é feito o gerenciamento de estado da view
class HomeStore extends ChangeNotifier {
  final controller = HomeController();

  bool isLoading = false;
  String error = '';
  int sum = 0;

  void resetSum() {
    sum = 0;
    notifyListeners();
  }

  void getSum(int value) async {
    isLoading = true;
    error = '';
    notifyListeners();

    try {
      sum = await controller.fetchSum(value);
      error = '';
      notifyListeners();
    } catch (e) {
      error = e.toString().replaceAll('Exception', 'Erro');
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
