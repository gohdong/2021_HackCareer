import 'package:clu_b/club_theme.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget clubAppBar(String title){
  return AppBar(
    title: Text(title,style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: CluBColor.mainColor
    ),),
    elevation: 0,
    backgroundColor: CluBColor.mainBackground,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(20),
      child: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: Text("Ased"),
      ),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.black,
            Colors.black.withOpacity(0)
          ]
        )
      ),
    ),
  );
}