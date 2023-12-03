// função responsável por fazer a soma
class HomeController {
  Future<int> fetchSum(int value) async {
    int soma = 0;

    for (var i = 0; i < value; i++) {
      if (i % 3 == 0 || i % 5 == 0) {
        soma += i;
      }
    }

    return soma;
  }
}
