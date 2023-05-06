import 'package:auto_size_text/auto_size_text.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const double XSMALL_PADDING = 3;
const double SMALL_PADDING = 5;
const double NORMAL_PADDING = 8;
const double MEDIUM_PADDING = 12;
const double LARGE_PADDING = 20;
const double EXTRA_LARGE_PADDING = 30;

const double XXSMALL_FONT = 10;
const double XSMALL_FONT = 12;
const double SMALL_FONT = 14;
const double MEDIUM_FONT = 16;
const double LARGE_TITLE_FONT = 17;
const double LARGE_FONT = 18;
const double EXTRA_LARGE_FONT = 20;

/*App base theme */
ThemeData getAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.red,
    ),
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      headlineLarge: GoogleFonts.mPlusRounded1c(
          textStyle: GoogleFonts.mPlusRounded1cTextTheme().headlineLarge),
      headlineMedium: GoogleFonts.mPlusRounded1c(
          textStyle: GoogleFonts.mPlusRounded1cTextTheme().headlineMedium),
      headlineSmall: GoogleFonts.mPlusRounded1c(
          textStyle: GoogleFonts.mPlusRounded1cTextTheme().headlineSmall),
    ),
  );
}

/*Text Styles start */
Widget setHeadlineLarge(String text,
    {BuildContext? context,
    bool upperCase = false,
    Color color = Colors.black,
    TextAlign? align}) {
  return AutoSizeText(
      textAlign: align,
      upperCase
          ? getTranslated(text, context: context).toUpperCase()
          : getTranslated(text, context: context),
      style: getAppFontB(
        textStyle: TextStyle(
          fontSize: 22,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ));
}

Widget setHeadlineMedium(String text,
    {BuildContext? context,
    bool upperCase = false,
    Color color = Colors.white,
    double fontSize = LARGE_TITLE_FONT}) {
  return AutoSizeText(
      upperCase
          ? getTranslated(text, context: context).toUpperCase()
          : getTranslated(text, context: context),
      style: getAppFontB(
          textStyle: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.w500)));
}

Widget setPrimaryTextLarge(String text,
    {Color color = Colors.black, double fontSize = LARGE_FONT}) {
  return AutoSizeText(text,
      style: getAppFontA(
          textStyle: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.w400)));
}

Widget setPrimaryTextMed(String text,
    {Color color = Colors.black, double fontSize = MEDIUM_FONT}) {
  return AutoSizeText(text,
      style: getAppFontA(
          textStyle: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4)));
}

Widget setCardHeading(String text) {
  return AutoSizeText(text,
      maxLines: 2,
      style: getAppFontA(
          textStyle: const TextStyle(
              fontSize: LARGE_TITLE_FONT,
              overflow: TextOverflow.ellipsis,
              color: Colors.red,
              fontWeight: FontWeight.w500)));
}

Widget setSmallLabel(String text,
    {Color color = Colors.black,
    bool opacity = false,
    TextAlign align = TextAlign.start}) {
  return AutoSizeText(text,
      textAlign: align,
      style: getAppFontA(
          textStyle: TextStyle(
        fontSize: XSMALL_FONT,
        color: opacity ? Colors.black : color,
        fontWeight: FontWeight.w400,
      )));
}

Widget setXSmallLabel(String text,
    {Color color = Colors.black,
    bool opacity = false,
    FontWeight fw = FontWeight.w400,
    double fontSize = XSMALL_FONT}) {
  return AutoSizeText(text,
      style: getAppFontA(
          textStyle: TextStyle(
              fontSize: fontSize,
              color: opacity ? Colors.black : color,
              fontWeight: fw)));
}

Widget setMediumLabel(String text,
    {BuildContext? context,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double fontSize = MEDIUM_FONT,
    int maxLines = 100,
    TextDecoration decoration = TextDecoration.none}) {
  return AutoSizeText(getTranslated(text, context: context),
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: getAppFontA(
          textStyle: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w400,
      )));
}

Widget setTextButton(String text,
    {VoidCallback? callback, IconData? icon, Color color = Colors.black}) {
  return GestureDetector(
      onTap: callback,
      child: Text.rich(
        TextSpan(
            text: text,
            style: getAppFontA(
                textStyle: TextStyle(
                    fontSize: 16, color: color, fontWeight: FontWeight.w400)),
            children: [
              (icon == null)
                  ? const WidgetSpan(
                      child: SizedBox(
                      width: 0,
                      height: 0,
                    ))
                  : WidgetSpan(
                      child: Icon(
                        icon,
                        color: Colors.black,
                      ),
                    ),
            ]),
      ));
}

//App font for labels
TextStyle getAppFontA({required TextStyle textStyle}) {
  return GoogleFonts.roboto(textStyle: textStyle);
}

//App font for headings such as site name Downtown
TextStyle getAppFontB({required TextStyle textStyle}) {
  return GoogleFonts.mPlusRounded1c(textStyle: textStyle);
}

/*Text Styles ends */

/*Card widgets and box decorations start */

BoxDecoration getPrimaryBoxDecoration({Color color = Colors.red}) {
  return BoxDecoration(
      color: color.withOpacity(0.19),
      borderRadius: const BorderRadius.all(Radius.circular(10)));
}

