import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';

get logoHelp => Column(
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 1000 ? 8 : 25,
              vertical: screenWidth < 1000 ? 8 : 25,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: screenWidth < 1000 ? 55 : 85,
                child: Image.asset('assets/images/ic_help.png'),
              ),
            ),
          ),
        )
      ],
    );
