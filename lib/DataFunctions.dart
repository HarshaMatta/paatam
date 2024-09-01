import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'FlashPage.dart';
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
    if(lang2Data[i] != ""){
        if(lang1Data[i] != ""){
          result.add([lang2Data[i], lang1Data[i], 0]);}
        else {
          result.add([englishData[i], lang1Data[i], 0]);}
        }
    }


  for (int i = 0; i < lang1Data.length; i++) {
    if(lang2Data[i] != ""){
        if(lang1Data[i] != ""){
          result.add([lang1Data[i], lang2Data[i], 0]);}
        else {
          result.add([lang1Data[i], englishData[i], 0]);}
        }
    }

  return result;
}




Future<void> openPage(Future<List<List<dynamic>>> futureList, BuildContext context, String key) async {
  // Await the future to get the actual list
  List<List<dynamic>> list = await futureList;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FlashPage(
        frontChar: list[0][0], 
        backChar: list[0][1], 
        list: futureList, 
        prefKey: key,
      ),
      fullscreenDialog: true, // Disable swipe back on iOS
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

  List<int> fibonacciNumbers = [1, 5, 9, 14, 20, 27, 35, 44, 55, 60, 80, 100, 200, 300 ];


  if (isCorrect){
    list[0][2] = list[0][2] +1;
    if (list[0][2] < fibonacciNumbers.length){
    newIndex = fibonacciNumbers[list[0][2]];}
    else{
      newIndex = 200;
    }
    print(" the newIndex is $newIndex");
    print(list[0][2]);
  }
  else {
    newIndex = 2;
    list[0][2] = 0;
  }
  
  if (originalIndex < list.length && newIndex < list.length) {
    var item = list[originalIndex];  
    list.removeAt(originalIndex);    
    
    // Adjust newIndex if it's after the originalIndex due to the removal
    if (newIndex > originalIndex) {
      newIndex -= 1;
    }

    list.insert(newIndex, item);     // Insert the item at the new index
  }

    if (newIndex > list.length) {
      print(" index is large");
      var item = list[originalIndex];  
      list.removeAt(originalIndex);    
      list.insert(list.length -1, item);     // Insert the item at the new index
    }

  storeList(key, futureList);

  return list;
}