import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:qonstanta/enums/app_state.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/fcm_helper.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/message.dart';
import 'package:qonstanta/models/user.dart';
import 'package:stacked_services/stacked_services.dart';

class FcmService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  _OnReceived _onReceived = _OnReceived();
  _Pubs pubs = _Pubs();
  _Subs subs = _Subs();
  _Unsubs unsubs = _Unsubs();

  Future deviceToken() async {
    String? token = await _fcm.getToken();
    debugPrint('deviceToken : $token');
  }

  Future<void> fcmMessageHandler(Map<String, dynamic> message,
      {AppState? state}) async {
    F.log.i(message);

    _onReceived.signInHandler(message['token'], state!);
  }

  Future push(
    Message message, {
    Map<String, dynamic>? data,
  }) async {
    Map<String, dynamic> _data = {"click_action": "FLUTTER_NOTIFICATION_CLICK"};

    if (data != null) _data = _data..addAll(data);

    var payload = {
      'priority': 'high',
      'content-available': true,
      'to': "/topics/${message.topic}",
      'notification': message.toJsonNotification(),
      'data': _data,
    };

    Result _result = await fcmHelper.send(payload);

    if (_result.status) {
      return Result.success(data: _result.data, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }
}

class _OnReceived {
  Future signInHandler(String? token, AppState state) async {
    if (token == null || token.isEmpty) return;

    var _token = await F.session.token();
    if (token == _token) return;

    await F.onForceToLogin();
  }
}

class _Unsubs {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future signIn() async {
    String _topic = await F.session.signInTopic();
    if (_topic.isEmpty) return;

    await _fcm.unsubscribeFromTopic(_topic);
  }
}

class _Subs {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future signIn() async {
    String _topic = await F.session.signInTopic();
    if (_topic.isEmpty) return;

    await _fcm.subscribeToTopic(_topic);
  }
}

class _Pubs {
  Future signIn() async {
    String _topic = await F.session.signInTopic();
    if (_topic.isEmpty) return;

    Message _msg = Message(
      topic: _topic,
      title: "Oppss...",
      body: 'another-login-device'.trArgs([F.agent]),
    );

    await FcmService().push(_msg, data: {'token': await F.session.token()});
  }
}

Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FcmService()
      .fcmMessageHandler(message.data, state: AppState.background);
}

Future<void> _fcmHandler(RemoteMessage message, AppState appState) async {
  await Firebase.initializeApp();
  await FcmService().fcmMessageHandler(message.data, state: appState);
}

fcmListen() {
  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
  FirebaseMessaging.onMessage
      .listen((message) => _fcmHandler(message, AppState.foreground));
  FirebaseMessaging.onMessageOpenedApp
      .listen((message) => _fcmHandler(message, AppState.terminated));
}
