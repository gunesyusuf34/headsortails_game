import 'package:flutter/material.dart';

class InitialCredit extends ChangeNotifier{
  int initialCredit = 0;

  void setCredit(int amount){
    initialCredit = amount;
    notifyListeners();
  }
  int readInitialCredit(){
    return initialCredit;
  }
}

class ProfitPerRound extends ChangeNotifier{
  int profitPerRound = 0;

  void setProfitPerRound(TextEditingController controller){
    profitPerRound = int.parse(controller.text);
    notifyListeners();
  }
  int readProfitPerRound(){
    return profitPerRound;
  }
}

class RiskPerRound extends ChangeNotifier{
  int riskPerRound = 0;

  void setRiskPerRound(TextEditingController controller){
    riskPerRound = int.parse(controller.text);
    notifyListeners();
  }
  int readRiskPerRound(){
    return riskPerRound;
  }
}

class TotalProfit extends ChangeNotifier{
  int totalProfit = 0;

  void setTotalProfit(int amount){
    totalProfit = amount;
    notifyListeners();
  }
  int readTotalProfit(){
    return totalProfit;
  }
}