// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

// void main() => runApp(CarouselDemo());

// final themeMode = ValueNotifier(2);

// class CarouselDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       builder: (context, value, g) {
//         return MaterialApp(
//           initialRoute: '/',
//           darkTheme: ThemeData.dark(),
//           themeMode: ThemeMode.values.toList()[value as int],
//           debugShowCheckedModeBanner: false,
//           routes: {
//             '/': (ctx) => CarouselDemoHome(),
//             '/basic': (ctx) => BasicDemo(),
//             '/nocenter': (ctx) => NoCenterDemo(),
//             '/image': (ctx) => ImageSliderDemo(),
//             '/complicated': (ctx) => ComplicatedImageDemo(),
//             '/enlarge': (ctx) => EnlargeStrategyDemo(),
//             '/manual': (ctx) => ManuallyControlledSlider(),
//             '/noloop': (ctx) => NoonLoopingDemo(),
//             '/vertical': (ctx) => VerticalSliderDemo(),
//             '/fullscreen': (ctx) => FullscreenSliderDemo(),
//             '/ondemand': (ctx) => OnDemandCarouselDemo(),
//             '/indicator': (ctx) => CarouselWithIndicatorDemo(),
//             '/prefetch': (ctx) => PrefetchImageDemo(),
//             '/reason': (ctx) => CarouselChangeReasonDemo(),
//             '/position': (ctx) => KeepPageviewPositionDemo(),
//             '/multiple': (ctx) => MultipleItemDemo(),
//             '/zoom': (ctx) => EnlargeStrategyZoomDemo(),
//           },
//         );
//       },
//       valueListenable: themeMode,
//     );
//   }
// }

// class DemoItem extends StatelessWidget {
//   final String title;
//   final String route;
//   DemoItem(this.title, this.route);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       onTap: () {
//         Navigator.pushNamed(context, route);
//       },
//     );
//   }
// }

// class CarouselDemoHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carousel demo'),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.nightlight_round),
//               onPressed: () {
//                 themeMode.value = themeMode.value == 1 ? 2 : 1;
//               })
//         ],
//       ),
//       body: ListView(
//         children: <Widget>[
//           DemoItem('Basic demo', '/basic'),
//           DemoItem('No center mode demo', '/nocenter'),
//           DemoItem('Image carousel slider', '/image'),
//           DemoItem('More complicated image slider', '/complicated'),
//           DemoItem('Enlarge strategy demo slider', '/enlarge'),
//           DemoItem('Manually controlled slider', '/manual'),
//           DemoItem('Noon-looping carousel slider', '/noloop'),
//           DemoItem('Vertical carousel slider', '/vertical'),
//           DemoItem('Fullscreen carousel slider', '/fullscreen'),
//           DemoItem('Carousel with indicator controller demo', '/indicator'),
//           DemoItem('On-demand carousel slider', '/ondemand'),
//           DemoItem('Image carousel slider with prefetch demo', '/prefetch'),
//           DemoItem('Carousel change reason demo', '/reason'),
//           DemoItem('Keep pageview position demo', '/position'),
//           DemoItem('Multiple item in one screen demo', '/multiple'),
//           DemoItem('Enlarge strategy: zoom demo', '/zoom'),
//         ],
//       ),
//     );
//   }
// }

// class BasicDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<int> list = [1, 2, 3, 4, 5];
//     return Scaffold(
//       appBar: AppBar(title: Text('Basic demo')),
//       body: Container(
//           child: CarouselSlider(
//         options: CarouselOptions(),
//         items: list
//             .map((item) => Container(
//                   child: Center(child: Text(item.toString())),
//                   color: Colors.green,
//                 ))
//             .toList(),
//       )),
//     );
//   }
// }

// class NoCenterDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<int> list = [1, 2, 3, 4, 5];
//     return Scaffold(
//       appBar: AppBar(title: Text('Basic demo')),
//       body: Container(
//           child: CarouselSlider(
//         options: CarouselOptions(
//           disableCenter: true,
//         ),
//         items: list
//             .map((item) => Container(
//                   child: Text(item.toString()),
//                   color: Colors.green,
//                 ))
//             .toList(),
//       )),
//     );
//   }
// }

// class ImageSliderDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Image slider demo')),
//       body: Container(
//           child: CarouselSlider(
//         options: CarouselOptions(),
//         items: imgList
//             .map((item) => Container(
//                   child: Center(
//                       child:
//                           Image.network(item, fit: BoxFit.cover, width: 1000)),
//                 ))
//             .toList(),
//       )),
//     );
//   }
// }

