# App Store 截图指南

## 截图要求

App Store 至少需要以下尺寸的截图：
- **6.7 英寸** (iPhone 15 Pro Max / 16 Pro Max / 17 Pro Max): 1290 x 2796 px
- **6.5 英寸** (iPhone 11 Pro Max / XS Max): 1242 x 2688 px（可选）
- **5.5 英寸** (iPhone 8 Plus): 1242 x 2208 px（可选）

## 建议截取的页面

1. `home_screen.png` - 首页新闻列表（已截取）
2. `category_screen.png` - 切换到某个分类后的列表
3. `detail_screen.png` - 新闻详情页
4. `search_screen.png` - 搜索页面
5. `bookmarks_screen.png` - 收藏页面
6. `dark_mode.png` - 深色模式首页

## 截取命令

```bash
# 在模拟器上操作到对应页面后运行：
xcrun simctl io booted screenshot screenshots/截图名.png
```
