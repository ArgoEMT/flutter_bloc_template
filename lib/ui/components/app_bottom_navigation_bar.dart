import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/generated/l10n.dart';

import '../../config/app_router.dart';
import '../../config/theme/app_colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  Widget _buildItem(
    BuildContext context, {
    required String label,
    required IconData iconData,
    void Function()? onTap,
    List<String>? routePaths,
    IconData? activeIconData,
  }) {
    final isSelected =
        routePaths?.contains(ModalRoute.of(context)!.settings.name) == true;
    assert(routePaths != null || onTap != null);
    return Expanded(
      child: InkWell(
        onTap: isSelected
            ? null
            : onTap ?? () => context.go(routePaths!.first, replace: true),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? (activeIconData ?? iconData) : iconData,
              color: isSelected ? appPrimary : appBlack50,
              size: 22,
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected ? appPrimary : appBlack50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    width: 8,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isSelected ? appPrimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: appLightGrey,
          ),
        ),
        color: appWhite,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildItem(
          context,
          iconData: Icons.home_outlined,
          activeIconData: Icons.home,
          label: S.of(context).home_title,
          routePaths: [RoutePaths.home],
        ),

        //TODO: add navigation items
      ]),
    );
  }
}
