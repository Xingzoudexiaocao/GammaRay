# GammaRay uses the CMake buildsystem.

## Some notes about CMake

Please see the comments at the top of CMakeLists.txt for
the available configuration options you can pass to cmake.

The installation directory defaults to `/usr/local` on UNIX
`C:/Program Files` on Windows and `/Applications` on MacOS.
You can change this location by passing the option
`-DCMAKE_INSTALL_PREFIX=/install/path` to cmake.

Your system's installation of Qt will be used by default, which
may not be the same as the Qt returned by `qmake -v`.
To specify the Qt version to build against, use cmake option
`CMAKE_PREFIX_PATH`, and point it to the gcc(_64) folder of your 
installation:

`% cmake -DCMAKE_PREFIX_PATH=$HOME/Qt/5.11.2/gcc_64 ..`

## Build requirements

To build GammaRay you will need *at least*:

 - CMake 3.16.0
 - a C++ compiler with C++11 support
 - Qt 5.5 or higher, or Qt 6

Optional FOSS packages (eg. KDSME, etc) provide extra functionality.
See the "Optional Dependencies" section below for more details.


## Building GammaRay

### Unix

Building on Unix with gcc or clang:

```
% mkdir build
% cd build
% cmake ..
% make
% make install
```

### Windows (MSVC)

Building on Windows with Microsoft Visual Studio:
From a command prompt for the version of MSVC you want to use

```
% mkdir build
% cd build
% cmake -G "NMake Makefiles" ..
% nmake
% nmake install
```

### Windows (MinGW)

Building on Windows with MinGW:
Make sure you have the path to the MinGW programs in %PATH% first, for example:

```
% set "PATH=c:\MinGW\mingw64\bin;%PATH%"
```

Now build:

```
% mkdir build
% cd build
% cmake -G "MinGW Makefiles" ..
% mingw32-make
% mingw32-make install
```

### Android

Build on Android:

```
$ mkdir android-build
$ cd android-build
$ export ANDROID_NDK=/path/to/android-ndk
$ cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
        -DCMAKE_FIND_ROOT_PATH=/android/qt5/install/path \
        -DCMAKE_INSTALL_PREFIX=/install/path ..
$ make [-j CPU_NUMBER+2]
$ make install
```

For more information about building CMake projects on Android see
https://developer.android.com/ndk/guides/cmake

Using GammaRay on Android:

 - add GammaRay probe to your android .pro file
 
```
myproject.pro
....
android: QT += GammaRayProbe
...
```

- build & deploy and run your project
- forward GammaRay's socket

```
$ adb forward tcp:11732 localfilesystem:/data/data/YOUR_ANDROID_PACKAGE_NAME(e.g. com.kdab.example)/files/+gammaray_socket
````

- run GammaRay GUI and connect to localhost:11732
- after you've finished, remove the forward:

```
$ adb forward --remove tcp:11732
```

or

```
$ adb forward --remove-all
```

... to remove all forwards

### Additional notes

To build a debug version pass `-DCMAKE_BUILD_TYPE=Debug` to cmake.

## Cross-compiling GammaRay

You'll find more information on this in the wiki:
https://github.com/KDAB/GammaRay/wiki/Cross-compiling-GammaRay

== Force a probe only build ==
If you already built GammaRay in the past and that you want to support more probes,
you don't need to rebuild entirely GammaRay for this specific Qt version.
You can instead just build the GammaRay probe for the new Qt version and install it
in you previous GammaRay installation.

You can make probe only builds that way:

```
  % cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/path/to/Qt/version/ \
    -DGAMMARAY_PROBE_ONLY_BUILD=true \
    -DGAMMARAY_BUILD_UI=false  \
    -DCMAKE_INSTALL_PREFIX=/path/to/your/previous/gammaray/prefix \
    /path/to/gammaray/sources
```

You can still use any cmake flags you want like `CMAKE_DISABLE_FIND_PACKAGE_<PACKAGE>` etc.


## Optional Dependencies

GammaRay relies on optional (FOSS) dependencies to help provide some of its
functionality, most prominently KDSME (https://github.com/KDAB/KDStateMachineEditor).

When you run cmake it will inform you about these missing dependencies.

You can also force CMake to ignore any or all of the optional dependencies
by passing the option `-DCMAKE_DISABLE_FIND_PACKAGE_<PACKAGE>=True`.

For instance:

```
# tell cmake to ignore VTK
% cmake -DCMAKE_DISABLE_FIND_PACKAGE_VTK=True
```


## RPATH Settings (Linux only)

By default GammaRay will be build with RPATHs set to the absolute install location
of its dependencies (such as Qt). This is useful for easily using a self-built
GammaRay, but it might not be what you want when building installers or packages.

You can therefore change this via the following CMake options:
- `CMAKE_INSTALL_RPATH_USE_LINK_PATH=OFF` will disable settings RPATH to the location
  of dependencies. It will however still set relative RPATHs between the various
  GammaRay components. This is typically desired for Linux distros, where GammaRay's
  dependencies are all in the default search path anyway.
- `CMAKE_INSTALL_RPATH=<path(s)>` will add the specified absolute paths to RPATH,
  additionally to the relative RPATHs between GammaRay's components.
