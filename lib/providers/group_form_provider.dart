import 'package:flutter/widgets.dart';
import 'package:flutter_application_tfg/models/group.dart';

class GroupFormProvider extends ChangeNotifier {
  String asignatura = '';
  int year = -1;
  String description = '';
  int nMembersRequired = -1;
  String githUrl = '';
  String driveUrl = '';
  List<String> idMembers = [];
  String idUser = '';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Group group(userSessionProvider) {
    return Group(
      asignatura: asignatura,
      year: year,
      description: description,
      nMembersRequired: nMembersRequired,
      githUrl: githUrl,
      driveUrl: driveUrl,
      idMembers: [userSessionProvider.user.id!],
      idUser: userSessionProvider.user.id!,
    );
  }

  Group emptyGroup() {
    return Group(
        asignatura: '',
        year: -1,
        description: '',
        nMembersRequired: -1,
        githUrl: '',
        driveUrl: '',
        idMembers: [],
        idUser: '');
  }

  void setGroup(Group group) {
    asignatura = group.asignatura;
    year = group.year;
    description = group.description;
    nMembersRequired = group.nMembersRequired;
    githUrl = group.githUrl;
    driveUrl = group.driveUrl;
    idMembers = group.idMembers;
    idUser = group.idUser;
  }
}
