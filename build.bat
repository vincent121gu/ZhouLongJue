@echo off
chcp 65001 >nul
echo ========================================
echo   周龙诀 Android App 构建脚本
echo ========================================
echo.

REM 检查Java
java -version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: 未找到Java，请先安装JDK 17
    echo    下载地址: https://adoptium.net/
    pause
    exit /b 1
)

REM 下载gradle wrapper
if not exist "gradle\wrapper\gradle-wrapper.jar" (
    echo 📥 下载Gradle Wrapper...
    if not exist "gradle\wrapper" mkdir "gradle\wrapper"
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/gradle/gradle/v8.7.0/gradle/wrapper/gradle-wrapper.jar' -OutFile 'gradle/wrapper/gradle-wrapper.jar'"
)

echo.
echo 🔨 开始构建APK...
gradlew.bat assembleDebug

if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo   ✅ 构建成功!
    echo ========================================
    echo   APK路径: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo   安装到手机:
    echo     adb install app\build\outputs\apk\debug\app-debug.apk
    echo.
) else (
    echo ❌ 构建失败，请检查错误信息
)

pause
