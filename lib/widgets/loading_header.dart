import 'package:flutter/material.dart';
import 'package:online_course/widgets/icon_circular.dart';
import 'package:shimmer/shimmer.dart';

class LoadingHeader extends StatelessWidget {
  const LoadingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Shimmer.fromColors(
                baseColor: Color(0xffe1e1e1),
                highlightColor: Color(0xffffffff),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Shimmer.fromColors(
                  baseColor: Color(0xffe1e1e1),
                  highlightColor: Color(0xffffffff),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Color(0xffe1e1e1),
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
                    height: 5,
                  ),
                  Shimmer.fromColors(
                    baseColor: Color(0xffe1e1e1),
                    highlightColor: Color(0xffffffff),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
