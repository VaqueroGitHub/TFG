import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/service_form_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/service_arguments.dart';
import 'package:provider/provider.dart';

class ServiceButtons extends StatelessWidget {
  const ServiceButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceFormProvider = Provider.of<ServiceFormProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.add, color: Color(0XFF283593)),
              onPressed: () {
                serviceFormProvider.setEmptyService();
                Navigator.pushNamed(context, 'newServicePage',
                    arguments:
                        ServiceArguments(userSession: true, isEditing: false));
              }),
          SizedBox(width: 20),
          IconButton(
              icon: Icon(Icons.manage_search, color: Color(0XFF283593)),
              onPressed: () {
                Navigator.pushNamed(context, 'allServiceScreen');
              }),
        ],
      ),
    );
  }
}
