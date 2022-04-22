import 'package:flutter/material.dart';

class ServiceButtons extends StatelessWidget {
  const ServiceButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.add, color: Color(0XFF283593)),
              onPressed: () =>
                  {Navigator.pushNamed(context, 'newServicePage')}),
          SizedBox(width: 20),
          IconButton(
              icon: Icon(Icons.manage_search, color: Color(0XFF283593)),
              onPressed: () =>
                  {Navigator.pushNamed(context, 'allServiceScreen')}),
        ],
      ),
    );
  }
}
