import 'package:flutter/material.dart';
import 'package:qonstanta/enums/basic_dialog_status.dart';
import 'package:qonstanta/ui/shared/app_colors.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/box_text.dart';
import 'package:stacked_services/stacked_services.dart';

class BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _BasicDialogContent(
        request: request,
        completer: completer,
      ),
    );
  }
}

class _BasicDialogContent extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialogContent(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidthPercentage(percentage: 0.04),
          ),
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vSpaceSmall,
              BoxText.subheading(
                request.title ?? '',
                align: TextAlign.center,
              ),
              vSpaceSmall,
              BoxText.body(
                request.description ?? '',
                align: TextAlign.center,
              ),
              vSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (request.secondaryButtonTitle != null)
                    TextButton(
                      onPressed: () =>
                          completer(DialogResponse(confirmed: false)),
                      child: BoxText.body(
                        request.secondaryButtonTitle!,
                        color: Colors.black,
                      ),
                    ),
                  TextButton(
                    onPressed: () => completer(DialogResponse(confirmed: true)),
                    child: BoxText.body(
                      request.mainButtonTitle!,
                      color: kcPrimaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -28,
          child: CircleAvatar(
            minRadius: 16,
            maxRadius: 28,
            backgroundColor: _getStatusColor(request.data),
            child: Icon(
              _getStatusIcon(request.data),
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(dynamic data) {
    switch (data) {
      case BasicDialogStatus.error:
        return kcRedColor;
      case BasicDialogStatus.warning:
        return kcOrangeColor;
      case BasicDialogStatus.info:
        return kcBlueColor;
      case BasicDialogStatus.question:
        return kcBlueColor;
      default:
        return kcPrimaryColor;
    }
  }

  IconData _getStatusIcon(dynamic data) {
    switch (data) {
      case BasicDialogStatus.error:
        return Icons.close;
      case BasicDialogStatus.warning:
        return Icons.warning_amber;
      case BasicDialogStatus.info:
        return Icons.info;
      case BasicDialogStatus.question:
        return Icons.question_answer;
      default:
        return Icons.check;
    }
  }
}
