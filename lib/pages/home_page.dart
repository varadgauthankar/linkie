import 'package:flutter/material.dart';
import 'package:linkie/providers/link_data_provider.dart';
import 'package:linkie/providers/theme_provider.dart';
import 'package:linkie/utils/helpers.dart';
import 'package:linkie/utils/validators.dart';
import 'package:linkie/widgets/inputs/primary_text_field.dart';
import 'package:linkie/widgets/indicators/my_circular_progress_indicator_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.brightness_2
                    : Icons.sunny,
              ),
            ),
          ],
        ),
        body: Consumer<LinkDataProvider>(
          builder: (context, value, child) {
            // done loading, move to preview page
            if (value.state == LinkDataState.complete) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                // just a quick workaround to fix bug, short of time
                // literally have entrance exams in 4 days :(
                if (!value.navigated) {
                  Navigator.pushNamed(context, '/preview');
                  value.setNavigated();
                }
              });
            }

            // error
            if (value.state == LinkDataState.error) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value.errorMessage)),
                );
              });
            }

            return Center(
              child: ListView(
                padding: const EdgeInsets.all(26.0),
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // text
                      _heading(context, screenSize),
                      _subTitle(context, screenSize),
                      spacer(height: 8.0),

                      // text field
                      SizedBox(
                        width: screenSize.width > 768
                            ? screenSize.width * 0.5
                            : double.maxFinite,
                        child: PrimaryTextField(
                          formKey: value.formKey,
                          controller: value.urlController,
                          validator: (str) => validateURL(str),
                          labelText: 'Enter a URL',
                          hintText: 'https://example.com',
                        ),
                      ),

                      spacer(height: 20.0),

                      // button
                      Hero(
                        tag: 'primary-button',
                        child: TextButton(
                          onPressed: () => value.fetchLinkData(),
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              primary: Theme.of(context).colorScheme.onPrimary,
                              padding: const EdgeInsets.all(22)),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Flexible(child: Text('Generate')),
                              spacer(width: 8.0),
                              Flexible(
                                child: value.state == LinkDataState.loading
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          spacer(width: 4.0),
                                          const MyCircularProgressIndicator(),
                                        ],
                                      )
                                    : const Icon(Icons.chevron_right, size: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  Text _heading(BuildContext context, Size screenSize) {
    return Text(
      'Linkie',
      style: TextStyle(
        height: 0.8,
        fontSize: (screenSize.width + screenSize.height) * 0.05,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

Widget _subTitle(BuildContext context, Size screenSize) {
  return Text(
    'Generate link previews!',
    style: TextStyle(
      fontSize: (screenSize.width + screenSize.height) * 0.02,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onBackground,
    ),
  );
}
