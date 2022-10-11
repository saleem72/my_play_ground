//

import 'package:flutter/material.dart';
import 'package:my_play_ground/common/localization/language_constants.dart';
import 'package:my_play_ground/common/styles/app_fonts.dart';
import 'package:my_play_ground/common/styles/route_generator.dart';
import 'package:my_play_ground/helpers/app_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).main_screen),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(translation(context).options),
            const SizedBox(height: 20),
            PagesList(pages: AppPage.allCases(context)),
          ],
        ),
      ),
    );
  }
}

class PagesList extends StatelessWidget {
  const PagesList({
    Key? key,
    required this.pages,
  }) : super(key: key);

  final List<AppPage> pages;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: pages.length,
        itemBuilder: ((context, index) {
          return PageButton(page: pages[index]);
        }),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    Key? key,
    required this.page,
  }) : super(key: key);

  final AppPage page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(page.destination.path);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: page.colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              page.title,
              style: AppFonts.titleStyle,
            ),
            const SizedBox(height: 8),
            (page.description?.isNotEmpty ?? false)
                ? Text(
                    page.description ?? '',
                    style: AppFonts.descriptionStyle,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
