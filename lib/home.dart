import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterlux/models/provider.dart';
import 'package:flutterlux/utils/colors.dart';
import 'package:light/light.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   startListening();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        child: new Center(
          child: Consumer<DataProvider>(
            builder: (context, model, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                        radiusFactor: 0.9,
                        maximum: 500,
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Text(model.lux.toString(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold))),
                              angle: 90,
                              positionFactor: 0.4)
                        ],
                        pointers: <GaugePointer>[
                          RangePointer(
                            gradient: const SweepGradient(
                              colors: <Color>[Colors.yellow, Colors.amber],
                              stops: <double>[0.25, 0.75],
                            ),
                            value: double.parse(model.lux.toString()),
                            cornerStyle: CornerStyle.bothCurve,
                            width: 24,
                          )
                        ],
                        startAngle: 270,
                        endAngle: 270,
                        axisLineStyle: AxisLineStyle(
                          cornerStyle: CornerStyle.bothCurve,
                          thickness: 24,
                          thicknessUnit: GaugeSizeUnit.logicalPixel,
                        )),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(color: Colors.white))),
                          backgroundColor: MaterialStateProperty.all(
                              model.start ? Colors.white : Colors.transparent)),
                      onPressed: () {
                        model.start
                            ? model.stopListening()
                            : model.startListening();
                      },
                      child: Text(
                        model.start ? 'Stop' : 'Start',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                model.start ? AppColors.bgColor : Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
