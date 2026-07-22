#!/bin/bash
# 周龙诀 Android App 一键构建脚本

set -e

echo "========================================"
echo "  周龙诀 Android App 构建脚本"
echo "========================================"
echo ""

# 检查Java
if ! command -v java &> /dev/null; then
    echo "❌ 错误: 未找到Java，请先安装JDK 17"
    echo "   下载地址: https://adoptium.net/"
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d '"' -f 2)
echo "✅ Java版本: $JAVA_VERSION"

# 检查Android SDK
if [ -z "$ANDROID_SDK_ROOT" ] && [ -z "$ANDROID_HOME" ]; then
    echo "⚠️ 警告: 未设置ANDROID_SDK_ROOT环境变量"
    echo "   请安装Android SDK并设置环境变量"
    echo "   下载地址: https://developer.android.com/studio"
fi

# 下载gradle wrapper (如果没有)
if [ ! -f "gradle/wrapper/gradle-wrapper.jar" ]; then
    echo "📥 下载Gradle Wrapper..."
    mkdir -p gradle/wrapper
    curl -L -o gradle/wrapper/gradle-wrapper.jar         https://raw.githubusercontent.com/gradle/gradle/v8.7.0/gradle/wrapper/gradle-wrapper.jar
fi

# 构建
echo ""
echo "🔨 开始构建APK..."
./gradlew assembleDebug

# 检查结果
APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
if [ -f "$APK_PATH" ]; then
    APK_SIZE=$(ls -lh $APK_PATH | awk '{print $5}')
    echo ""
    echo "========================================"
    echo "  ✅ 构建成功!"
    echo "========================================"
    echo "  APK路径: $APK_PATH"
    echo "  文件大小: $APK_SIZE"
    echo ""
    echo "  安装到手机:"
    echo "    adb install $APK_PATH"
    echo ""
else
    echo "❌ 构建失败，请检查错误信息"
    exit 1
fi
