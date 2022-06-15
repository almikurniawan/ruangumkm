import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 290,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(.1),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1),
            )
          ]),
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Color(0xffefefef),
            highlightColor: Color(0xffffffff),
            child: Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 170,
            right: 15,
            child: Shimmer.fromColors(
              baseColor: Color(0xffefefef),
              highlightColor: Color(0xffffffff),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  "UMKM",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Positioned(
            top: 210,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Color(0xffefefef),
                    highlightColor: Color(0xffffffff),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Color(0xffefefef),
                    highlightColor: Color(0xffffffff),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}