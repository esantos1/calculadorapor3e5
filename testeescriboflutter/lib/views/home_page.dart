import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testeescriboflutter/stores/home_store.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController fieldController;
  int numberValue = 0;
  final store = HomeStore();

  @override
  void initState() {
    super.initState();

    fieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    fieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyFontStyle = Theme.of(context).textTheme.bodyLarge!;
    var offWhiteColor = Color(0xffFAF9F6);

    return ListenableBuilder(
      listenable: store,
      builder: (context, child) {
        final body = _getBody(offWhiteColor, bodyFontStyle, context);

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            child: Center(key: ValueKey(body), child: body),
          ),
        );
      },
    );
  }

  // de acordo com o estado, irá retornar o widget especificado
  Widget _getBody(
      Color offWhiteColor, TextStyle bodyFontStyle, BuildContext context) {
    if (store.isLoading) {
      return Center(child: CircularProgressIndicator(color: offWhiteColor));
    } else if (store.error.isNotEmpty) {
      return _errorBody(bodyFontStyle, offWhiteColor);
    } else if ((store.sum > 0 && numberValue > 0) ||
        (store.sum == 0 && numberValue > 0)) {
      return _sucessSumBody(bodyFontStyle, offWhiteColor);
    } else {
      return _initialBody(context, bodyFontStyle, offWhiteColor);
    }
  }

  // quando store.sum for 0
  Widget _initialBody(
      BuildContext context, TextStyle bodyFontStyle, Color offWhiteColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Digite um número a ser calculado:',
          style: bodyFontStyle.copyWith(color: offWhiteColor),
        ),
        SizedBox(height: 16),
        FractionallySizedBox(
          widthFactor: 0.74,
          child: TextField(
            controller: fieldController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              fillColor: offWhiteColor,
              prefixIcon: Icon(
                Icons.numbers,
                color: Theme.of(context).primaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onChanged: onFieldChanged,
            onSubmitted: (value) => calculate(),
          ),
        ),
        SizedBox(height: 40),
        FractionallySizedBox(
          widthFactor: 0.45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10),
              backgroundColor: offWhiteColor,
            ),
            onPressed: calculate,
            child: Text('Calcular', style: TextStyle(fontSize: 16.0)),
          ),
        ),
      ],
    );
  }

  // quando store.sum for diferente de 0 (significa que houve soma)
  Widget _sucessSumBody(TextStyle bodyFontStyle, Color offWhiteColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Resultado da soma:',
          style: bodyFontStyle.copyWith(color: offWhiteColor),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: offWhiteColor),
            borderRadius: BorderRadius.circular(50),
            color: offWhiteColor,
          ),
          child: Text(
            '${store.sum}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        SizedBox(height: 32),
        FractionallySizedBox(
          widthFactor: 0.6,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10),
              backgroundColor: offWhiteColor,
            ),
            onPressed: () {
              numberValue = 0;

              store.resetSum();
            },
            child: Text(
              'Calcular com novo número',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }

  // caso haja um erro
  Widget _errorBody(TextStyle bodyFontStyle, Color offWhiteColor) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Digite um número a ser calculado:',
            style: bodyFontStyle.copyWith(color: offWhiteColor),
          ),
          SizedBox(height: 16),
          FractionallySizedBox(
            widthFactor: 0.45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                backgroundColor: offWhiteColor,
              ),
              onPressed: calculate,
              child: Text(
                'Tentar novamente',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      );

  void onFieldChanged(String value) {
    if (fieldController.text.isNotEmpty) {
      numberValue = int.parse(value);
    } else {
      numberValue = 0;
    }
  }

  // função que chama o calculo na store
  void calculate() {
    if (fieldController.text.isEmpty) {
      showCustomSnackBar('Por favor, insira um valor para calcular.');
    } else if (numberValue < 0) {
      showCustomSnackBar('Números negativos não são permitidos!');
    } else {
      store.getSum(numberValue);

      fieldController.clear();
    }
  }

  void showCustomSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
}
