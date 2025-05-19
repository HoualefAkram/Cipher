import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g2vip/Cipher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groupe 2 ViP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Groupe 2 ViP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _seedController;
  late final TextEditingController _messageController;
  late final TextEditingController _codeController;
  @override
  void initState() {
    _seedController = TextEditingController();
    _messageController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _seedController.dispose();
    _messageController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _seedController,
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_open_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "seed",
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: _onClear,
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: _onMessageCopy,
                    icon: const Icon(Icons.copy),
                  ),
                  IconButton(
                    onPressed: _onMessagePaste,
                    icon: const Icon(Icons.paste),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.28,
                child: TextField(
                  controller: _messageController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Message",
                  ),
                  onChanged: _onMessageUpdate,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: _onClear,
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: _onCodeCopy,
                    icon: const Icon(Icons.copy),
                  ),
                  IconButton(
                    onPressed: _onCodePaste,
                    icon: const Icon(Icons.paste),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.28,
                child: TextField(
                  controller: _codeController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Code",
                  ),
                  onChanged: _onCodeUpdate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMessageUpdate(String message) {
    setState(() {
      _codeController.text = Cipher.encode(
        message,
        int.tryParse(_seedController.text),
      );
    });
  }

  void _onCodeUpdate(String code) {
    setState(() {
      _messageController.text = Cipher.decode(
        code,
        int.tryParse(_seedController.text),
      );
    });
  }

  void _onMessageCopy() {
    Clipboard.setData(ClipboardData(text: _messageController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied"),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  Future<void> _onMessagePaste() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    String? clipboardText = clipboardData?.text;
    _messageController.text = clipboardText ?? "";
    _onMessageUpdate(_messageController.text);
  }

  void _onCodeCopy() {
    Clipboard.setData(ClipboardData(text: _codeController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied"),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  Future<void> _onCodePaste() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    String? clipboardText = clipboardData?.text;
    _codeController.text = clipboardText ?? "";
    _onCodeUpdate(_codeController.text);
  }

  void _onClear() {
    _messageController.clear();
    _codeController.clear();
  }
}
