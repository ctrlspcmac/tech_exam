import 'package:flutter/material.dart';
import 'package:maya_tech_exam/configs/colors.dart';

class BigButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final String subTitle;
  final Color color;
  final bool isRotate;


  const BigButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.color,
    required this.isRotate,
    this.subTitle = "", // Optional subtitle, defaults to an empty string
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.black85,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 8, height: 8),
                Transform.rotate(
                  angle: isRotate == true ? -45 * 3.1416 / 180 :0,
                  child:
                  Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),

              ],
            ),
            if (subTitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                // Add some spacing if subtitle exists
                child: Text(
                  subTitle,
                  style: TextStyle(fontSize: 12, color: AppColors.lineColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
