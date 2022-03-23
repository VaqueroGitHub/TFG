import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/styles/tfg_theme.dart';

class PostMainPage extends StatefulWidget {
  @override
  _PostMainPageState createState() => _PostMainPageState();
}

// ignore: non_constant_identifier_names
var ForumPostArr = [
  ForumPostEntry("Joaquín Sexi", "Hace 2 días", 0, 0,
      "Hola,\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
  ForumPostEntry("Javier Vaquero", "Hace 15 horas", 1, 0,
      "Pellentesque justo metus, finibus porttitor consequat vitae, tincidunt vitae quam. Vestibulum molestie sem diam. Nullam pretium semper tempus. Maecenas lobortis lacus nunc, id lacinia nunc imperdiet tempor. Mauris mi ipsum, finibus consectetur eleifend a, maximus eget lorem. Praesent a magna nibh. In congue sapien sed velit mattis sodales. Nam tempus pulvinar metus, in gravida elit tincidunt in. Curabitur sed sapien commodo, fringilla tortor eu, accumsan est. Proin tincidunt convallis dolor, a faucibus sapien auctor sodales. Duis vitae dapibus metus. Nulla sit amet porta ipsum, posuere tempor tortor.\n\nCurabitur mauris dolor, cursus et mi id, mattis sagittis velit. Duis eleifend mi et ante aliquam elementum. Ut feugiat diam enim, at placerat elit semper vitae. Phasellus vulputate quis ex eu dictum. Cras sapien magna, faucibus at lacus vel, faucibus viverra lorem. Phasellus quis dui tristique, ultricies velit non, cursus lectus. Suspendisse neque nisl, vestibulum non dui in, vulputate placerat elit. Sed at convallis mauris, eu blandit dolor. Vivamus suscipit iaculis erat eu condimentum. Aliquam erat volutpat. Curabitur posuere commodo arcu vel consectetur."),
  ForumPostEntry("Carlos Luengo", "Hace 7 horas", 5, 0,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
  ForumPostEntry("Donald Trump", "Hace 58 minutos", 0, 0,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
];

class _PostMainPageState extends State<PostMainPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    var questionSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiero aprobar MDL',
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: height * 0.01),
          Text(
            'Estoy harto no puedo más, estoy muerto vivo, joder macho, he ido a academias, he sacado el libro de la biblioteca, me he ido de erasmus con la asignatura, he pagado a una por internet para que me hiciera el examen pero me ha dicho que le pague por delante para darle animos.',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconWithText(Icons.laptop_mac, "General"),
                IconWithText(
                  Icons.check_circle,
                  "Respondida",
                ),
                IconWithText(Icons.remove_red_eye, "54")
              ],
            ),
          ),
          Divider()
        ],
      ),
    );

    var responses = Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ForumPost(ForumPostArr[index]),
        itemCount: ForumPostArr.length,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("General"),
      ),
      body: Column(
        children: <Widget>[
          questionSection,
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: responses,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                elevation: 10.0,
                minWidth: 170.0,
                height: 50.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'Responder',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, 'newAnswerPage');
                },
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
        ],
      ),
    );
  }
}

class ForumPostEntry {
  final String username;
  final String hours;
  final int likes;
  final int dislikes;
  final String text;

  ForumPostEntry(
      this.username, this.hours, this.likes, this.dislikes, this.text);
}

class ForumPost extends StatelessWidget {
  final ForumPostEntry entry;

  ForumPost(this.entry);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: tfgTheme.highlightColor,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 160, 156, 156),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 50.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(entry.username),
                      Text(entry.hours),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.thumb_up),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(entry.likes.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.thumb_down),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 2.0),
                      child: Text(entry.dislikes.toString()),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            child: Text(entry.text),
          ),
        ],
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String text;

  IconWithText(this.iconData, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            this.iconData,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(this.text),
          ),
        ],
      ),
    );
  }
}
