import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../user/user_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserManager user = UserManager();

  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  List<Widget> widgetList = [];
  late Size size;

  @override
  void initState() {
    super.initState();

    user.streamSubscription = user.streamController.stream.listen((data) {
      int index = data.length - 1;

      setState(() {
        widgetList.add(tileList(data[index].name, data[index].city));
      });
    });

  }

  @override
  void dispose() {
    super.dispose();

    user.streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.5,
        centerTitle: true,
        title: const Text(
          "Inserindo usuários",
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          children: [
            Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nome:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: Container(
                      height: size.height * 0.08,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: nameController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.lightBlue.withOpacity(0.5),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 16, right: 16, top: 14, bottom: 0),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: "nome",
                          hintStyle: TextStyle(color: Colors.black26),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        autocorrect: false,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Campo vazio';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Text(
                    "Cidade:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: Container(
                      height: size.height * 0.08,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: cityController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.lightBlue.withOpacity(0.5),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 16, right: 16, top: 14, bottom: 0),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.black,
                          ),
                          hintText: "cidade",
                          hintStyle: TextStyle(color: Colors.black26),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        autocorrect: false,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Campo vazio';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: GestureDetector(
                      onTap: () {
                        if (keyForm.currentState!.validate()) {
                          user.insert(nameController.text, cityController.text);
                        }
                      },
                      child: Container(
                        width: size.width,
                        height: size.height * 0.08,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.lightBlueAccent),
                        ),
                        child: const Text(
                          "Enviar",
                          style:
                              TextStyle(fontSize: 18, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 16.0),
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 8,
                direction: Axis.vertical,
                children: List.generate(widgetList.length, (index) {
                  return widgetList[index];
                }),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget tileList(String? name, String? city) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name!,
            style: const TextStyle(fontSize: 14.0),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            city!,
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
