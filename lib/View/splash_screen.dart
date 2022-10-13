import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'world_stats.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller  = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();



  @override
  void dispose(){
    super.initState();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState(

    );
     Timer(Duration( seconds:3),
      ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> WorldStats()))
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
              Center(
                child: AnimatedBuilder(animation: _controller,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: const Center(
                        child: Image(image: AssetImage('images/virus.png')),
                      ),
                    ),

                    builder: (BuildContext context, Widget ? child){

                  return Transform.rotate(angle: _controller.value *2.0* math.pi,
                  child: child ,

                  );
                }),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ), 
            const Center(
               child: Text('Covd 19 Tracker' , style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                 color: Colors.white
              ),),
            )
          ],
        ),
      ),
    );
  }
}
