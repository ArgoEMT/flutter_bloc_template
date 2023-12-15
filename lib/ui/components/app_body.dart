import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../config/config_reader.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import 'app_bottom_navigation_bar.dart';
import 'template_appbar.dart';

class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
    required this.body,
    this.appBar,
    this.showBottomBar = true,
    this.backgroundColor,
    this.bottomBar,
    this.contentPadding = true,
    this.scrollController,
    this.title,
    this.titleIcon,
    this.scrollPhysics,
    this.hasSingleChildScrollView = true,
    this.isLoading = false,
  });

  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? bottomBar;
  final Widget body;
  final String? title;
  final IconData? titleIcon;
  final ScrollPhysics? scrollPhysics;
  final bool showBottomBar;

  final bool contentPadding;
  final ScrollController? scrollController;
  final bool hasSingleChildScrollView;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final config = GetIt.instance<AppConfig>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Banner(
            location: BannerLocation.topEnd,
            color: config.color,
            message: config.env.name,
            child: Scaffold(
              backgroundColor: backgroundColor ?? appWhite,
              bottomNavigationBar: showBottomBar
                  ? (bottomBar ?? const AppBottomNavigationBar())
                  : null,
              appBar: appBar ??
                  (title != null
                      ? TemplateAppbar(
                          backgroundColor: homeBackgroundColor.lighten(0.5),
                          child: Row(
                            children: [
                              if (titleIcon != null)
                                Icon(
                                  titleIcon!,
                                  color: appBlack,
                                ),
                              const SizedBox(width: 10),
                              Text(
                                title!,
                                style: bold20Black,
                              ),
                            ],
                          ),
                        )
                      : null),
              body: hasSingleChildScrollView
                  ? SingleChildScrollView(
                      physics: scrollPhysics,
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: contentPadding ? 16 : 0,
                          vertical: contentPadding ? 24 : 0,
                        ),
                        child: body,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: contentPadding ? 16 : 0,
                      ),
                      child: body,
                    ),
            ),
          ),
        ),
        if (isLoading)
          Material(
            color: appPrimary.withOpacity(0.2),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: appWhite.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
