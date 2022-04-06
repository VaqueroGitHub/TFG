import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, 'aboutProfile', (route) => false),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _HomeBody(height: height),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Image.asset('assets/imgs/vaquero.png'),
          ),
          SizedBox(height: height * 0.04),
          Column(
            children: <Widget>[
              Text(
                'Conecta estudiantes',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'de forma facil',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
          MaterialButton(
            elevation: 10.0,
            minWidth: 170.0,
            height: 50.0,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'logIn');
            },
          ),
          MaterialButton(
            elevation: 10.0,
            minWidth: 170.0,
            height: 50.0,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'Registrarse',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'register');
            },
          ),
          SizedBox(height: height * 0.04),
        ],
      ),
    );
  }
}
