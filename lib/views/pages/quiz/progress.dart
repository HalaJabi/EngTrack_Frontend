import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';

class PForm extends StatefulWidget {
  final List<Widget> pages;
  final List<PTitle> title;

  PForm({required this.pages, required this.title});

  @override
  _PFormState createState() => _PFormState();
}

class _PFormState extends State<PForm> with TickerProviderStateMixin {
   List<AnimationController> _controllers=[];
  List<Animation<double>> _annimations=[]; 
 List<Animation<double>> _annimationsOpavity=[]; 
   List<bool> activeColor=[];
  @override
  void initState() {
 super.initState();


   _controllers = List.generate(
        widget.pages.length,
        (index) => AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 200),
            lowerBound: .05));

 _annimations = _controllers
        .map((_controller) =>
            Tween<double>(begin: .1, end: 1).animate(_controller))
        .toList();



         _annimationsOpavity = _controllers
        .map((_controller) =>
            Tween<double>(begin: 0, end: 1).animate(_controller))
        .toList();

 activeColor = List.generate(widget.pages.length, (index) => false);

 







  }


controlColor(int index) {
  for (var i = 0; i < activeColor.length; i++) {
    if (index == i) {
      if (!_controllers[i].isCompleted) _controllers[index].animateTo(1);
    } else {
      if (_controllers[i].isCompleted) _controllers[i].reverse();
    }
  }
  for (var i = 0; i <= index; i++) {
    activeColor[i] = true;
  }
  for (var i = index + 1; i < activeColor.length; i++) {
    activeColor[i] = false;
  }
  // Check if all pages are completed
  if (index == activeColor.length - 1 && _controllers.last.isCompleted) {
    // Close Page4
    _controllers.last.reverse();
    activeColor[index] = false;
  }
  setState(() {});
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.pages.map((e) {
          int index = widget.pages.indexOf(e);

          return Stack(
            children: [
             if ( index != widget.pages.length - 1)
                Container(

                    margin: EdgeInsets.only(left: 2, top: 37),
                  child: SizeTransition(
                    sizeFactor: _annimations[index],
                    child: Container(
                      margin: EdgeInsets.only(left: 13, right: 20),
                      width: 3,
                      height: 500,
                      color: Color(kOrange.value),
                    ),
                  ),
                ),
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                     controlColor(index);
                     
                      
                        }
                        ,
                        child: Container(
                          width: 35,
                          height: 35,


   decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: activeColor[index]
                                ?Color(kOrange.value).withOpacity(.9)
                                : Colors.grey,
                          ),

                        
                        ),
                      ),



                      SizedBox(width: 10,
                      ),
                      widget.title[index].copyWith(
                        activeColor: activeColor[index]? Colors.orange: Colors.black
                      )
                    ],
                  ),


                  Row(
                    children: [
                      
SizedBox(width: 50,),

Expanded(child: FadeTransition(opacity:   _annimationsOpavity [index],

child: SizeTransition(sizeFactor: _annimations[index],
child: e,),

))


                    ],
                  ),

                ],
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

class PTitle extends StatelessWidget {

  late String title, subTitle;
  late Color activeColor;
   PTitle({required this.activeColor, required this.subTitle, required this.title});
  @override
  Widget build(BuildContext context) {

  if (activeColor == null) activeColor = Colors.black;

    return Column(
      children: [


         Text(title ?? this.title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: activeColor ?? this.activeColor)),
        if (subTitle != null) Text(subTitle),
      ],
    );
  }

 copyWith({ String? title, subTitle, required Color activeColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? this.title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: activeColor ?? this.activeColor)),
        Text(
          subTitle ?? this.subTitle ?? "",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }


  
}




/*



class PTitle extends StatelessWidget {
  String title, subTitle;
  Color activeColor;
  PTitle({this.activeColor, this.subTitle, @required this.title});
  @override
  Widget build(BuildContext context) {
    if (activeColor == null) activeColor = Colors.black;
    return Column(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: activeColor)),
        if (subTitle != null) Text(subTitle),
      ],
    );
  }

  copyWith({String title, subTitle, Color activeColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? this.title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: activeColor ?? this.activeColor)),
        Text(
          subTitle ?? this.subTitle ?? "",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}


*/ 