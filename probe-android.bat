@ECHO off
echo Build:
echo|set /p=Model: 
adb shell getprop ro.product.model
echo|set /p=Manufacturer: 
adb shell getprop ro.product.manufacturer
echo|set /p=Brand: 
adb shell getprop ro.product.brand
echo|set /p=Product: 
adb shell getprop ro.product.name
echo|set /p=Device: 
adb shell getprop ro.product.device
echo|set /p=Hardware: 
adb shell getprop ro.hardware
echo|set /p=Id: 
adb shell getprop ro.build.id
echo|set /p=Release version: 
adb shell getprop ro.build.version.release
echo|set /p=Incremental version: 
adb shell getprop ro.build.version.incremental
echo|set /p=Build date: 
adb shell getprop ro.build.date.utc
echo|set /p=Type: 
adb shell getprop ro.build.type
echo|set /p=Tags: 
adb shell getprop ro.build.tags
echo|set /p=Fingerprint: 
adb shell getprop ro.build.fingerprint
echo|set /p=Bootloader: 
adb shell getprop ro.bootloader

echo.

echo ABI:
adb shell getprop ro.product.cpu.abi
adb shell getprop ro.product.cpu.abi2
adb shell getprop ro.product.cpu.abilist

echo.

echo Screen:
adb shell wm size
adb shell wm density

echo.

echo Firmware:
echo|set /p=SDK Version: 
adb shell getprop ro.build.version.sdk
powershell "adb shell dumpsys SurfaceFlinger | Select-String -Pattern 'OpenGL'"

echo: com.android.vending:
powershell "adb shell dumpsys package com.android.vending | Select-String -Pattern 'version'"
echo.

echo Libraries:
powershell "adb shell pm list libraries | foreach {$_.replace('library:','')}"

echo.

echo Features:
powershell "adb shell pm list features | foreach {$_.replace('feature:','')}"
