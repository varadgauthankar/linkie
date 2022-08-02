import 'package:flutter/material.dart';
import 'package:linkie/pages/preview_page.dart';
import 'package:linkie/utils/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sunny)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(26.0),
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // heading
                Text(
                  'Linkie',
                  style: TextStyle(
                    height: 0.8,
                    fontSize: (screenSize.width + screenSize.height) * 0.05,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                // subtitle
                Text(
                  'Generate link previews!',
                  style: TextStyle(
                    fontSize: (screenSize.width + screenSize.height) * 0.02,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),

                spacer(height: 8.0),

                // text field
                SizedBox(
                  width: screenSize.width > 768
                      ? screenSize.width * 0.5
                      : double.maxFinite,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter a URL',
                      hintText: 'www.example.com',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                ),

                spacer(height: 20.0),
                // button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreviewPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      primary: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.all(22)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Generate'),
                      spacer(width: 8.0),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
