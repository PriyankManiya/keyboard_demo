import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardDemo(),
    );
  }
}

class KeyboardDemo extends StatefulWidget {
  @override
  _KeyboardDemoState createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<KeyboardDemo> {
  TextEditingController _controller = TextEditingController();
  bool _readOnly = true;
  bool isShow = false;
  bool isShowQuerty = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapped");
        setState(() {
          isShow = false;
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: TextField(
                maxLines: 7,
                onTap: () {
                  setState(() {
                    isShow = true;
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                style: TextStyle(fontSize: 24),
                autofocus: true,
                showCursor: true,
                readOnly: _readOnly,
              ),
            ),
            Spacer(),
            isShow == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isShow = false;
                      });
                    },
                    child: CustomKeyboard(
                      onTextInput: (myText) {
                        _insertText(myText);
                      },
                      onBackspace: () {
                        _backspace();
                      },
                      onEnter: () {
                        print("Called Enter");
                        _enter();
                      },
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {

    print("Called BackSpace");
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  void _enter() {
    print("called Enter");
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '\n',
      );
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length)
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '\n',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomKeyboard extends StatelessWidget {
  CustomKeyboard({Key key, this.onTextInput, this.onBackspace, this.onEnter})
      : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback onEnter;

  void _textInputHandler(String text) => onTextInput(text);

  void _backspaceHandler() => onBackspace();

  void _enterHandler() => onEnter();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white30,
      child: Column(
        children: [
          buildRowTwo(),
          buildRowOne(),
          buildRowFour(),
          buildRowThird(),
          buildRowFive()
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: 'ऐ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ओ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'E',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'A',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'आ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'इ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ई',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'V',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ऊ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ए',
            onTextInput: _textInputHandler,
          ),

        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: [

          TextKey(
            text: 'घ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'W',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'म',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'न',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'R',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'भ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'U',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ब',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ग़',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThird() {
    return Expanded(
      child: Row(
        children: [

          TextKey(
            text: 'ट',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'O',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ठ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ड',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'V',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ख',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'फ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'थ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'च',
            onTextInput: _textInputHandler,
          ),

          TextKey(
            text: 'त',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowFour() {
    return Expanded(
      child: Row(
        children: [

          TextKey(
            text: 'श',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ष',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'स',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'व',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ळ',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'प',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'र',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ह',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'ल',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: 'य',
            onTextInput: _textInputHandler,
          ),

        ],
      ),
    );
  }

  Expanded buildRowFive() {
    return Expanded(
      child: Row(
        children: [
          // QuertyKey(),
          TextKey(
            text: ' ',
            flex: 4,
            onTextInput: _textInputHandler,
          ),
          BackspaceKey(
            onBackspace: _backspaceHandler,
          ),
          EnterKey(
            onEnter:  _enterHandler,
          )
        ],
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key key,
    @required this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              onTextInput?.call(text);
            },
            child: Container(
              child: Center(child: Text(text)),
            ),
          ),
        ),
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(

          child: InkWell(
            onTap: () {
              onBackspace?.call();
            },
            child: Container(
              child: Center(
                child: Icon(Icons.backspace),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*class QuertyKey extends StatelessWidget {
  const QuertyKey({
    Key key,
    // this.onEnter,
    this.flex = 1,
  }) : super(key: key);

  // final VoidCallback onEnter;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(

          child: InkWell(
            onTap: () {

            },
            child: Container(
              child: Center(
                child: Text("ABC"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/

class EnterKey extends StatelessWidget {
  const EnterKey({
    Key key,
    this.onEnter,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback onEnter;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(

          child: InkWell(
            onTap: () {
              onEnter?.call();
            },
            child: Container(
              child: Center(
                child: Text("Enter"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