// final List<Widget> imageSliders = imgList
//     .map((item) => Container(
//           child: Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 child: Stack(
//                   children: <Widget>[
//                     Image.network(item, fit: BoxFit.cover, width: 1000.0),
//                     Positioned(
//                       bottom: 0.0,
//                       left: 0.0,
//                       right: 0.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(200, 0, 0, 0),
//                               Color.fromARGB(0, 0, 0, 0)
//                             ],
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                           ),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 20.0),
//                         child: Text(
//                           'No. ${imgList.indexOf(item)} image',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ))
//     .toList();

// class ComplicatedImageDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Complicated image slider demo')),
//       body: Container(
//         child: CarouselSlider(
//           options: CarouselOptions(
//             autoPlay: true,
//             aspectRatio: 2.0,
//             enlargeCenterPage: true,
//           ),
//           items: imageSliders,
//         ),
//       ),
//     );
//   }
// }

// class EnlargeStrategyDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Complicated image slider demo')),
//       body: Container(
//         child: CarouselSlider(
//           options: CarouselOptions(
//             autoPlay: true,
//             aspectRatio: 2.0,
//             enlargeCenterPage: true,
//             enlargeStrategy: CenterPageEnlargeStrategy.height,
//           ),
//           items: imageSliders,
//         ),
//       ),
//     );
//   }
// }

// class ManuallyControlledSlider extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ManuallyControlledSliderState();
//   }
// }

// class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
//   final CarouselSliderController _controller = CarouselSliderController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Manually controlled slider')),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               CarouselSlider(
//                 items: imageSliders,
//                 options: CarouselOptions(enlargeCenterPage: true, height: 200),
//                 carouselController: _controller,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Flexible(
//                     child: ElevatedButton(
//                       onPressed: () => _controller.previousPage(),
//                       child: Text('←'),
//                     ),
//                   ),
//                   Flexible(
//                     child: ElevatedButton(
//                       onPressed: () => _controller.nextPage(),
//                       child: Text('→'),
//                     ),
//                   ),
//                   ...Iterable<int>.generate(imgList.length).map(
//                     (int pageIndex) => Flexible(
//                       child: ElevatedButton(
//                         onPressed: () => _controller.animateToPage(pageIndex),
//                         child: Text("$pageIndex"),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }

// class NoonLoopingDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Noon-looping carousel demo')),
//       body: Container(
//           child: CarouselSlider(
//         options: CarouselOptions(
//           aspectRatio: 2.0,
//           enlargeCenterPage: true,
//           enableInfiniteScroll: false,
//           initialPage: 2,
//           autoPlay: true,
//         ),
//         items: imageSliders,
//       )),
//     );
//   }
// }

// class VerticalSliderDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Vertical sliding carousel demo')),
//       body: Container(
//           child: CarouselSlider(
//         options: CarouselOptions(
//           aspectRatio: 2.0,
//           enlargeCenterPage: true,
//           scrollDirection: Axis.vertical,
//           autoPlay: true,
//         ),
//         items: imageSliders,
//       )),
//     );
//   }
// }

// class FullscreenSliderDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Fullscreen sliding carousel demo')),
//       body: Builder(
//         builder: (context) {
//           final double height = MediaQuery.of(context).size.height;
//           return CarouselSlider(
//             options: CarouselOptions(
//               height: height,
//               viewportFraction: 1.0,
//               enlargeCenterPage: false,
//               // autoPlay: false,
//             ),
//             items: imgList
//                 .map((item) => Container(
//                       child: Center(
//                           child: Image.network(
//                         item,
//                         fit: BoxFit.cover,
//                         height: height,
//                       )),
//                     ))
//                 .toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// class OnDemandCarouselDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('On-demand carousel demo')),
//       body: Container(
//           child: CarouselSlider.builder(
//         itemCount: 100,
//         options: CarouselOptions(
//           aspectRatio: 2.0,
//           enlargeCenterPage: true,
//           autoPlay: true,
//         ),
//         itemBuilder: (ctx, index, realIdx) {
//           return Container(
//             child: Text(index.toString()),
//           );
//         },
//       )),
//     );
//   }
// }

// class CarouselWithIndicatorDemo extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _CarouselWithIndicatorState();
//   }
// }

// class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
//   int _current = 0;
//   final CarouselSliderController _controller = CarouselSliderController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Carousel with indicator controller demo')),
//       body: Column(children: [
//         Expanded(
//           child: CarouselSlider(
//             items: imageSliders,
//             carouselController: _controller,
//             options: CarouselOptions(
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 aspectRatio: 2.0,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _current = index;
//                   });
//                 }),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: imgList.asMap().entries.map((entry) {
//             return GestureDetector(
//               onTap: () => _controller.animateToPage(entry.key),
//               child: Container(
//                 width: 12.0,
//                 height: 12.0,
//                 margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: (Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white
//                             : Colors.black)
//                         .withValues(alpha: _current == entry.key ? 0.9 : 0.4)),
//               ),
//             );
//           }).toList(),
//         ),
//       ]),
//     );
//   }
// }

