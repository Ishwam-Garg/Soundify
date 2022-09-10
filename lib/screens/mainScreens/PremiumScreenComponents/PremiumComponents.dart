import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';


class PremiumComponents{

  Widget Comparison_Box(BuildContext context,String free,String premium)
  {
    return Container(
      width: 100,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Container(
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width*0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.white30,
                Colors.white30.withOpacity(0.2),
              ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text('Free',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 5),
                  child: AutoSizeText(
                    free,
                    maxFontSize: 24,
                    minFontSize: 18,
                    maxLines: 2,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                ),

              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width*0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff003300),
                Colors.green,
              ]),
              color: Colors.green.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text('PREMIUM',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 10),
                  child: AutoSizeText(
                    premium,
                    maxFontSize: 26,
                    minFontSize: 18,
                    maxLines: 2,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget PageIndicator(int index,int current_index)
  {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: CircleAvatar(
        backgroundColor: current_index == index ? Colors.white : Colors.white38,
        radius: 4,
      ),
    );
  }

  Widget GoPremium(BuildContext context)
  {
    return GestureDetector(
      onTap: (){},
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.07,vertical: 15),
          child: AutoSizeText(
            'GET PREMIUM',
            maxLines: 1,
            minFontSize: 14,
            maxFontSize:20,
            style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black),),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }

  Widget Round_Button(BuildContext context,String text)
  {
    return GestureDetector(
      onTap: (){},
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.07,vertical: 15),
          child: AutoSizeText(
            text,
            maxLines: 1,
            minFontSize: 14,
            maxFontSize:20,
            style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black),),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }

  Widget CurrentPlan(BuildContext context,String text)
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Colors.white38.withOpacity(0.3),
          Colors.white38.withOpacity(0.2),
        ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
          AutoSizeText('Current Plan',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400,fontSize: 14)),
        ],
      ),
    );
  }

  Widget One_Year_Plan(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
      height: 300,
      width: MediaQuery.of(context).size.width*0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Color(0xff032640),
          Color(0xff187bcd),
        ])
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1 year of premium',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
              Container(
                child: Column(
                  children: [
                    Text('₹999',style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('For 12 Months',style: TextStyle(fontSize: 14,color: Colors.white70,fontWeight: FontWeight.w500),)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          AutoSizeText(One_year_points,
            maxLines: 5,
            minFontSize: 10,
            maxFontSize: 16,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          PremiumComponents().GoPremium(context),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(terms_conditions,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70,fontSize: 14,fontWeight: FontWeight.w600),),
          ),
        ],
      ),
    );
  }

  Widget Mini_Plan(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
      height: 290,
      width: MediaQuery.of(context).size.width*0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Color(0xff187bcd),
          Color(0xff032640),
        ]),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mini',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
              Container(
                child: Column(
                  children: [
                    Text('From ₹7',style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('For 1 Day',style: TextStyle(fontSize: 14,color: Colors.white70,fontWeight: FontWeight.w500),)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          AutoSizeText(Mini_Plan_Points,
            maxLines: 5,
            minFontSize: 10,
            maxFontSize: 16,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          Round_Button(context, 'VIEW PLANS'),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('Terms and Conditions apply',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70,fontSize: 14,fontWeight: FontWeight.w600),),
          ),
        ],
      ),
    );
  }

  Widget Premium_Individual_Plan(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
      height: 300,
      width: MediaQuery.of(context).size.width*0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Color(0xff0e6b0e),
          Colors.green,
        ]),
      ),
      child: Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Premium\nIndividual',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          Container(
            child: Column(
              children: [
                Text('Free',style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('For 3 Months',style: TextStyle(fontSize: 14,color: Colors.white70,fontWeight: FontWeight.w500),)),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 20,),
      AutoSizeText(
      Premium_individual_points,
      maxLines: 5,
      minFontSize: 10,
      maxFontSize: 16,
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,
    ),
    SizedBox(height: 10,),
    PremiumComponents().Round_Button(context, 'GET 3 MONTHS FREE'),
  SizedBox(height: 20,),
  Align(
  alignment: Alignment.bottomCenter,
  child: Text('Terms and Conditions apply',
  textAlign: TextAlign.center,
  style: TextStyle(color: Colors.white70,fontSize: 14,fontWeight: FontWeight.w600),),
  ),
  ],
  ),
    );
  }

  List<String> Comparison_Free = ['Ad breaks','Streaming Only','Listen Alone'];
  List<String> Comparison_Premium = ['Ad-free music','Download songs','Group Session'];

  String Mini_Plan_Points = 'Day and week plans. Ad-free music on mobile . Download 30 songs on 1 mobile device';

  String One_year_points = 'Save ₹429 compared to monthly plans . Offer ends Dec 31 . Pay with PayTM, UPI, or debit card . One-time payment';

  String terms_conditions = 'Individual plan only. Terms and Conditions apply.';

  String Premium_individual_points = 'Ad-free music . Download 10,000 songs/device, on up to 5 devices . Subscribe with card for 3 months free and auto renew . Or, pay with PayTM or UPI';

}