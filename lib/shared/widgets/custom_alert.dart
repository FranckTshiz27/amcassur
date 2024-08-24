import 'package:amcassur/configs/appcolors.dart';
import 'package:amcassur/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

Future<ArtDialogResponse> rawsurShowCustomDialog({
  required BuildContext context,
  required String text,
  required String confirmButtonText,
  String? cancelButtonText,
  ArtSweetAlertType type = ArtSweetAlertType.warning,
  bool showCancelBtn = false,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) async {
  ArtDialogResponse responseDialg = await ArtSweetAlert.show(
    barrierDismissible: false,
    context: context,
    artDialogArgs: ArtDialogArgs(
      type: type,
      title: 'MyRawsur info',
      text: text,
      dialogDecoration: BoxDecoration(
        borderRadius: appRadius,
        color: AppColors.WHITE,
      ),
      showCancelBtn: showCancelBtn,
      confirmButtonColor: AppColors.YELLOW,
      cancelButtonText: cancelButtonText ?? '',
      confirmButtonText: confirmButtonText,
    ),
  );

  if (responseDialg.isTapConfirmButton && onConfirm != null) {
    onConfirm();
  }

  return responseDialg;
}
