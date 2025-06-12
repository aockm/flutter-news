import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news/common/entitys/entitys.dart';
import 'package:news/common/utils/date.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';
import 'package:news/common/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:loading_animations/loading_animations.dart';

@RoutePage()
class DetailsPage extends StatefulWidget {
   final NewsItem? item;
  const DetailsPage({super.key,this.item});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final WebViewController controller;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.item!.url!))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => {
            Timer(Duration(seconds: 1), (){
              _removeWebViewAd();
            })
          },
          onPageFinished: (String url) {
            _getWebViewHeight();
            setState(() {
            _isPageFinished = true;
          });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url != widget.item!.url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        )
      )
      ..addJavaScriptChannel('Invoke', onMessageReceived: (JavaScriptMessage message){
        var webHeight = double.parse(message.message);
        log('页面高度:$webHeight');
        setState(() {
          _webViewHeight = webHeight;
        });
      });
    super.initState();
  }

  bool _isPageFinished = false;
  double _webViewHeight = 200;
  // 顶部导航
  PreferredSizeWidget _buildAppBar() {
    return transparentAppBar(
        context: context,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: AppColors.primaryText,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: AppColors.primaryText,
            ),
            onPressed: () {
              Share.share('${widget.item?.title} ${widget.item?.url}');
            },
          ),
        ]);
  }

  // 页标题
  Widget _buildPageTitle() {
    return Container(
      margin: EdgeInsets.all(duSetWidth(10)),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // 标题
              Text(
                widget.item!.category!,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.normal,
                  fontSize: duSetFontSize(30),
                  color: AppColors.thirdElement,
                ),
              ),
              // 作者
              Text(
                widget.item!.author!,
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.normal,
                  fontSize: duSetFontSize(14),
                  color: AppColors.thirdElementText,
                ),
              ),
            ],
          ),
          Spacer(),
          // 标志
          CircleAvatar(
            //头像半径
            radius: duSetWidth(22),
            backgroundImage: AssetImage("assets/images/channel-fox.png"),
          ),
        ],
      ),
    );
  }
  // 页头部
  Widget _buildPageHeader() {
    return Container(
      margin: EdgeInsets.all(duSetWidth(10)),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 图
          imageCached(
            widget.item!.thumbnail!,
            width: duSetWidth(335),
            height: duSetHeight(290),
          ),
          // 标题
          Container(
            margin: EdgeInsets.only(top: duSetHeight(10)),
            child: Text(
              widget.item!.title!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
                fontSize: duSetFontSize(24),
                height: 1,
              ),
            ),
          ),
          // 一行 3 列
          Container(
            margin: EdgeInsets.only(top: duSetHeight(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // 分类
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 120,
                  ),
                  child: Text(
                    widget.item!.category!,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.normal,
                      color: AppColors.secondaryElementText,
                      fontSize: duSetFontSize(14),
                      height: 1,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                // 添加时间
                Container(
                  width: duSetWidth(15),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 120,
                  ),
                  child: Text(
                    '• ${duTimeLineFormat(widget.item!.addtime!)}',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.normal,
                      color: AppColors.thirdElementText,
                      fontSize: duSetFontSize(14),
                      height: 1,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // web内容
  Widget _buildWebView() {
    return SizedBox(
      height: _webViewHeight,
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }

   // 删除广告
  _removeWebViewAd() async {
    await controller.runJavaScript('''
        try {
          function removeElement(elementName){
            let _element = document.getElementById(elementName);
            if(!_element) {
              _element = document.querySelector(elementName);
            }
            if(!_element) {
              return;
            }
            let _parentElement = _element.parentNode;
            if(_parentElement){
                _parentElement.removeChild(_element);
            }
          }
          

          removeElement('module-engadget-deeplink-top-ad');
          removeElement('module-engadget-deeplink-streams');
          removeElement('footer');
          removeElement('.head_18313');
          removeElement('.phone_footer');
          removeElement('.page_bottom');
          removeElement('.XUQIU18897_tonglan');
        } catch{}
        ''');
  }

  // 获取页面高度
  _getWebViewHeight() async {
    await controller.runJavaScript('''
        try {
          // Invoke.postMessage([document.body.clientHeight,document.documentElement.clientHeight,document.documentElement.scrollHeight]);
          let scrollHeight = document.documentElement.scrollHeight;
          if (scrollHeight) {
            Invoke.postMessage(scrollHeight);
          }
          Invoke.postMessage(scrollHeight);
        } catch {}
        '''
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildPageTitle(),
                  Divider(height: 1),
                  // _buildPageHeader(),
                  _buildWebView(),
                ],
              ),
            ),
            _isPageFinished == true
                ? Container()
                : Align(
                    alignment: Alignment.center,
                    child: LoadingBouncingGrid.square(),
                  ),
          ]
        )
    );
  }
}
