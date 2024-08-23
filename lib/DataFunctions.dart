import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'FlashPage.dart';
import "main.dart";
import 'package:shared_preferences/shared_preferences.dart';


Future<List<List<dynamic>>> parseJsonTo2DArray(String category, String lang1, String lang2) async {
  // Load the JSON file from assets
  final String response = await rootBundle.loadString('assets/paatam.json');
  final data = await json.decode(response);

  // Check if the category exists in the JSON data
  // if (!data.containsKey(category)) {
  //   throw Exception('Category not found');
  // }

  final categoryData = data[category];

  // Check if the specified languages exist in the category
  if (!categoryData.containsKey(lang1) || !categoryData.containsKey(lang2)) {
    throw Exception('One or both languages not found in the category');
  }

  final lang1Data = List<String>.from(categoryData[lang1]);
  final lang2Data = List<String>.from(categoryData[lang2]);
  final englishData = List<String>.from(categoryData["English"]);


  if (lang1Data.length != lang2Data.length) {
    throw Exception('The languages have different lengths');
  }

  // Generate the 2D array
  List<List<dynamic>> result = [];
  
  // for (int i = 0; i < lang1Data.length; i++) {

  //   result.add([lang1Data[i], lang2Data[i], 0]);

  // }
  for (int i = 0; i < lang1Data.length; i++) {
    if(lang1Data[i] != ""){
        if(lang2Data[i] != ""){
          result.add([lang1Data[i], lang2Data[i], 0]);}
        else {
          result.add([lang1Data[i], englishData[i], 0]);}
        }
    }

  return result;
}




Future<void> openPage(Future<List<List<dynamic>>> futureList, BuildContext context, String key  ) async {
  List<List<dynamic>> list = await futureList; // Await the future to get the actual list

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlashPage(frontChar: list[0][0], backChar: list[0][1], list: futureList, prefKey: key,),
      ),
    );


 
}


void storeList(String key, Future<List<List<dynamic>>> list) async {
  List<List<dynamic>> resolvedList = await list;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(resolvedList));
}



Future<List<List<dynamic>>> changeIndex(Future<List<List<dynamic>>> futureList, bool isCorrect, String key ) async{
  List<List<dynamic>> list = await futureList; // Await the future to get the actual list
  int originalIndex = 0;
  int newIndex = 5;

  List<int> fibonacciNumbers = [0, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144 ];


  if (isCorrect){
    list[0][2] = list[0][2] +2;
    newIndex = fibonacciNumbers[list[0][2]];
  }
  else {
    newIndex = 2;
    list[0][2] = 0;
  }
  
  if (originalIndex < list.length && newIndex < list.length) {
    var item = list[originalIndex];  // Retrieve the item
    list.removeAt(originalIndex);    // Remove the item from the original index
    
    // Adjust newIndex if it's after the originalIndex due to the removal
    if (newIndex > originalIndex) {
      newIndex -= 1;
    }

    list.insert(newIndex, item);     // Insert the item at the new index
  }

  storeList(key, futureList);

  return list;
}