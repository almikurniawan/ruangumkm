import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingFasilitator extends StatelessWidget {
  const LoadingFasilitator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Color(0xffe1e1e1),
            highlightColor: Color(0xffffffff),
            child: CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Color(0xffe1e1e1),
            highlightColor: Color(0xffffffff),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Shimmer.fromColors(
            baseColor: Color(0xffe1e1e1),
            highlightColor: Color(0xffffffff),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
