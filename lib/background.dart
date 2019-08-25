import 'package:flutter/material.dart';
import 'package:quotes/gradients.dart';
import 'package:quotes/main.dart';

Stack circle() {
    return new Stack(
            children: <Widget>[
              new Container(
                color: greyColor,
              ),
              new Positioned(
                top: -75.0,
                right: 85.0,
                child: new Container(
                  height: 120.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                      gradient: yellowOrangeGradient, shape: BoxShape.circle),
                ),
              ),
              new Positioned(
                right: -7.0,
                top: 620.0,
                child: new Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      gradient: yellowOrangeGradient, shape: BoxShape.circle),
                ),
              ),
              new Positioned(
                right: -75.0,
                top: 245.0,
                child: new Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      gradient: blackSexyGradient, shape: BoxShape.circle),
                ),
              ),
              new Positioned(
                left: -75.0,
                top: 775.0,
                child: new Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      gradient: blackBlueGradient, shape: BoxShape.circle),
                ),
              ),
              new Positioned(
                left: 65.0,
                top: 200.0,
                child: new Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      gradient: skyBlueGradient, shape: BoxShape.circle),
                ),
              ),
              new Positioned(
                left: 65.0,
                top: 575.0,
                child: new Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      gradient: thodaSexyGradient, shape: BoxShape.circle),
                ),
              ),
              new Positioned(
                left: 325.0,
                top: 845.0,
                child: new Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      gradient: violetSexyGradient, shape: BoxShape.circle),
                ),
              ),
            ],
          );
  }
