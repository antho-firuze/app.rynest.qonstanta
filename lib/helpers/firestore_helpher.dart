import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/user.dart';
import 'package:get/get.dart';

import 'F.dart';

class FirestoreHelper {
  Future getUsers() async {
    try {
      var rows = await firestoreCollection.users.limit(10).get();

      if (rows.docs.isEmpty)
        return Result.warning(data: null, message: 'info_data_empty'.tr);

      List<User> users = rows.docs
          .map((row) =>
              User.fromJson(row.data() as Map<String, dynamic>, id: row.id))
          .toList();

      return Result.success(data: users);
    } catch (e) {
      if (e is PlatformException) return Result.error(message: e.message);

      return Result.error(message: e.toString());
    }
  }

  Future getUser(String id) async {
    try {
      F.setBuzy(true);
      var row = await firestoreCollection.users.doc(id).get();

      if (row.data() == null)
        return Result.warning(data: null, message: 'info_data_empty'.tr);

      User user = User.fromJson(row.data() as Map<String, dynamic>, id: row.id);

      return Result.success(data: user);
    } catch (e) {
      if (e is PlatformException) return Result.error(message: e.message);

      return Result.error(message: e.toString());
    } finally {
      await F.setBuzy(false);
    }
  }

  Future addUser(User user) async {
    try {
      await firestoreCollection.users.add(user.toJson());

      return Result.success(message: 'insert_success'.tr);
    } catch (e) {
      if (e is PlatformException) return Result.error(message: e.message);

      return Result.error(message: e.toString());
    }
  }

  Future editUser(User user) async {
    try {
      await firestoreCollection.users.doc(user.id).set(user.toJson());

      return Result.success(message: 'update_success'.tr);
    } catch (e) {
      if (e is PlatformException) return Result.error(message: e.message);

      return Result.error(message: e.toString());
    }
  }

  Future delUser(User user) async {
    try {
      await firestoreCollection.users.doc(user.id).delete();

      return Result.success(message: 'delete_success'.tr);
    } catch (e) {
      if (e is PlatformException) return Result.error(message: e.message);

      return Result.error(message: e.toString());
    }
  }
}

class FirstoreCollection {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference invoice =
      FirebaseFirestore.instance.collection('invoice');
}

final firestoreHelper = FirestoreHelper();
final firestoreCollection = FirstoreCollection();

    // READ 0
    // var row = await firestoreHelper.userReff.doc(id).get();
    // if (row.data() == null) return F.showInfoDialog('info_data_empty'.tr);

    // User user = User.fromJson(row.data() as Map<String, dynamic>, row.id);
    // F.log.i(user.id);
    // F.log.i(user.toJson());
    // await F.showInfoDialog('login success');

    // READ 0s
    // var rows = await firestoreHelper.userReff.limit(10).get();
    // if (row.data() == null) return F.showInfoDialog('info_data_empty'.tr);

    // List<User> users = User.fromJson(row.data() as Map<String, dynamic>);
    // F.log.i(users.toJson());

    // READ 1
    // User user = await firestoreHelper.userRef
    //     .doc('tyf9bD1kB4Uf1t8ixdZvxFhvk2r1')
    //     .get()
    //     .then((value) => value.data()!)
    //     .onError((error, stackTrace) => User());

    // if (user.fullName!.isEmpty) return F.showInfoDialog('info_data_empty'.tr);

    // F.log.i(user.toJson());

    // // READ 1s
    // User user = await firestoreHelper.userRef
    //     .doc('tyf9bD1kB4Uf1t8ixdZvxFhvk2r1')
    //     .get()
    //     .then((value) => value.data()!);
    // F.log.i(user.toJson());

    // // ADD
    // User user = await firestoreHelper.userRef
    //     .doc('tyf9bD1kB4Uf1t8ixdZvxFhvk2r1')
    //     .get()
    //     .then((value) => value.data()!);
    // F.log.i(user.toJson());

    // TEST ADD USER
    // setBusy(true);
    // Result result2 = await firestoreHelper
    //     .addUser(User(fullName: 'fullname', email: 'email@gmail.com'));
    // setBusy(false);
    // if (!result2.status) return await F.showErrorDialog(result2.message!);

    // F.showInfoDialog(result2.message!);

    // TEST EDIT USER
    // setBusy(true);
    // Result result2 = await firestoreHelper.editUser(User(
    //     uid: 'fPki1bZpPdw4y4C6N4GG',
    //     fullName: 'ahmad',
    //     email: 'ahmad@gmail.com',
    //     photoUrl: 'https://'));
    // setBusy(false);
    // if (!result2.status) return await F.showErrorDialog(result2.message!);

    // F.showInfoDialog(result2.message!);

    // TEST DELETE USER
    // setBusy(true);
    // Result result2 = await firestoreHelper.delUser(User(
    //     uid: 'fPki1bZpPdw4y4C6N4GG',
    //     fullName: 'ahmad',
    //     email: 'ahmad@gmail.com',
    //     photoUrl: 'https://'));
    // setBusy(false);
    // if (!result2.status) return await F.showErrorDialog(result2.message!);

    // F.showInfoDialog(result2.message!);

