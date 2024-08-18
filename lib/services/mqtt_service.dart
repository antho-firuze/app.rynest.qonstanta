// import 'dart:convert';

// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
// import 'package:mqtt5_client/mqtt5_client.dart';
// import 'package:mqtt5_client/mqtt5_server_client.dart';
// import 'package:qonstanta/app/app.locator.dart';
// import 'package:qonstanta/helpers/F.dart';
// import 'package:qonstanta/models/user.dart';
// import 'package:get/get.dart';

// import 'notification_service.dart';

// const server = '5c547c95b6f34779a0fa42ccb6558ea1.s1.eu.hivemq.cloud';
// const username = 'qonstanta';
// const password = 'qonstanta@134679';
// const port = 8883;

// String identifier = 'client-1';

// MqttServerClient? client;

// @lazySingleton
// class MqttService {
//   _OnReceived _onReceived = _OnReceived();
//   _Pubs pubs = _Pubs();
//   _Subs subs = _Subs();
//   _Unsubs unsubs = _Unsubs();

//   Logger _log = Logger();

//   initialise() async {
//     identifier = "client-${await F.deviceId()}";
//     F.log.i("identifier => $identifier");
//     client = MqttServerClient.withPort(server, identifier, port);
//     client!.secure = true;
//     client!.logging(on: false);
//     client!.keepAlivePeriod = 20;
//     // client!.autoReconnect = true;
//     client!.onDisconnected = onDisconnected;
//     client!.onSubscribed = onSubscribed;
//     print('MQTT::connecting....');

//     try {
//       await client!.connect(username, password);
//     } on Exception catch (e) {
//       print('MQTT::client exception - $e');
//       client!.disconnect();
//     }

//     if (client!.connectionStatus!.state == MqttConnectionState.connected) {
//       print('MQTT::connected');
//       _listen();
//     } else {
//       print('MQTT::ERROR connection failed - disconnecting, '
//           'state is ${client!.connectionStatus!.state}');
//       client!.disconnect();
//     }
//   }

//   void onSubscribed(MqttSubscription topic) {
//     print('MQTT::Subscription confirmed for topic $topic');
//   }

//   void onDisconnected() {
//     print('MQTT::OnDisconnected client callback - Client disconnection');
//   }

//   void _listen() {
//     print('MQTT::listening');
//     client!.updates.listen((dynamic c) {
//       final String _topic = c[0].topic;
//       final MqttPublishMessage recMess = c[0].payload;
//       final String _payload =
//           MqttUtilities.bytesToStringAsString(recMess.payload.message!);

//       _log.i('Topic : $_topic\nPayload : $_payload');

//       // Adding this following line for another actions
//       // ==============================================
//       _onReceived.loginNotif(_topic, _payload);
//     });
//   }
// }

// class _OnReceived {
//   final _notif = locator<NotificationService>();

//   Future loginNotif(String topic, String payload) async {
//     String userJson = await F.session.user();
//     if (userJson.isEmpty) return;

//     User _user = User.fromJson(jsonDecode(userJson));
//     String _topic = 'auth/${_user.email}/${F.agent}';

//     if (topic != _topic) return;
//     if (payload.isEmpty) return;

//     var _token = await F.session.token();
//     if (payload == _token) return;

//     await _notif.show('another-login-device'.trArgs([F.agent]));

//     F.session.clearPreferences();
//     await F.onForceToLogin();
//   }
// }

// class _Subs {
//   signIn() async {
//     if (client!.connectionStatus!.state == MqttConnectionState.connected) {
//       String userJson = await F.session.user();
//       if (userJson.isEmpty) return;

//       User _user = User.fromJson(jsonDecode(userJson));
//       String _topic = 'auth/${_user.email}/${F.agent}';

//       client!.subscribe(_topic, MqttQos.atLeastOnce);
//     }
//   }
// }

// class _Pubs {
//   final builder = MqttPayloadBuilder();

//   signIn() async {
//     if (client!.connectionStatus!.state == MqttConnectionState.connected) {
//       String userJson = await F.session.user();
//       if (userJson.isEmpty) return;

//       User _user = User.fromJson(jsonDecode(userJson));
//       String _topic = 'auth/${_user.email}/${F.agent}';

//       String _token = await F.session.token();
//       builder.addString(_token);
//       client!.publishMessage(_topic, MqttQos.atLeastOnce, builder.payload!);
//     }
//   }
// }

// class _Unsubs {
//   signIn() async {
//     String userJson = await F.session.user();
//     if (userJson.isEmpty) return;

//     User _user = User.fromJson(jsonDecode(userJson));
//     String _topic = 'auth/${_user.email}/${F.agent}';

//     client!.unsubscribeStringTopic(_topic);
//   }
// }
