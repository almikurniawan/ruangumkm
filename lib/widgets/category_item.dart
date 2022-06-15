import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course/theme/color.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {Key? key,
      required this.data,
      this.isAktif = false,
      this.bgColorKategori = const Color(0xffefefef),
      this.onTap,
      this.aktifColor = primary})
      : super(key: key);
  final data;
  final Color aktifColor;
  final Color bgColorKategori;
  final bool isAktif;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isAktif ? aktifColor : bgColorKategori,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(.05),
              blurRadius: .5,
              spreadRadius: .5,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              data["icon"],
              color: isAktif ? Colors.white : darker,
              width: 16,
              height: 16,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              data["name"],
              style: TextStyle(
                color: isAktif ? Colors.white : darker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
