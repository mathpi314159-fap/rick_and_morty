import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/styles/textStyles.dart';

class CharacterCell extends StatefulWidget {
  final String _headerText;
  final String _mainText;
  final Function()? _function;
  final bool isLinkLocation;

  CharacterCell(
      this._headerText, this._mainText, this._function, this.isLinkLocation);

  @override
  _CharacterCellState createState() => _CharacterCellState();
}

class _CharacterCellState extends State<CharacterCell> {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child:
                    Text(widget._headerText, style: TextStyles.helpTextStyle)),
            SizedBox(
              width: 8,
            ),
            Flexible(
                child: InkWell(
                    onTap: widget._function,
                    child: Text(widget._mainText,
                        style: (widget.isLinkLocation)
                            ? TextStyles.helpTextUnderlineStyle
                            : TextStyles.nameTextStyle))),
          ],
        ),
      );
}
