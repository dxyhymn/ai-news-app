# AI 新闻 App

一款使用 Flutter 构建的 AI 领域新闻聚合应用，实时追踪人工智能最新动态。

## 功能特性

- 📰 AI 新闻浏览（大模型、机器人、自动驾驶、AI芯片等）
- 🔍 关键词搜索
- 🏷️ 分类筛选（10 个 AI 细分领域）
- 🔖 新闻收藏
- 🌙 深色/浅色主题切换
- 📱 精美的卡片式 UI

## 环境要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Xcode（iOS 构建）
- Android Studio（Android 构建）

## 快速开始

```bash
# 1. 安装 Flutter（macOS）
brew install --cask flutter

# 2. 检查环境
flutter doctor

# 3. 安装依赖
cd ai_news_app
flutter pub get

# 4. 运行（iOS 模拟器）
flutter run -d iphone

# 5. 运行（Android 模拟器）
flutter run -d android

# 6. 运行（Chrome）
flutter run -d chrome
```

## 项目结构

```
lib/
├── main.dart              # 应用入口
├── models/
│   └── news_article.dart  # 数据模型
├── services/
│   └── news_service.dart  # 数据服务（可替换为真实 API）
├── providers/
│   └── news_provider.dart # 状态管理
├── screens/
│   ├── home_screen.dart       # 首页
│   ├── news_detail_screen.dart # 新闻详情
│   ├── search_screen.dart     # 搜索页
│   └── bookmarks_screen.dart  # 收藏页
├── widgets/
│   ├── news_card.dart     # 新闻卡片组件
│   └── category_tabs.dart # 分类标签组件
└── theme/
    └── app_theme.dart     # 主题配置
```

## 接入真实 API

当前使用模拟数据，如需接入真实新闻 API，修改 `lib/services/news_service.dart` 即可。
推荐 API：

- [NewsAPI](https://newsapi.org/)
- [GNews](https://gnews.io/)
- 自建后端 API
