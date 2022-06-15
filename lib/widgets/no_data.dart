import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.error_outline_outlined, size: 100, color: Colors.grey),
          Text("Upsss, Kelas Tidak Ditemukan.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey))
        ],
      ),
    );
  }
}