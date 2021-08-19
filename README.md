# GraalVMJavaRefelctionPlayground

This repository includes a example for a Java application using reflections, running inside of a GraalVM compiled into a native-image using the `ReflectionConfigurationFiles` option.


# GraalVM Notes

In order to make reflections possible in the latest versions of GraalVM, an additional parameter must be passed to the `native-image` compiler.

`native-image .. -H:ReflectionConfigurationFiles=reflectconfig.json ..`

The `reflectconfig.json` file contains the reflection mappings of the java application.
The `name` attribute contains the class to enable reflection on.


```json
[
  {
    "name" : "com.sach.reflections.basics.InspectClass",
    "allDeclaredFields": true
  },
  {
    "name" : "com.sach.reflections.domain.User",
    "allDeclaredFields": true
  }
]
```

So finally a native-image can be compiled using the native-image compiler.

`$ native-image -H:ReflectionConfigurationFiles=reflectconfig.json -jar reflection.jar ./reflection_native_image`

## NOTE

The GraalVM native-image compiler 1.0.0, doesn't seem to like final fields, even if you enable writing with the "allowWriting": true property inside the `reflectconfig.json` file.


# INSTALLATION AND TEST


## COMPILE JAVA APPLICATION

All sources are located in the `./src` folder, including an IntelliJ project.
The JAVA source files are located in  `./src/src`. After a modification the new `reflection.jar` can be build with the ant framework:

```bash
cd ./src
ant compile # COMPILE
ant jar # PACKAGE
```
The existing `reflection.jar` can directly used, without a manual build.


## BUILD DOCKER IMAGE

In order to run the GraalVM, a Docker-Image was used for easy setup of the system.
The created Dockerfile installs the native-image tool and builds the `reflection.jar` application into an native-executable.

```bash
cd ./src
docker build -t graalvmjavarefelctionexample:latest . # BUILD DOCKERIMAGE
```


## RUN NATIVE Image

To finally run the generated native executable of the JAVA application, simply start the build container image.
The start-script `./src/benchmark.sh` will be executed after image startup.

```bash
docker run -it --rm graalvmjavarefelctionexample:latest # RUN BENCHMARK
```

To get into the container bash shell and perform further tests the following command can be used:

```bash
docker run -it --rm graalvmjavarefelctionexample:latest bash # BASH INTO CONTAINER
```


### RESULT

```bash
$ docker run -it --rm graalvmjavarefelctionexample:latest
-----------------------
------- JAR TEST ------
-----------------------
Private/Protected Methods:
Public fields:
Private/Protected fields:
	Name:userId
	Type:long
	Primitive:true

	Name:email
	Type:class java.lang.String
	Primitive:false

	Name:role
	Type:class java.lang.String
	Primitive:false

	Name:features
	Type:interface java.util.List
	Primitive:false

	Name:password
	Type:class java.lang.String
	Primitive:false


real	0m0.714s
user	0m0.333s
sys	0m0.178s




----------------------
-- NATIVE IMAGE TEST -
----------------------
Public constructors:
Private/Protected constructors:
Public Methods:
Private/Protected Methods:
Public fields:
Private/Protected fields:
	Name:userId
	Type:long
	Primitive:true

	Name:email
	Type:class java.lang.String
	Primitive:false

	Name:role
	Type:class java.lang.String
	Primitive:false

	Name:features
	Type:interface java.util.List
	Primitive:false

	Name:password
	Type:class java.lang.String
	Primitive:false


real	0m0.015s
user	0m0.003s
```
