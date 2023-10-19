import 'package:flutter/material.dart';

import '../../constants/colors_list.dart';

colorPickerBottomSheet(
    {required BuildContext context,
    required int selectedColour,
    required Function(int) setColour}) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      print("selected color is: $selectedColour");
      return Column(children: [
        Material(
          elevation: 7,
          animationDuration: const Duration(seconds: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => {
                          Navigator.pop(context),
                        },
                    icon: const Icon(Icons.arrow_back_ios)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select a colour",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Flexible(child: StatefulBuilder(builder: (context, setState) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: colorsLists.length,
              itemBuilder: (context, index) {
                final ColorList currentColor = colorsLists[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          currentColor.colorName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        child: Row(
                          children: [
                            _buildColorContainer(
                              currentColor.listColors[0],
                              true,
                              true,
                              selectedColour == currentColor.listColors[0],
                              (value) => {
                                setColour(
                                  value,
                                ),
                                setState(
                                  () => {
                                    selectedColour = value,
                                  },
                                )
                              },
                            ),
                            _buildColorContainer(
                              currentColor.listColors[1],
                              false,
                              false,
                              selectedColour == currentColor.listColors[1],
                              (value) => {
                                setColour(
                                  value,
                                ),
                                setState(
                                  () => {
                                    selectedColour = value,
                                  },
                                )
                              },
                            ),
                            _buildColorContainer(
                              currentColor.listColors[2],
                              false,
                              true,
                              selectedColour == currentColor.listColors[2],
                              (value) => {
                                setColour(
                                  value,
                                ),
                                setState(
                                  () => {
                                    selectedColour = value,
                                  },
                                )
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }))
      ]);
    },
  );
}

Widget _buildColorContainer(
  int color,
  bool isLeft,
  bool isRight,
  bool isSelected,
  Function onTap,
) {
  BorderRadius borderRadius = BorderRadius.zero;
  if (isLeft) {
    borderRadius = BorderRadius.only(
      topLeft: Radius.circular(10),
      bottomLeft: Radius.circular(10),
    );
  } else if (isRight) {
    borderRadius = BorderRadius.only(
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10),
    );
  }

  return Expanded(
    flex: 1,
    child: GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap(color);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: borderRadius,
        ),
        child: isSelected
            ? Center(
                child: Text(
                  'Selected',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
      ),
    ),
  );
}
