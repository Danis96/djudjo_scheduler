import 'package:djudjo_scheduler/widgets/text_fields/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum HeightUnit { ft, cm }

class CustomCmPicker extends StatelessWidget {
  CustomCmPicker({super.key, this.heightController, this.hint = '', this.onFieldSubmitted});

  HeightUnit selectedUnit = HeightUnit.ft;
  TextEditingController? heightController;
  String cm = '0';
  String mm = '0';
  String hint;
  Function? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onTap: selectedUnit == HeightUnit.ft
          ? () {
              FocusScope.of(context).requestFocus(FocusNode());
              showCupertinoModalPopup<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                print(index + 1);
                                cm = '${index + 1}';
                                heightController!.text = cm + ' cm';
                              },
                              children: List<Widget>.generate(200, (int index) {
                                return Center(child: Text('${index + 1}'));
                              }),
                            ),
                          ),
                          const Expanded(
                              flex: 1,
                              child: Center(
                                  child: Text('cm', style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: Colors.black)))),
                          Expanded(
                            child: CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                print(index);
                                mm = index.toString();
                                heightController!.text = '$cm cm $mm mm';
                              },
                              children: List<Widget>.generate(10, (int index) {
                                return Center(child: Text('$index'));
                              }),
                            ),
                          ),
                          const Expanded(
                            flex: 3,
                            child: Center(
                                child: Text('mm', style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: Colors.black))),
                          )
                        ],
                      ),
                    );
                  });
            }
          : null,
      hintText: hint,
      onFieldSubmitted: (String s) => onFieldSubmitted!() ?? print(''),
      controller: heightController,
      keyboardType: TextInputType.number,
    );
  }
}
