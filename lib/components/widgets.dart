import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:banking/constants/app_constants.dart';

import 'package:nb_utils/nb_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    required this.buttonBackgroundColor,
    required this.pressed,
  }) : super(key: key);

  final String label;
  final Color buttonBackgroundColor;
  final Function() pressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: pressed,
      child: Text(
        label,
        textAlign: TextAlign.left,
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: buttonBackgroundColor,
        primary: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding.h,
        ),
      ),
    );
  }
}

class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final IconData _icon;
  const HeaderWidget(this._height, this._showIcon, this._icon, {Key? key}) : super(key: key);
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState(_height, _showIcon, _icon);
}
class _HeaderWidgetState extends State<HeaderWidget> {
  double _height;
  bool _showIcon;
  IconData _icon;
  _HeaderWidgetState(this._height, this._showIcon, this._icon);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).accentColor.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: new ShapeClipper(
                [
                  Offset(width / 5, _height),
                  Offset(width / 10 * 5, _height - 60),
                  Offset(width / 5 * 4, _height + 20),
                  Offset(width, _height - 18)
                ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).accentColor.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: new ShapeClipper(
                [
                  Offset(width / 3, _height + 20),
                  Offset(width / 10 * 8, _height - 60),
                  Offset(width / 5 * 4, _height - 60),
                  Offset(width, _height - 20)
                ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: new ShapeClipper(
                [
                  Offset(width / 5, _height),
                  Offset(width / 2, _height - 40),
                  Offset(width / 5 * 4, _height - 80),
                  Offset(width, _height - 20)
                ]
            ),
          ),
          Visibility(
            visible: _showIcon,
            child: Container(
              height: _height - 40,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.only(
                    left: 5.0,
                    top: 20.0,
                    right: 5.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    border: Border.all(width: 5, color: Colors.white),
                  ),
                  child: Icon(
                    _icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height-20);
    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);
    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx,_offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx,_offsets[3].dy);
    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


// ignore: must_be_immutable
class BankingButton extends StatefulWidget {
  static String tag = '/BankingButton';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 50.0;
  var radius = 5.0;

  BankingButton(
      {required this.textContent,
        required this.onPressed,
        this.isStroked = false,
        this.height = 45.0,
        this.radius = 5.0});

  @override
  BankingButtonState createState() => BankingButtonState();
}

class BankingButtonState extends State<BankingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        alignment: Alignment.center,
        child: Text(
          widget.textContent.toUpperCase(),
          style: primaryTextStyle(
              color:
              widget.isStroked ? Banking_Primary : Banking_whitePureColor,
              size: 18,
              fontFamily: fontMedium),
        ).center(),
      ),
    );
  }
}

Widget bankingOption(var icon, var heading, Color color) {
  return Container(
    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
    child: Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(icon, color: color, height: 20, width: 20),
            16.width,
            Text(heading,
                style: primaryTextStyle(
                    color: Banking_TextColorPrimary, size: 18)),
          ],
        ).expand(),
        Icon(Icons.keyboard_arrow_right, color: Banking_TextColorSecondary),
      ],
    ),
  );
}

class TopCard extends StatelessWidget {
  final String name;
  final String acno;
  final String bal;

  TopCard({Key? key, required this.name, required this.acno, required this.bal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      height: context.height(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet,
                    color: Banking_Primary, size: 30)
                    .paddingOnly(top: 8, left: 8),
                Text(name, style: primaryTextStyle(size: 18))
                    .paddingOnly(left: 8, top: 8)
                    .expand(),
                Icon(Icons.info, color: Banking_greyColor, size: 20)
                    .paddingOnly(right: 8)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Account Number", style: secondaryTextStyle(size: 16))
                  .paddingOnly(left: 8, top: 8, bottom: 8),
              Text(acno,
                  style: primaryTextStyle(color: Banking_TextColorYellow))
                  .paddingOnly(right: 8, top: 8, bottom: 8),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Balance", style: secondaryTextStyle(size: 16))
                  .paddingOnly(left: 8, top: 8, bottom: 8),
              Text(bal,
                  style:
                  primaryTextStyle(color: Banking_TextLightGreenColor))
                  .paddingOnly(right: 8, top: 8, bottom: 8),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  TextEditingController? mController;

  VoidCallback? onPressed;

  EditText({
    var this.fontSize = textSizeNormal,
    var this.textColor = Banking_TextColorPrimary,
    var this.fontFamily = fontRegular,
    var this.isPassword = true,
    var this.isSecure = false,
    var this.text = "",
    var this.mController,
    var this.maxLine = 1,
  });

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextField(
          controller: widget.mController,
          obscureText: widget.isPassword,
          cursorColor: Banking_Primary,
          maxLines: widget.maxLine,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: Banking_TextColorPrimary,
              fontFamily: widget.fontFamily),
          decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: TextStyle(fontSize: textSizeMedium),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Banking_Primary, width: 0.5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Banking_TextColorSecondary, width: 0.5),
            ),
          ));
    } else {
      return TextField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: Banking_Primary,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: Banking_TextColorPrimary,
            fontFamily: widget.fontFamily),
        decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: TextStyle(fontSize: textSizeMedium),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              child: new Icon(
                widget.isPassword ? Icons.visibility : Icons.visibility_off,
                color: Banking_TextColorSecondary,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Banking_TextColorSecondary, width: 0.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Banking_Primary, width: 0.5),
            )),
      );
    }
  }
}

Widget headerView(var title, double height, BuildContext context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.chevron_left,
              size: 25,
              color: Banking_blackColor,
            ).paddingAll(6).paddingOnly(top: spacing_standard).onTap(() {
              finish(context);
            }).paddingOnly(
                left: spacing_standard,
                right: spacing_standard_new,
                top: spacing_standard_new,
                bottom: spacing_standard),
          ],
        ),
        Text(title,
            style: primaryTextStyle(
                color: Banking_TextColorPrimary,
                size: 30,
                fontFamily: fontBold))
            .paddingOnly(left: spacing_standard_new, right: spacing_standard),
      ],
    ),
  );
}
