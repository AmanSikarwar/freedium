import 'package:flutter/material.dart';
import 'package:freedium/screens/webview_screen.dart';
import 'package:super_clipboard/super_clipboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    _urlController = TextEditingController();
    super.initState();
  }

  Future<void> _pasteUrl() async {
    final reader = await SystemClipboard.instance!.read();

    if (reader.canProvide(Formats.uri)) {
      final url = await reader.readValue(Formats.uri);

      _urlController.text = url!.uri.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Freedium'),
        titleTextStyle: const TextStyle(
          color: Colors.green,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Your paywall breakthrough for Medium!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    hintText: 'Medium URL',
                    prefixIcon: const Icon(Icons.link),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      // borderSide: BorderSide(
                      //   color: Colors.green,
                      // ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.paste),
                      onPressed: _pasteUrl,
                    ),
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_urlController.text.isEmpty) {
                      return;
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WebviewScreen(
                          url: _urlController.text,
                        ),
                      ),
                    );
                  },
                  child: const Text('Get Article'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
