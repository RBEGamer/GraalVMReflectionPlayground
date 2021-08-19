#!/usr/bin/env bash
cd "$(dirname "$0")"
pwd
ls

echo '-----------------------'
echo '------- JAR TEST ------'
echo '-----------------------'

bash -c 'time java -jar ./reflection.jar'

echo '-----------------------'
echo '-- NATIVE IMAGE TEST --'
echo '-----------------------'


bash -c 'time ./native_image/reflection'
