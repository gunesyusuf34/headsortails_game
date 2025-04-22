import 'package:animasyon_deneme1/credit_amount_provider.dart';
import 'package:animasyon_deneme1/entance_page.dart';
import 'package:animasyon_deneme1/game_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>InitialCredit()),
        ChangeNotifierProvider(create: (context)=>ProfitPerRound()),
        ChangeNotifierProvider(create: (context)=>RiskPerRound()),
        ChangeNotifierProvider(create: (context)=>TotalProfit()),
      ],
      child: MaterialApp(
        title: 'Heads or Tails',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const EntrancePage(),
      ),
    );
  }
}