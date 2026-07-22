# 周龙诀 Android App (WebView封装版)

## 简介
这是"周龙诀"周线龙头选股策略系统的Android手机App版本。采用WebView封装方案，将现有的HTML前端直接打包成原生App，无需重写任何业务逻辑。

## 特点
- ✅ **零代码改动**：直接使用现有的HTML前端代码
- ✅ **离线可用**：内置演示数据，无网络也能运行
- ✅ **实时数据**：有网络时自动连接腾讯财经获取真实行情
- ✅ **原生体验**：全屏沉浸、下拉刷新、返回键支持
- ✅ **文件导出**：支持导出CSV到手机存储

## 技术方案
```
Android WebView + 本地HTML/CSS/JS
         ↓
    腾讯财经API (qt.gtimg.cn)
         ↓
    真实行情数据
```

## 构建步骤

### 方法1：使用Android Studio (推荐)
1. 打开 Android Studio
2. 选择 "Open an existing Android Studio project"
3. 选择本文件夹 (`ZhouLongJue_WebView`)
4. 等待Gradle同步完成
5. 点击菜单 Build → Build Bundle(s) / APK(s) → Build APK(s)
6. APK生成路径：`app/build/outputs/apk/debug/app-debug.apk`

### 方法2：命令行构建
```bash
# 确保已安装Android SDK和Gradle
./gradlew assembleDebug

# 安装到手机
adb install app/build/outputs/apk/debug/app-debug.apk
```

### 方法3：使用GitHub Actions自动构建
项目已配置GitHub Actions工作流，推送到GitHub后会自动构建APK。

## 项目结构
```
ZhouLongJue_WebView/
├── app/
│   ├── src/main/
│   │   ├── assets/
│   │   │   └── zhoulongjue.html      # 核心前端代码
│   │   ├── java/com/zhoulongjue/
│   │   │   └── MainActivity.kt        # WebView封装
│   │   └── AndroidManifest.xml
│   └── build.gradle.kts
├── build.gradle.kts
├── settings.gradle.kts
└── gradle.properties
```

## 数据源说明
| 数据源 | 状态 | 说明 |
|--------|------|------|
| 腾讯财经 | ✅ 推荐 | `qt.gtimg.cn` 无需Header，最稳定 |
| 新浪财经 | ⚠️ 备用 | `hq.sinajs.cn` 需Referer |
| 演示数据 | 📴 离线 | 无网络时自动切换 |

## 策略核心规则
1. 大盘20周线上方才操作
2. 只狙击板块绝对龙头（30只核心池）
3. 热点等级筛选仓位控制
4. -3%硬止损，最高价回落5%动态止盈
5. 最长持仓8天，连续止损触发交易暂停

## 买点信号
- **买点A** (周线突破): 30%仓位
- **买点B** (回踩低吸): 25%仓位
- **买点C** (粘合启动): 20%仓位

## 更新前端代码
如果HTML前端有更新，只需替换 `app/src/main/assets/zhoulongjue.html` 文件，重新构建即可。

## 最低系统要求
- Android 5.0 (API 21) 及以上
- 建议 Android 8.0+ 获得最佳体验

## 许可证
仅供个人学习研究使用
