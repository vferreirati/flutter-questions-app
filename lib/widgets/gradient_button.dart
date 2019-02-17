import 'package:exata_questoes_app/widgets/colors.dart';
import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final Function onClick;
  final String title;
  final bool isLoading;

  GradientButton({@required this.onClick, @required this.title, @required this.isLoading});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  Function get onClick => widget.onClick;
  String get title => widget.title;
  bool get isLoading => widget.isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 60,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          gradient: buttonGradient(),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            tileText(title: "Iniciar", color: Colors.white, size: 20),
            SizedBox(width: 8),
            isLoading
              ? SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : Container()
          ],
        ),
      ),
    );
  }
}
