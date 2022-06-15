import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';

class KelasPencarian extends StatelessWidget {
  const KelasPencarian({Key? key, required this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      child: Container(
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
            Container(
              width: double.infinity,
              height: 190,
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                imageUrl: data["image"],
              ),
            ),
            Positioned(
              top: 170,
              right: 15,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary,
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
                // child: Text(data["price"],
                child: Text(
                  "UMKM",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
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
                    Text(
                      data["name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17,
                          color: textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getAttribute(Icons.person, labelColor, data["session"]),
                        SizedBox(
                          width: 12,
                        ),
                        getAttribute(Icons.schedule_rounded, labelColor,
                            data["duration"]),
                        SizedBox(
                          width: 12,
                        ),
                        getAttribute(Icons.star, yellow, data["review"]),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

getAttribute(IconData star, Color yellow, String info) {
  return Row(
    children: [
      Icon(
        star,
        size: 18,
        color: yellow,
      ),
      SizedBox(
        width: 3,
      ),
      Text(
        info,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: labelColor,
          fontSize: 13,
        ),
      )
    ],
  );
}