// class PrefetchImageDemo extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _PrefetchImageDemoState();
//   }
// }

// class _PrefetchImageDemoState extends State<PrefetchImageDemo> {
//   final List<String> images = [
//     'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
//     'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
//     'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
//     'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
//     'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
//     'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
//     'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
//   ];

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       images.forEach((imageUrl) {
//         precacheImage(NetworkImage(imageUrl), context);
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Prefetch image slider demo')),
//       body: Container(
//           child: CarouselSlider.builder(
//         itemCount: images.length,
//         options: CarouselOptions(
//           autoPlay: true,
//           aspectRatio: 2.0,
//           enlargeCenterPage: true,
//         ),
//         itemBuilder: (context, index, realIdx) {
//           return Container(
//             child: Center(
//                 child: Image.network(images[index],
//                     fit: BoxFit.cover, width: 1000)),
//           );
//         },
//       )),
//     );
//   }
// }

// class CarouselChangeReasonDemo extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _CarouselChangeReasonDemoState();
//   }
// }

// class _CarouselChangeReasonDemoState extends State<CarouselChangeReasonDemo> {
//   String reason = '';
//   final CarouselSliderController _controller = CarouselSliderController();

//   void onPageChange(int index, CarouselPageChangedReason changeReason) {
//     setState(() {
//       reason = changeReason.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Change reason demo')),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: CarouselSlider(
//                 items: imageSliders,
//                 options: CarouselOptions(
//                   enlargeCenterPage: true,
//                   aspectRatio: 16 / 9,
//                   onPageChanged: onPageChange,
//                   autoPlay: true,
//                 ),
//                 carouselController: _controller,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Flexible(
//                   child: ElevatedButton(
//                     onPressed: () => _controller.previousPage(),
//                     child: Text('←'),
//                   ),
//                 ),
//                 Flexible(
//                   child: ElevatedButton(
//                     onPressed: () => _controller.nextPage(),
//                     child: Text('→'),
//                   ),
//                 ),
//                 ...Iterable<int>.generate(imgList.length).map(
//                   (int pageIndex) => Flexible(
//                     child: ElevatedButton(
//                       onPressed: () => _controller.animateToPage(pageIndex),
//                       child: Text("$pageIndex"),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Center(
//               child: Column(
//                 children: [
//                   Text('page change reason: '),
//                   Text(reason),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }

// class KeepPageviewPositionDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Keep pageview position demo')),
//       body: ListView.builder(itemBuilder: (ctx, index) {
//         if (index == 3) {
//           return Container(
//               child: CarouselSlider(
//             options: CarouselOptions(
//               aspectRatio: 2.0,
//               enlargeCenterPage: true,
//               pageViewKey: PageStorageKey<String>('carousel_slider'),
//             ),
//             items: imageSliders,
//           ));
//         } else {
//           return Container(
//             margin: EdgeInsets.symmetric(vertical: 20),
//             color: Colors.blue,
//             height: 200,
//             child: Center(
//               child: Text('other content'),
//             ),
//           );
//         }
//       }),
//     );
//   }
// }

// class MultipleItemDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Multiple item in one slide demo')),
//       body: Container(
//           child: CarouselSlider.builder(
//         options: CarouselOptions(
//           aspectRatio: 2.0,
//           enlargeCenterPage: false,
//           viewportFraction: 1,
//         ),
//         itemCount: (imgList.length / 2).round(),
//         itemBuilder: (context, index, realIdx) {
//           final int first = index * 2;
//           final int second = first + 1;
//           return Row(
//             children: [first, second].map((idx) {
//               return Expanded(
//                 flex: 1,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   child: Image.network(imgList[idx], fit: BoxFit.cover),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       )),
//     );
//   }
// }

// class EnlargeStrategyZoomDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('enlarge strategy: zoom demo')),
//       body: Container(
//         child: CarouselSlider(
//           options: CarouselOptions(
//             aspectRatio: 2.0,
//             enlargeCenterPage: true,
//             enlargeStrategy: CenterPageEnlargeStrategy.zoom,
//             enlargeFactor: 0.4,
//           ),
//           items: imageSliders,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
// import 'package:input_quantity/input_quantity.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  int qtyInt = 123;
  double qtyDouble = 12.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'INPUT QUANTITY',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'by: pmatatias.dev',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                const Divider(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputQty(
                      maxVal: 50,
                      initVal: 10,
                      steps: 10,
                      minVal: -50,
                      qtyFormProps: QtyFormProps(enableTyping: false),
                      decoration: QtyDecorationProps(
                        isBordered: false,
                        minusBtn: Icon(
                          Icons.flight_land_rounded,
                          color: Colors.purple,
                        ),
                        plusBtn:
                            Icon(Icons.flight_takeoff, color: Colors.indigo),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Text(
                          "- Output: int,double, num\n- initVal, maxVal, minVal, steps \n- Custom: icon,decoration,etc"),
                    )
                  ],
                ),
                const Divider(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputQty(
                        decoration: QtyDecorationProps(
                            isBordered: false,
                            borderShape: BorderShapeBtn.circle,
                            width: 12)),
                    SizedBox(width: 30),
                    Expanded(
                        child: Text(
                            "- Ontap\n- Longpress \n- Typing input Manually"))
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputQty(
                      qtyFormProps: QtyFormProps(
                        controller: _controller,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Expanded(
                      child: Text("use controller to get value (string)"),
                    )
                  ],
                ),
                const Divider(height: 50),
                InputQty(
                  maxVal: 100,
                  qtyFormProps: QtyFormProps(
                    controller: _controller,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Use validator')),
                        InputQty(
                          initVal: 1,
                          steps: 1,
                          minVal: 1,
                          maxVal: 100,
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else if (value >= 200) {
                              return "More than available quantity";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const Center(
                        child: Text(
                      "OR",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Message builder',
                          ),
                        ),
                        InputQty(
                          initVal: 0,
                          minVal: -100,
                          maxVal: 100,
                          steps: 2,
                          messageBuilder: (minVal, maxVal, value) {
                            if (value == null) return null;
                            if (value < -20) {
                              return const Text(
                                "Reach my limit",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else if (value > 20) {
                              return const Text(
                                "Reach my limit",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Text("Value : $value",
                                  textAlign: TextAlign.center);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 50),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('integer')),
                        InputQty.int(
                          initVal: 0,
                          steps: 10,
                          minVal: -100,
                        ),
                      ],
                    ),
                    Center(
                        child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'double',
                          ),
                        ),
                        InputQty(
                          // decimalPlaces: 4,
                          initVal: 0.0,
                          minVal: -100.0,
                          maxVal: 100.0,
                          steps: 0.1,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Divider(),

                const Text("Custom Border:"),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: InputQty(
                    isIntrinsicWidth: false,
                    qtyFormProps: const QtyFormProps(),
                    decoration: QtyDecorationProps(
                        qtyStyle: QtyStyle.btnOnRight,
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 5, color: Colors.green),
                            borderRadius: BorderRadius.circular(6)),
                        minusBtn: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.keyboard_arrow_down_sharp,
                              color: Colors.blue),
                        ),
                        plusBtn: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.blue,
                          ),
                        )),
                    onQtyChanged: (val) {},
                  ),
                ),
                const Divider(height: 30),

                // ElevatedButton(
                //     onPressed: () {
                //       _formKey.currentState!.validate();
                //     },
                //     child: const Text("validate")),
                // const Divider(),

                const Text("Style options:"),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Left",
                          textAlign: TextAlign.center),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnLeft,
                          width: 12,
                          fillColor: Colors.black12,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Right",
                          textAlign: TextAlign.center),
                      qtyFormProps:
                          const QtyFormProps(cursorColor: Colors.amber),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnRight,
                          width: 12,
                          fillColor: Colors.black12,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                InputQty.int(
                  messageBuilder: (minVal, maxVal, value) =>
                      const Text("Classic", textAlign: TextAlign.center),
                  decoration: const QtyDecorationProps(
                      qtyStyle: QtyStyle.classic,
                      width: 12,
                      fillColor: Colors.black12,
                      isBordered: false,
                      borderShape: BorderShapeBtn.none),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Right Horizontal",
                          textAlign: TextAlign.center),
                      qtyFormProps:
                          const QtyFormProps(cursorColor: Colors.amber),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnLeft,
                          width: 12,
                          orientation: ButtonOrientation.horizontal,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                    InputQty.int(
                      messageBuilder: (minVal, maxVal, value) => const Text(
                          "Button on Right Horizontal",
                          textAlign: TextAlign.center),
                      qtyFormProps:
                          const QtyFormProps(cursorColor: Colors.amber),
                      decoration: const QtyDecorationProps(
                          qtyStyle: QtyStyle.btnOnRight,
                          width: 12,
                          orientation: ButtonOrientation.horizontal,
                          isBordered: false,
                          borderShape: BorderShapeBtn.square),
                    ),
                  ],
                ),

                // IconButton(
                //     onPressed: () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const Example1(),
                //         )),
                //     icon: const Icon(Icons.exit_to_app))
              ],
            ),
          ),
        ),
      ),
    );
  }
}