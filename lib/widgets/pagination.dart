import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';

class Pagination extends StatefulWidget {
  final int totalPage;
  final int currentPage;
  final Function onPageChanged;
  const Pagination({Key? key, required this.totalPage, required this.currentPage, required this.onPageChanged}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  @override
  Widget build(BuildContext context) {
    List<int> pages = <int>[];
    for (int i = 1; i <= widget.totalPage; i++) {
      pages.add(i);
    }
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (widget.currentPage==1) ? null  : (){
              widget.onPageChanged(widget.currentPage-1);
            }, 
            icon: Icon(Icons.keyboard_arrow_left),
            
          ),
          SizedBox(
            width: 70,
            child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe7e7ec)),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                value: widget.currentPage,
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                  color: primary,
                ),
                isExpanded: true,
                elevation: 16,
                style: const TextStyle(color: primary),
                onChanged: (int? newValue) {
                  widget.onPageChanged(newValue);
                },
                items: pages
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString(), style: Theme.of(context).textTheme.bodyText1,),
                  );
                }).toList()),
          ),
          IconButton(
            onPressed: (widget.currentPage==widget.totalPage) ? null  : (){
              widget.onPageChanged(widget.currentPage+1);
            }, 
            icon: Icon(Icons.keyboard_arrow_right))
        ],
      ),
    );
  }
}
