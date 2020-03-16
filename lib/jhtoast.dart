library jhtoast;

/**
 *  jhToast.dart
 *
 *  Created by iotjin on 2020/03/06.
 *  description: 支持的效果：文字，图文，加载中,水平垂直两种布局
 *  github: https://github.com/iotjin
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:back_button_interceptor/back_button_interceptor.dart';

const Color _bgColor = Colors.black87;
const Color _contentColor = Colors.white;
const double _textFontSize = 15.0;
const double _radius = 3.0;
const double _imgWH = 30.0;
const int _time = 1;
enum _Orientation { horizontal, vertical }

class JhToast{

  static Future showText(
      BuildContext context, {
        @required String msg,
        int closeTime =_time,
      }){
    return _showToast(context: context, msg: msg,stopEvent: true,closeTime:closeTime);
  }
  static Future showSuccess(
      BuildContext context, {
        @required String msg,
        int closeTime =_time,
      }){
    Widget img = Icon(Icons.check_circle_outline, size: _imgWH, color: _contentColor);
    return _showToast(context: context, msg: msg,image: img ,stopEvent: true,closeTime:closeTime);
  }
  static Future showError(
      BuildContext context, {
        @required String msg,
        int closeTime =_time,
      }){
    Widget img = Icon(Icons.highlight_off, size: _imgWH, color: _contentColor);
    return _showToast(context: context, msg: msg,image: img,stopEvent: true,closeTime:closeTime);
  }
  static Future showInfo(
      BuildContext context, {
        @required String msg,
        int closeTime =_time,
      }){
    Widget img = Icon(Icons.info_outline, size: _imgWH, color: _contentColor);
    return _showToast(context: context, msg: msg,image: img,stopEvent: true,closeTime:closeTime);
  }
  static Future showImageText(
      BuildContext context, {
        @required String msg,
        @required Widget image,
        int closeTime =_time,
      }){
    return _showToast(context: context, msg: msg,image: image,stopEvent: true,closeTime:closeTime);
  }
  static Future showImageText_horizontal(
      BuildContext context, {
        @required String msg,
        @required Widget image,
        int closeTime =_time,
      }){
    return _showToast(context: context, msg: msg,image: image,
        stopEvent: true,orientation:_Orientation.horizontal,closeTime:closeTime);
  }

  static _HideCallback showLoadingText(
      BuildContext context, {
        String msg = "加载中...",
      }){
    return _showJhToast(context: context, msg: msg, isLoading: true,stopEvent: true,orientation:_Orientation.vertical);
  }
  static _HideCallback showLoadingText_horizontal(
      BuildContext context, {
        String msg = "加载中...",
      }){
    return _showJhToast(context: context, msg: msg, isLoading: true,stopEvent: true,orientation: _Orientation.horizontal);
  }

  static _HideCallback showLoadingText_iOS(
      BuildContext context, {
        String msg = "加载中...",
      }){
    Widget img = Image.asset("assets/images/loading.gif",width: _imgWH,package: "jhtoast");
    return _showJhToast(context: context, msg: msg,image: img, isLoading: false,stopEvent: true);

  }




}



Future _showToast(
    {@required BuildContext context,
      String msg,
      stopEvent = false,
      Widget image,
      int closeTime,
      _Orientation orientation = _Orientation.vertical
    }) {
  msg = msg;
  var hide = _showJhToast(
      context: context,
      msg: msg,
      isLoading: false,
      stopEvent: stopEvent,
      image: image,
      orientation: orientation
  );
  return Future.delayed(Duration(seconds:closeTime), () {
    hide();
  });
}









typedef _HideCallback = Future Function();

class JhToastWidget extends StatelessWidget {
  const JhToastWidget({
    Key key,
    @required this.msg,
    this.image,
    @required this.isLoading,
    @required this.stopEvent,
    @required this.orientation,

  }) : super(key: key);

  final bool stopEvent;
  final Widget image;
  final String msg;
  final bool isLoading;
  final _Orientation orientation;

  @override
  Widget build(BuildContext context) {

    Widget topW;
    bool isHidden;
    if(this.isLoading ==true){
      isHidden = false;
      topW = CircularProgressIndicator(strokeWidth: 3.0,
        valueColor:AlwaysStoppedAnimation<Color>(_contentColor),);
    }else{
      isHidden = image==null?true:false;
      topW = image;
    }

    var widget =
    Material(
//        color: Colors.yellow,
        color: Colors.transparent,
        child:
        Align(
            alignment: Alignment.center,
            child:
            Container(
              margin: const EdgeInsets.all(50.0),
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.circular(_radius),
              ),
              child: ClipRect(
                child:
                orientation == _Orientation.vertical
                    ?
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Offstage(
                      offstage: isHidden,
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.all(4.0),
//                            child: Icon(Icons.check_circle_outline, size: 30, color: Colors.white,),
                        child: topW,
                      ),
                    ),
                    Text(msg,
                        style: TextStyle(fontSize: _textFontSize,color: _contentColor), textAlign: TextAlign.center),
                  ],
                )
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: isHidden,
                      child:Container(
                        width: 36.0,
                        height: 36.0,
                        margin: EdgeInsets.only(right: 8.0),
                        padding: EdgeInsets.all(4.0),
                        child: topW,
                      ),
                    ),
                    Text(msg,
                        style: TextStyle(fontSize: _textFontSize,color: _contentColor), textAlign: TextAlign.center),
                  ],
                ),


              ),
            )
        )

    );
    return IgnorePointer(
      ignoring: !stopEvent,
      child: widget,
    );
  }
}

int backButtonIndex = 2;
_HideCallback _showJhToast(
    {@required BuildContext context,
      @required String msg,
      Widget image,
      @required bool isLoading,
      bool stopEvent = false,
      _Orientation orientation = _Orientation.vertical,
    }) {

  Completer<VoidCallback> result = Completer<VoidCallback>();

  var backButtonName = 'JhToast$backButtonIndex';
  BackButtonInterceptor.add((stopDefaultButtonEvent){
    result.future.then((hide){
      hide();
    });
    return true;
  }, zIndex: backButtonIndex, name: backButtonName);
  backButtonIndex++;

  var overlay = OverlayEntry(
      maintainState: true,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          var hide = await result.future;
          hide();
          return false;
        },
        child: JhToastWidget(
          image: image,
          msg: msg,
          stopEvent: stopEvent,
          isLoading: isLoading,
          orientation: orientation,
        ),
      ));
  result.complete((){
    if(overlay == null){
      return;
    }
    overlay.remove();
    overlay = null;
    BackButtonInterceptor.removeByName(backButtonName);
  });
  Overlay.of(context).insert(overlay);
  return () async {
    var hide = await result.future;
    hide();
  };
}