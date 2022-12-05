import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizId) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Quiz");
    collectionRef.add(quizData).catchError((e) {
      print(e.toString());
    });
    // await FirebaseFirestore.instance
    //     .collection("Quiz")
    //     .doc(quizId)
    //     .setData(quizData)
    //     .catchError((e) {
    //   print(e.toString());
    // });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection("Quiz").doc(questionData[quizId]);

    CollectionReference collectionRef = documentRef.collection("QNA");
    collectionRef.add(questionData).catchError((e) {
      print(e.toString());
    });
  }
}