Widget getPrimaryCard(Widget child, {double padding = NORMAL_PADDING}) {
  return Container(
    padding: EdgeInsets.all(padding),
    decoration: getPrimaryBoxDecoration(),
    child: child,
  );
}

Widget getPrimaryBorderCard(Widget child,
    {double padding = NORMAL_PADDING, double margin = NORMAL_PADDING}) {
  return Container(
    padding: EdgeInsets.all(padding),
    margin: EdgeInsets.all(margin),
    decoration: getPrimaryBorderBoxDecoration(),
    child: child,
  );
}

Widget getWhiteRoundCard(Widget child,
    {Color color = Colors.white, double padding = NORMAL_PADDING}) {
  return Container(
    padding: EdgeInsets.all(padding),
    decoration: getWhiteBoxDecoration(color: color),
    child: child,
  );
}

BoxDecoration rowDecoration() {
  return const BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));
}

BoxDecoration getWhiteBoxDecoration(
    {double radius = 10, Color color = Colors.white}) {
  return BoxDecoration(
      color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
}

BoxDecoration getPrimaryBorderBoxDecoration(
    {Color color = Colors.transparent, Color borderColor = Colors.red}) {
  return BoxDecoration(
      color: color,
      border: Border.all(
        color: borderColor.withOpacity(0.5),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(6)));
}
/*Card widgets and box decorations ends */

/*Buttons start*/
Widget getPrimaryButton(String text, VoidCallback onClicked,
    {BuildContext? context, Color color = Colors.red}) {
  return TextButton(
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: color)))),
      onPressed: onClicked,
      child: Text(getTranslated(text, context: context),
          style: TextStyle(
              fontSize: 14, color: color, fontWeight: FontWeight.w600)));
}

Widget getTextButton(String text, VoidCallback onClicked,
    {BuildContext? context,
    Color color = Colors.red,
    TextDecoration? decoration}) {
  return TextButton(
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
            decoration: decoration,
          ))),
      onPressed: onClicked,
      child: Text(getTranslated(text, context: context),
          style: TextStyle(
              fontSize: 14, color: color, fontWeight: FontWeight.w600)));
}

Widget getSecondaryButton(String text, VoidCallback onClicked) {
  return ElevatedButton(
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.red)))),
      onPressed: onClicked,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
      ));
}
/*Buttons ends*/

Widget getVerticalSpace() {
  return const SizedBox(
    height: 10,
  );
}

Widget getHorizontalSpace() {
  return const SizedBox(
    width: 10,
  );
}

Widget showLoader({String? message}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
      ),
      getVerticalSpace(),
      setSmallLabel(message ?? "loading".translate())
    ],
  );
}

String getTranslated(String key, {BuildContext? context}) {
  return key;
}

Widget normalPadding({required Widget child}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: child,
  );
}

extension StringModifier on String {
  String translate({BuildContext? context}) {
    BuildContext? ctx;
    if (Get.key.currentContext != null) {
      ctx = Get.key.currentContext!;
    } else {
      ctx = context;
    }
    return getTranslated(this, context: ctx);
  }
}

extension StringNotZero on String {
  bool notZero() {
    if (isNotEmpty && this != "0") {
      return true;
    } else {
      return false;
    }
  }
}

extension EmptyStringPlaceholder on String {
  String orNa() {
    if (isEmpty) {
      return "-";
    } else {
      return this;
    }
  }
}

void goToNext(BuildContext context, Widget screen, {bool isNavigator = false}) {
  if (isNavigator) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  } else {
    Get.to(screen);
  }
}

Widget getImageWidget(String url, {double height = 130}) {
  return Container(
    color: Colors.red.withOpacity(0.2),
    child: SizedBox(
      width: double.infinity,
      height: height,
      child: FastCachedImage(
          url: url,
          height: height,
          fit: BoxFit.cover,
          key: ValueKey(url),
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image.asset(
              'assets/no_image.png',
            );
          },
          /*loadingBuilder: (context, progress) {
            return Center(
              child: CircularProgressIndicator(
                  color: Colors.red, value: progress.progressPercentage.value),
            );
          }*/),
    ),
  );
}

String getFormattedDateTime(String date) {
  String dd = date;
  try {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);

    DateFormat dateFormat = DateFormat("EEE, dd MMM yyyy hh:mm a");
    dd = dateFormat.format(tempDate).toString();
  } catch (e) {}

  return dd;
}

String getFormattedDateTimeForTournament(String date) {
  String dd = date;
  try {
    DateTime tempDate = new  DateFormat("EEE, dd MMM yyyy hh:mm a").parse(date);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    dd = dateFormat.format(tempDate).toString();
  } catch (e) {}

  return dd;
}

String getFormattedDate(String date) {
  String dd = date;
  try {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);

    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    dd = dateFormat.format(tempDate).toString();
  } catch (e) {}

  return dd;
}

String getFormattedTime(String date) {
  String dd = date;
  try {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);

    DateFormat dateFormat = DateFormat("HH:mm a");
    dd = dateFormat.format(tempDate).toString();
  } catch (e) {}

  return dd;
}
