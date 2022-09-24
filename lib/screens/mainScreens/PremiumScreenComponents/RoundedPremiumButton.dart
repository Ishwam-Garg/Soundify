import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumButton extends StatefulWidget {
  final Function call;
  final String text;
  PremiumButton(this.text,this.call);
  @override
  _PremiumButtonState createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation<double> scale;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    scale = Tween<double>(
        begin: 1,
        end: 0.92).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        highlightColor: Colors.grey.shade300,
        onTap: widget.call,
        onTapDown: (_) async {
          await animationController.forward();
          await animationController.reverse();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Material(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.07,vertical: 15),
              child: AutoSizeText(
                widget.text.toUpperCase(),
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
        ),
      ),
    );
  }
}
