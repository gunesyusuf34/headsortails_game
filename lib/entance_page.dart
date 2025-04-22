import 'dart:math';
import 'package:animasyon_deneme1/game_page.dart';
import 'package:animasyon_deneme1/gamecoin_class.dart';
import 'package:animasyon_deneme1/pre_game_page.dart';
import 'package:flutter/material.dart';

class EntrancePage extends StatefulWidget {
  const EntrancePage({super.key});

  @override
  State<EntrancePage> createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> with TickerProviderStateMixin{

  var gamecoin = gameCoin();

  late AnimationController entranceexitAnimationControl;
  late Animation headerAnimation;
  late Animation buttonAnimation;

  Future<void> goToPreGame()async{
    await entranceexitAnimationControl.reverse();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PreGamePage()));
  }

  @override
  void initState() {
    super.initState();
    entranceexitAnimationControl = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    headerAnimation = Tween(begin: -400.0, end: 0.0)
        .animate(CurvedAnimation(parent: entranceexitAnimationControl, curve: Curves.elasticInOut))
      ..addListener((){ setState(() {}); });
    buttonAnimation = Tween(begin: 400.0, end: 0.0)
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
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 36, bottom: 86),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.translate(
                offset: Offset(0.0, headerAnimation.value),
                child: Container(
                  width: 300, height: 180,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: Text(
                      "HEADS OR TAILS GAME",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.deepPurpleAccent.shade400),
                      textAlign: TextAlign.center,
                    ),
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
              Transform.translate(
                offset: Offset(0, buttonAnimation.value),
                child: SizedBox(
                  width: 165,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent.shade400,elevation: 4),
                    child: Text(
                      "PLAY",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: (){
                      goToPreGame();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
