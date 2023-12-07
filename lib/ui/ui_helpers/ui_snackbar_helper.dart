import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/services/navigation_service.dart';

Future showSnackbar({
  required String? titre,
  bool isError = false,
  Function()? onPressedAnnuler,
  Function()? onDismiss,
  String? cancelLabel,
  double width = 345,
  double height = 48,
  int duration = 6,
}) async {
  var context = GetIt.I<NavigationService>().context;
  ScaffoldMessenger.of(context).clearSnackBars();

  await ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          width: MediaQuery.of(context).size.width * 0.9,
          backgroundColor: isError ? appRed : appBlack,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: duration),
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 14,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.82,
                      ),
                      child: Text(
                        titre ??
                            (isError
                                ? 'Une erreur est survenue'
                                : 'Opération réussie'),
                        style: bold14Black.copyWith(color: appWhite),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    onPressedAnnuler != null
                        ? OutlinedButton(
                            onPressed: () {
                              onPressedAnnuler();
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                            child: Text(
                              cancelLabel ?? 'Annuler',
                              style: const TextStyle(
                                color: appPrimary,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      .closed
      .then(
        (value) async => onDismiss != null ? await onDismiss() : () {},
      );
}
