  import 'package:flutter/material.dart';

get logo => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 200,
            child: Image.asset(
              'assets/images/logo_01.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

