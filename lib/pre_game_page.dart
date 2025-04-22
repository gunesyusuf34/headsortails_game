import 'package:animasyon_deneme1/credit_amount_provider.dart';
import 'package:animasyon_deneme1/game_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreGamePage extends StatefulWidget {
  const PreGamePage({super.key});

  @override
  State<PreGamePage> createState() => _PreGamePageState();
}

class _PreGamePageState extends State<PreGamePage> with TickerProviderStateMixin{

  var tfCreditControl = TextEditingController();
  var tfProfitControl = TextEditingController();
  var tfRiskControl = TextEditingController();

  late AnimationController entranceexitAnimationControl;
  late Animation headerAnimation;
  late Animation buttonAnimation;

  Future<void> goToGame()async{
    await entranceexitAnimationControl.reverse();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GamePage()));
  }

  @override
  void initState() {
    super.initState();
    entranceexitAnimationControl = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    headerAnimation = Tween(begin: -560.0, end: 0.0)
        .animate(CurvedAnimation(parent: entranceexitAnimationControl, curve: Curves.elasticInOut))
      ..addListener((){ setState(() {}); });
    buttonAnimation = Tween(begin: 500.0, end: 0.0)
        .animate(CurvedAnimation(parent: entranceexitAnimationControl, curve: Curves.elasticInOut))
      ..addListener((){ setState(() {}); });
    entranceexitAnimationControl.forward();
  }
  @override
  void dispose() {
    super.dispose();
    entranceexitAnimationControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.translate(
              offset: Offset(0, headerAnimation.value),
              child: Container(
                width: 320,height: 360,
                padding: EdgeInsets.only(left: 15, right: 25, top: 25, bottom: 15,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Initial Credit:", style: TextStyle(fontSize: 16),),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Consumer<InitialCredit>(
                              builder: (context, object, child){
                                return TextField(
                                  controller: tfCreditControl,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    hintText: "100 \$",
                                    hintStyle: TextStyle(fontSize: 16,),
                                    helperText: "Type your initial credit money \nfor the game",
                                    helperStyle: TextStyle(fontSize: 12,),
                                  ),
                                  onChanged: (_){
                                    int amount = int.parse(tfCreditControl.text);
                                    object.setCredit(amount);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Profit \nper round:", style: TextStyle(fontSize: 16),),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Consumer<ProfitPerRound>(
                              builder: (context,object,child){
                                return TextField(
                                  controller: tfProfitControl,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    hintText: "1 \$",
                                    hintStyle: TextStyle(fontSize: 16,),
                                    helperText: "Type your target profit amount for \nper round",
                                    helperStyle: TextStyle(fontSize: 12,),
                                  ),
                                  onChanged: (context){
                                    object.setProfitPerRound(tfProfitControl);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Risk \nper round:", style: TextStyle(fontSize: 16),),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Consumer<RiskPerRound>(
                              builder: (context,object,child){
                                return TextField(
                                  controller: tfRiskControl,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    hintText: "1 \$",
                                    hintStyle: TextStyle(fontSize: 16,),
                                    helperText: "Type your target risk amount for \nper round",
                                    helperStyle: TextStyle(fontSize: 12,),
                                  ),
                                  onChanged: (context){
                                    object.setRiskPerRound(tfRiskControl);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),  //header
            Transform.translate(
              offset: Offset(0, buttonAnimation.value),
              child: SizedBox(
                width: 165,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent.shade400,elevation: 4),
                  child: Text(
                    "START",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: (){
                    goToGame();
                  },
                ),
              ),
            ),  //button
          ],
        ),
      ),
    );
  }
}
