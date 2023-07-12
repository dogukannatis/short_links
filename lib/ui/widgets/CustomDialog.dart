import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String? title , description, acceptButton, cancelButton;
  final Image? img;
  final ButtonStyle? style;
  final Function? cancelFunction;
  final Function? acceptFunction;
  final Widget? widget;

  const CustomDialog({Key? key, this.title, this.description, this.acceptButton, this.cancelButton, this.img, this.style, this.cancelFunction, this.acceptFunction, this.widget}) : super(key: key);

  Future<bool?> show(BuildContext context) async {
    return await showDialog<bool>(context: context, builder: (context) => this, barrierDismissible: false);
  }

  @override
  _CustomDialogState createState() => _CustomDialogState();
}


class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(0, 8), blurRadius: 10
                  ),
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(widget.title!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                const SizedBox(height: 18,),
                widget.description != null ?
                Text(widget.description!, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center,) : Container(),
                widget.widget ?? Container(),
                const SizedBox(height: 12,),
                const Divider(thickness: 2,),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.cancelButton != null ?
                        Expanded(
                          child: TextButton(
                              style: widget.style ?? ButtonStyle(
                                shadowColor: MaterialStateProperty.all<Color>(Colors.red),

                              ),
                              onPressed: () async{
                                Navigator.of(context).pop();
                                if(widget.cancelFunction != null){
                                  widget.cancelFunction!();
                                }
                              },
                              child: Text(widget.cancelButton ?? "", style: const TextStyle(fontSize: 18 , ),)
                          ),
                        )
                            : const SizedBox(),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: TextButton(
                              style: widget.style ?? const ButtonStyle(),
                              onPressed: () async{
                                Navigator.of(context).pop();
                                if(widget.acceptFunction != null){
                                  widget.acceptFunction!();
                                }
                              },
                              child: Text(widget.acceptButton!, style: const TextStyle(fontSize: 18,)
                              )
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: widget.img,
              ),
            ),
          ),
        ],
      ),
      /*title: Text(title!),
      content: Text(title!),
      actions: _dialogButonlariniAyarla(context),

       */
    );
  }

}
