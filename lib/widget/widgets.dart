import 'package:flutter/material.dart';


Widget headerWidget(BuildContext context, String title) {
  return Row(
    children: [
      InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      const Spacer(),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
      const Spacer(),
    ],
  );
}

Widget continueButton(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff5BC500).withOpacity(0.8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}


Widget actionButton({
  required IconData icon,
  required String text,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 45,
      width: 120,
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xff9A9A9A),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}



class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 130,
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xff9A9A9A),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
