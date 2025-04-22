import 'dart:math';
import 'package:animasyon_deneme1/credit_amount_provider.dart';
import 'package:animasyon_deneme1/entance_page.dart';
import 'package:animasyon_deneme1/game_page.dart';
import 'package:animasyon_deneme1/gamecoin_class.dart';
import 'package:animasyon_deneme1/pre_game_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EndGamePage extends StatefulWidget {
  const EndGamePage({super.key});

  @override
  State<EndGamePage> createState() => _EndGamePageState();
}

class _EndGamePageState extends State<EndGamePage> {
  var gamecoin = gameCoin();

  late int totalCredit;
  late int totalProfit;

  @override
  void initState() {
    super.initState();
    totalCredit = context.read<InitialCredit>().readInitialCredit();
    totalProfit = context.read<TotalProfit>().readTotalProfit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 36, bottom: 86),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300,
                padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "GAME FINISHED",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.deepPurpleAccent.shade400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "RESULTS",
                        style: TextStyle(fontSize: 26,color: Colors.deepPurpleAccent.shade400),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Credit :",style: TextStyle(fontSize: 22),),
                          Text("$totalCredit \$",style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent.shade400),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Profit :",style: TextStyle(fontSize: 22),),
                          Text("$totalProfit \$",style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent.shade400),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gamecoin.tail,
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationX(pi/2*0.9),
                    child: Container(
                      width: 150,height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 165,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent.shade400,elevation: 4),
                  child: Text(
                    "PLAY AGAIN ?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PreGamePage()),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          child: Icon(Icons.home),
          onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => EntrancePage()),
                  (Route<dynamic> route) => false,
            );
          },
      ),
    );
  }
}
