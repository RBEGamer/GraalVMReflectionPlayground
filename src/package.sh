#!/usr/bin/env bash

jar cfe reflection.jar com.sach.reflections.basics.InspectClass com/sach/reflections/basics/*.class com/sach/reflections/annotations/*.class com/sach/reflections/domain/*.class

java -jar ./reflection.jar