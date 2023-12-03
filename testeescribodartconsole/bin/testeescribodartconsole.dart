import 'dart:io';

void main(List<String> arguments) {
  int comando;

  print('Olá, seja bem vindo(a)!');

  do {
    print('Digite uma das opções a seguir:');
    print('1 - calcular um número;');
    print('2 - sair.');
    stdout.write('Opção:\t');

    comando = int.parse(stdin.readLineSync()!);

    if (comando == 1) {
      int soma = 0;
      int numero;

      do {
        print('\nDigite o número a ser calculado');
        stdout.write('Número:\t');
        numero = int.parse(stdin.readLineSync()!);

        if (numero < 0) {
          stdout.writeln('\nNúmeros negativos não são permitidos!');
        } else {
          soma = somar(numero);
        }
      } while (numero < 0);

      print('');
      print('A soma é: $soma');
    } else if (comando == 2) {
      print('\nSaindo...');
    } else {
      print('\nOpção inválida!');
    }

    print('');
  } while (comando != 2);
}

int somar(int numero) {
  int soma = 0;

  for (var i = 0; i < numero; i++) {
    if (i % 3 == 0 || i % 5 == 0) {
      soma += i;
    }
  }

  return soma;
}
