import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/painting.dart';
import 'package:soundify/screens/mainScreens/PremiumScreenComponents/PremiumComponents.dart';
import 'dart:async';

class PremiumScreen extends StatefulWidget {
  @override
  _PremiumScreenState createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  PageController _pageController = PageController(initialPage: 0,viewportFraction: 0.8);

  int Current_index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 3), (Timer timer) {
          if(Current_index < 3)
            {
              Current_index++;
            }
          else
            {
              Current_index =0;
            }

          _pageController.animateToPage(Current_index, duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                  child: AutoSizeText('Ends Soon: 1 year of Premium for 999',maxLines: 2,minFontSize: 26,maxFontSize: 38,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 34),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.3,
                    child: PageView(
                      controller: _pageController,
                      pageSnapping: true,
                      onPageChanged: (index) {
                        setState(() {
                          Current_index = index;
                        });
                      },
                      children: List.generate(PremiumComponents().Comparison_Free.length, (
                          index) => PremiumComponents().Comparison_Box(context,
                          PremiumComponents().Comparison_Free[index],
                          PremiumComponents().Comparison_Premium[index])),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.4),
                      child: Row(
                        children: List.generate(
                            PremiumComponents().Comparison_Free.length,
                                (index) => PremiumComponents().PageIndicator(index, Current_index)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                PremiumComponents().GoPremium(context),
                SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                PremiumComponents().CurrentPlan(context,'Soundify Free'),
                SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                PremiumComponents().One_Year_Plan(context),
                SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                PremiumComponents().Mini_Plan(context),
                SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                PremiumComponents().Premium_Individual_Plan(context),
              ],
            ),
        ),
      );
  }

}

