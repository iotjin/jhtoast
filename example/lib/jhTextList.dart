import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double lfSpace =10.0;
const Color lineColor = Color(0xFFE6E6E6);//230

typedef CallBack = void Function(int selectIndex,String selectStr);

class JhTextList extends StatelessWidget{

       final List dataArr;
       final String title;
       final CallBack callBack;
       JhTextList({
          this.title = "",
          this.dataArr,
          this.callBack,
        });

       Widget _getWidget(context, index) {
         return
         InkWell(
           child:
                 Container(
                     height: 50,
                     color: Colors.transparent,
                     child:
                           Stack(
                             alignment:Alignment.center,
                             children: <Widget>[
                               Positioned(
                                 left: lfSpace,
                                 child: Text(dataArr[index]),
                               ),
                               Positioned(
                                 right: lfSpace,
                                 child: Icon(Icons.arrow_forward_ios,size: 18,color: Color(0xFFC8C8C8)),
                               ),
                               Positioned(
                                   bottom: 0.0,
                                   left: lfSpace,
                                   right: 0,
                                   child: Container(color: lineColor,height: 1,)
                               ),
                             ],
                           )
               ),
             onTap:() {
              print("点击的index---"+index.toString());
              if(callBack !=null){callBack(index,dataArr[index]);}
              }
           );
       }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar:AppBar(
              title:Text(title,style:TextStyle (color: Colors.white))
          ),
          body:

          ListView.builder(
                itemCount: dataArr.length,
                itemBuilder: this._getWidget,
          )

        );
      }
}


//           Container(
//             decoration: BoxDecoration(
//                 border: Border(
//                   bottom: Divider.createBorderSide(context, width: 1),
//                 )
//             ),
//             child:
//             ListTile(
//                 title: Text(dataArr[index]),
//                   trailing: Icon(Icons.arrow_forward_ios,size: 18,color: Color(0xFFC8C8C8),),
//                       onTap:() {
//        //                 print("点击的index---"+index.toString());
//                           if(callBack !=null){callBack(index,dataArr[index]);}
//                          }
//                  )
//           );