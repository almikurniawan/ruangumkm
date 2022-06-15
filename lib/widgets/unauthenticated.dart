import 'package:flutter/material.dart';

class Unauthenticated extends StatelessWidget {
  const Unauthenticated({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.lock_outline_rounded, size: 100, color: Colors.grey),
          Text("Untuk Dapat Mengakses Tugas Silahkan Login Terlebih Dahulu.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}