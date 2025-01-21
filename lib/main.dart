import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//é um ficheiro do flutter que nos fornece algumas funcionalidades neste caso vai bloquear a orientção do ecrã

import 'package:expense_tracker/widgets/expenses.dart';

// Esquema de cores para o tema claro
var kColorScheme = ColorScheme.fromSeed(
  seedColor:
      const Color.fromARGB(255, 96, 59, 181), // Cor base para gerar o esquema
);

// Esquema de cores para o tema escuro
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark, // Define o brilho como escuro
  seedColor:
      const Color.fromARGB(255, 5, 99, 125), // Cor base para gerar o esquema
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // //Diz que a app só pode ser usada da forma vertical
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme, // Aplica o esquema de cores escuro
        cardTheme: const CardTheme().copyWith(
          color:
              kDarkColorScheme.secondaryContainer, // Cor de fundo dos cartões
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme
                .primaryContainer, // Cor de fundo dos botões elevados
            foregroundColor:
                kDarkColorScheme.onPrimaryContainer, // Cor do texto
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme, // Aplica o esquema de cores claro
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor:
              kColorScheme.onPrimaryContainer, // Cor de fundo da AppBar
          foregroundColor:
              kColorScheme.primaryContainer, // Cor do texto e ícones
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer, // Cor de fundo dos cartões
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme
                .primaryContainer, // Cor de fundo dos botões elevados
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold, // Define o texto como negrito
                color: kColorScheme.onSecondaryContainer, // Cor do texto
                fontSize: 16, // Tamanho da fonte
              ),
            ),
      ),
      // themeMode: ThemeMode.system, // Utiliza o tema baseado no sistema do utilizador
      home: const Expenses(), // Define o widget inicial da aplicação
    ),
  );
  // });
}
