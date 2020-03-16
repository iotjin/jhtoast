# jhtoast [![pub package](https://img.shields.io/pub/v/jhtoast.svg)](https://pub.flutter-io.cn/packages/jhtoast)
<br>

jhtoast - Flutter toast package. 支持的效果：文字，图文，加载中,水平垂直两种布局<br>

<br>
pub地址：https://pub.flutter-io.cn/packages/jhtoast



<br> 
<br> 
<br> 
<br> 

<img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhToast.gif" width="208" height="404">

<br>



## 使用


1. Add this to your package's pubspec.yaml file:

```
dependencies:
  jhtoast: ^0.1.0

```
2. Install it

```
flutter pub get

```
3. Import it
```
import 'package:jhtoast/jhtoast.dart';

```

## Examples

* 样式1 - 文字
```
    JhToast.showText(context, msg: "这是一条提示文字信息",
//      closeTime: 10
      );

```

* 样式2 - 成功
```
  JhToast.showSuccess(context, msg: "加载成功");
```

* 样式3 - 失败
```
 JhToast.showError(context, msg: "上传失败。请重新上传数据");
```

* 样式4 - 警告
```
 JhToast.showInfo(context, msg: "注意！注意！注意！");
```


* 样式5 - 加载中
```
    var hide =  JhToast.showLoadingText(context,
          msg:"正在加载中..."
      );
      Future.delayed(Duration(seconds: 2),(){
        hide();
      });

```

* 样式6 - 水平加载中
```
    var hide =  JhToast.showLoadingText_horizontal(context,
          msg:"正在加载中..."
      );
      Future.delayed(Duration(seconds: 2),(){
        hide();
      });
          
```

* 样式7 - 自定义图文
```

     Widget img = Image.asset("assets/images/toast_error.png");
    JhToast.showImageText(context,
      msg: "自定义图文",
      image: img);
              

```

* 样式8 - 水平自定义图文
```
    Widget img = Image.asset("assets/images/toast_success.png");
    JhToast.showImageText_horizontal(context,
      msg: "水平自定义图文",
      image: img);

```

* 样式9 - iOS样式加载中
```
       var hide =  JhToast.showLoadingText_iOS(context,
            msg:"正在加载中...",
          );
          Future.delayed(Duration(seconds: 2),(){
            hide();
          });
        }

```


