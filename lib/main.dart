import 'package:flutter/material.dart';
import 'news_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context){
    return MaterialApp(
      home: NewsScreen(),
    );
  }
}