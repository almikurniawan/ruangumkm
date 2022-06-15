import 'package:flutter/material.dart';
import 'package:online_course/models/fasilitator.dart';

class FasilitatorItem extends StatelessWidget {
  final Fasilitator fasilitator;
  const FasilitatorItem({ Key? key, required this.fasilitator }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage("https://ruangumkm.ilmanaf.com/public/img/anggota/"+this.fasilitator.foto!),
            // backgroundColor: Colors.white,
          ),
          SizedBox(height: 10,),
          Text(this.fasilitator.name!, style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
            fontWeight: FontWeight.bold
          )),),
          SizedBox(height: 10,),
          Text(this.fasilitator.limitName!, style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
            fontSize: 12
          )),),
        ],
      ),
    );
  }
}