import 'package:flutter/material.dart';
import 'package:qonstanta/enums/reference.dart';
import 'package:qonstanta/ui/shared/app_bar.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/input_dropdown.dart';
import 'package:qonstanta/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';

import 'profile_edit_viewmodel.dart';

ProfileEditViewModel? _model;

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileEditViewModel>.reactive(
        onModelReady: (model) async {
          _model = model;
        },
        builder: (context, model, child) => Scaffold(
            appBar: appBar(context, _model!.title, actions: [
              TextButton(
                  onPressed: _model!.updateProfile,
                  child: Text(
                    'Simpan',
                    style: oStyle.clr(Colors.white).size(18),
                  ))
            ]),
            resizeToAvoidBottomInset: false,
            body: Stack(children: [bg, content])),
        viewModelBuilder: () => ProfileEditViewModel());
  }

  get bg => Opacity(
        opacity: 0.2,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_a.png'),
                  fit: BoxFit.cover)),
        ),
      );

  get content => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_model!.isBusy) LinearProgressIndicator(),
              vSpaceXSmall,
              InputField(
                label: 'Nama Lengkap',
                controller: _model!.fullnameCtrl,
                // validator: (val) => val.isEmpty ? 'Harap di isi !' : null,
              ),
              InputField(
                label: 'Email',
                controller: _model!.emailCtrl,
                // value: _model.profile?.email,
                icon: Icon(Icons.email),
              ),
              InputField(
                label: 'No Telpon',
                controller: _model!.phoneCtrl,
                // value: _model.profile?.phone,
                icon: Icon(Icons.phone_android),
              ),
              InputField(
                label: 'Tempat Lahir',
                controller: _model!.placeOfBirthCtrl,
                // validator: (val) => val.isEmpty ? 'Harap di isi !' : null,
              ),
              InputField(
                label: 'Tanggal Lahir',
                controller: _model!.dateOfBirthCtrl,
                icon: Icon(Icons.baby_changing_station),
                action: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black54,
                  ),
                  onPressed: () async => await _model!.getDate(),
                ),
                placeholder: 'YYYY-MM-DD',
              ),
              InputDropdown<String>(
                'Jenis Kelamin',
                icon: Image.asset(
                  'assets/icons/gender.png',
                  height: 25,
                  color: Colors.grey,
                ),
                itemAsString: (item) => item,
                selectedItem: _model!.genderCtrl.text,
                onFind: (filter) => Future.value(listGender
                    .where(
                        (e) => e.toLowerCase().contains(filter.toLowerCase()))
                    .toList()),
                autoValidateMode: AutovalidateMode.always,
                onChanged: (val) {
                  _model!.genderCtrl.text = val!;
                  _model!.notifyListeners();
                },
                // validator: (val) => val == null ? 'Harap di isi !' : null,
              ),
            ],
          ),
        ),
      );
}
