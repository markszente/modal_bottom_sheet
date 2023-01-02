import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalWithNavigator extends StatelessWidget {
  const ModalWithNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    final isDragging = BottomSheetDragging.of(rootContext).isDragging;
    print(isDragging);
    return Material(
        child: Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (context2) => Builder(
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                leading: Container(), middle: Text('Modal Page 1')),
            child: SafeArea(
              bottom: false,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: ListView(
                  shrinkWrap: false,
                  physics:
                      !isDragging ? null : const NeverScrollableScrollPhysics(),
                  controller: ModalScrollController.of(rootContext),
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: List.generate(
                        100,
                        (index) => ListTile(
                              title: Text('Item'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CupertinoPageScaffold(
                                      navigationBar: CupertinoNavigationBar(
                                        middle: Text('New Page'),
                                      ),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          MaterialButton(
                                            onPressed: () =>
                                                Navigator.of(rootContext).pop(),
                                            child: Text('touch here'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
