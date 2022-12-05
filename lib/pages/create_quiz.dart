import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapps/addQuestion.dart';
import 'package:quizapps/database.dart';
import 'package:quizapps/widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = DatabaseService();
  bool isLoading = false;

  createQuizOnline() async {
    quizId = randomAlphaNumeric(16);
    if (_formkey.currentState!.validate() == false) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: isLoading
          ? Container(
              child: const Center(
              child: CircularProgressIndicator(),
            ))
          : Form(
              key: _formkey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(children: [
                  TextFormField(
                    validator: (val) =>
                        val!.isNotEmpty ? "Enter Image Url" : null,
                    decoration: const InputDecoration(
                      hintText: "Insert Quiz Image URL Here (Optional)",
                    ),
                    onChanged: (val) {
                      quizImageUrl = val;
                    },
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val!.isNotEmpty ? "Enter Quiz Title" : null,
                    decoration: const InputDecoration(
                      hintText: "Enter Quiz Title Here",
                    ),
                    onChanged: (val) {
                      quizTitle = val;
                    },
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val!.isNotEmpty ? "Enter Quiz Description" : null,
                    decoration: const InputDecoration(
                      hintText: "Enter Quiz Description Here",
                    ),
                    onChanged: (val) {
                      quizDescription = val;
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: button(context: context, label: "Create Quiz")),
                  const SizedBox(
                    height: 60,
                  ),
                ]),
              ),
            ),
    );
  }
}
