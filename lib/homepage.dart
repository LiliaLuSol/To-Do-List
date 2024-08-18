import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/custom_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool status = false;
    return Scaffold(
      backgroundColor: Colors.cyan[400],
      appBar: AppBar(
        title: const Text(
          'To Do List',
        ),
        titleTextStyle: const TextStyle(
            color: Colors.pinkAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.cyan[400],
      ),
      body: status
          ? Stack(textDirection: TextDirection.ltr, children: <Widget>[
              Center(
                child: Container(
                  width: size.width / 1.1,
                  height: size.height / 1.175,
                  decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
              Column(
                children: [
                  CustomTextFormField(
                      hintText: "Search recent task",
                      controller: searchController,
                      textInputType: TextInputType.text,
                      prefix: const Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      fillColor: Colors.white70,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Text('data');
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.blueGrey,
                      );
                    },
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ])
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white70,
                    size: size.height * .20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'It\'s still empty.\nAdd something!',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown[200],
          child: Icon(
            Icons.add_circle,
            color: Colors.brown[900],
          ),
          onPressed: () {}),
    );
  }
}
