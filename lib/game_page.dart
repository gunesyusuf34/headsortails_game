import 'dart:math';

import 'package:animasyon_deneme1/credit_amount_provider.dart';
import 'package:animasyon_deneme1/end_game_page.dart';
import 'package:animasyon_deneme1/gamecoin_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin{

  late AnimationController animasyonKontrol;
  late Animation<double> animasyondeger;

  late AnimationController entranceexitAnimationControl;
  late Animation headerAnimation;
  late Animation buttonAnimation;
  late Animation fabAnimation;

  var gamecoin = gameCoin();

  int sayi=0;
  int totalCredit = 0;
  int totalProfit = 0;
  int profitPerRound = 0;
  int riskPerRound = 0;
  int round = 0;
  int totalWin = 0;
  int totalLost = 0;
  int selection = 0;
  String choice = "";
  String result = "";

  Future<void> headOrTail(int mySelection)async{
    selection = mySelection;
    if(selection==0){choice="Choice: TAIL";}
    if(selection==1){choice="Choice: HEAD";}
    setState(() {});
  }

  Future<void> animasyonCalistir() async{
    animasyonKontrol.reset();
    round = round+1;
    setState(() {result="";});
    int sayi = await Random().nextInt(2);
    animasyondeger = Tween(begin: 0.0,end: -(10-sayi)*pi,)
        .animate(CurvedAnimation(parent: animasyonKontrol, curve: Curves.ease))
      ..addListener((){
        setState(() {});
      });
    await animasyonKontrol.forward();
    if(sayi==selection){
      result="WIN";
      totalWin = totalWin+1;
      totalCredit = totalCredit + profitPerRound;
      totalProfit = totalProfit + profitPerRound;
    } else{
      result="LOST";
      totalLost = totalLost+1;
      totalCredit = totalCredit - riskPerRound;
      totalProfit = totalProfit - riskPerRound;
    }
    setState(() {});
    print(profitPerRound);
    print(riskPerRound);
    print(totalCredit);
  }
  Future<void> finishGame()async{
    animasyonKontrol.stop();
    animasyonKontrol.reset();
    context.read<InitialCredit>().setCredit(totalCredit);
    context.read<TotalProfit>().setTotalProfit(totalProfit);
    await entranceexitAnimationControl.reverse();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => EndGamePage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    animasyonKontrol = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    animasyondeger = AlwaysStoppedAnimation(0.0);
    
    totalCredit = context.read<InitialCredit>().readInitialCredit();
    profitPerRound = Provider.of<ProfitPerRound>(context, listen: false).profitPerRound;
    riskPerRound = Provider.of<RiskPerRound>(context,listen: false).riskPerRound;

    entranceexitAnimationControl = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    headerAnimation = Tween(begin: -350.0, end: 0.0)
        .animate(CurvedAnimation(parent: entranceexitAnimationControl, curve: Curves.elasticInOut))
      ..addListener((){ setState(() {}); });
    buttonAnimation = Tween(begin: 350.0, end: 0.0)
        .animate(CurvedAnimation(parent: entranceexitAnimationControl, curve: Curves.elasticInOut))
      ..addListener((){ setState(() {}); });
    fabAnimation = Tween(begin: 180.0, end: 0.0)
        .animate(CurvedAnimation(parent: entranceexitAnimationControl, curve: Curves.elasticInOut))
      ..addListener((){ setState(() {}); });
    entranceexitAnimationControl.forward();

  }
  @override
  void dispose() {
    super.dispose();
    animasyonKontrol.dispose();
    entranceexitAnimationControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 36, bottom: 66),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, headerAnimation.value),
                child: Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Credit :",style: TextStyle(fontSize: 16)),
                          SizedBox(width: 24,),
                          Text("$totalCredit\$",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Profit :",style: TextStyle(fontSize: 16)),
                          SizedBox(width: 24,),
                          Text("$totalProfit\$",style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Round :",style: TextStyle(fontSize: 16)),
                          SizedBox(width: 24,),
                          Text("$round",style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Win :",style: TextStyle(fontSize: 16)),
                          SizedBox(width: 24,),
                          Text("$totalWin",style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Lost :",style: TextStyle(fontSize: 16)),
                          SizedBox(width: 24,),
                          Text("$totalLost",style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),  //header
              Text("$result", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedBuilder(
                      animation: animasyonKontrol,
                      builder: (context, child){
                        final donusDegeri = animasyondeger.value;
                        final gorunmeAcisi = donusDegeri % (2 * pi);
                        final yazi = gorunmeAcisi <= pi / 2 || gorunmeAcisi >= 3 * pi / 2;
                        return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..setEntry(3, 2, 0.002)
                              ..rotateX(animasyondeger.value),
                            child: yazi
                                ?gamecoin.tail
                                :Transform(
                                transform: Matrix4.rotationY(pi),
                                alignment: Alignment.center,
                                child: gamecoin.head
                            )
                        );
                      }
                      ),
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
              ),  //coin
              Text("$choice", style: TextStyle(color: Colors.white, fontSize: 20),),
              Transform.translate(
                offset: Offset(0, buttonAnimation.value),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 98, height: 60,
                          child: ElevatedButton(
                            child: Text("Head", style: TextStyle(fontSize: 20, color: Colors.deepPurple),),
                            onPressed: (){
                              headOrTail(1);
                            },
                          ),
                        ),
                        SizedBox(width: 98, height: 60,
                          child: ElevatedButton(
                            child: Text("Tail", style: TextStyle(fontSize: 20, color: Colors.deepPurple),),
                            onPressed: (){
                              headOrTail(0);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 165,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent.shade400,elevation: 4),
                        child: Text(
                          "TOSS",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: (){
                          if(!animasyonKontrol.isAnimating){
                            animasyonCalistir();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),  //buttons
            ],
          ),
        ),
      ),
      floatingActionButton: Transform.translate(
        offset: Offset(fabAnimation.value, 0),
        child: FloatingActionButton.extended(
          foregroundColor: Colors.deepPurple,
          label: Text("FINISH"),
          icon: const Icon(Icons.stop_circle_outlined),
          onPressed: (){
            finishGame();
          },

        ),
      ),
    );
  }
}
