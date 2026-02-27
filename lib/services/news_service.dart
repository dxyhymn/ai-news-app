import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  // GNews API (免费套餐: 100 次/天)
  // 注册获取 key: https://gnews.io/
  static const String _apiKey = 'cea580e1dc3de091ea3f4f263e2573bb';
  static const String _baseUrl = 'https://gnews.io/api/v4';

  bool get _hasApiKey => _apiKey != 'YOUR_GNEWS_API_KEY' && _apiKey.isNotEmpty;

  static const Map<String, String> _categoryQueries = {
    'all': 'artificial intelligence OR AI',
    'llm': 'large language model OR GPT OR LLM OR ChatGPT OR Claude',
    'agent': 'AI agent OR autonomous agent',
    'vision': 'computer vision OR image recognition OR object detection',
    'robotics': 'robot OR robotics OR humanoid',
    'auto': 'autonomous driving OR self-driving OR autopilot',
    'chip': 'AI chip OR GPU OR NVIDIA OR AI processor',
    'research': 'AI research OR machine learning paper OR deep learning',
    'product': 'AI product launch OR AI app OR AI tool release',
    'investment': 'AI startup funding OR AI investment OR AI venture capital',
  };

  Future<List<NewsArticle>> fetchNews({
    String category = 'all',
    int page = 1,
    int pageSize = 20,
  }) async {
    if (!_hasApiKey) {
      return _getMockNews(category, page, pageSize);
    }

    try {
      final query = _categoryQueries[category] ?? _categoryQueries['all']!;
      final maxResults = pageSize > 10 ? 10 : pageSize;
      final url = Uri.parse(
        '$_baseUrl/search?q=${Uri.encodeComponent(query)}'
        '&lang=en&max=$maxResults&page=$page'
        '&apikey=$_apiKey',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articlesList = data['articles'] as List?;
        if (articlesList != null && articlesList.isNotEmpty) {
          return articlesList
              .asMap()
              .entries
              .map((entry) => _fromGNewsJson(entry.value, entry.key, category))
              .toList();
        }
      }

      return _getMockNews(category, page, pageSize);
    } catch (e) {
      print('API error, using mock data: $e');
      return _getMockNews(category, page, pageSize);
    }
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    if (!_hasApiKey) {
      return _searchMockNews(query);
    }

    try {
      final url = Uri.parse(
        '$_baseUrl/search?q=${Uri.encodeComponent('$query AI')}'
        '&lang=en&max=10&apikey=$_apiKey',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articlesList = data['articles'] as List?;
        if (articlesList != null && articlesList.isNotEmpty) {
          return articlesList
              .asMap()
              .entries
              .map((entry) => _fromGNewsJson(entry.value, entry.key, 'all'))
              .toList();
        }
      }

      return _searchMockNews(query);
    } catch (e) {
      print('Search API error: $e');
      return _searchMockNews(query);
    }
  }

  NewsArticle _fromGNewsJson(Map<String, dynamic> json, int index, String category) {
    return NewsArticle(
      id: 'gnews_${index}_${json['publishedAt'] ?? ''}',
      title: json['title'] ?? '',
      summary: json['description'] ?? '',
      content: json['content'] ?? json['description'] ?? '',
      source: json['source']?['name'] ?? '未知来源',
      author: json['source']?['name'] ?? '未知',
      imageUrl: json['image'] ?? '',
      url: json['url'] ?? '',
      category: category,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  // ============ 模拟数据（API 不可用时的后备） ============

  Future<List<NewsArticle>> _searchMockNews(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final allNews = _getMockNews('all', 1, 50);
    return allNews
        .where((a) =>
            a.title.toLowerCase().contains(query.toLowerCase()) ||
            a.summary.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<NewsArticle> _getMockNews(String category, int page, int pageSize) {
    final allNews = <NewsArticle>[
      NewsArticle(
        id: '1',
        title: 'OpenAI 发布 GPT-5：多模态推理能力实现重大突破',
        summary: 'OpenAI 今日正式发布 GPT-5 模型，该模型在复杂推理、代码生成和多模态理解方面展现出显著提升。',
        content: 'OpenAI 今日正式发布了备受期待的 GPT-5 大语言模型。这一代模型在多个关键领域实现了重大突破：\n\n推理能力大幅提升：GPT-5 在数学推理、逻辑推理和因果推理方面的表现比 GPT-4 提升了 40% 以上。\n\n原生多模态：模型原生支持文本、图像、音频和视频的理解与生成。\n\n超长上下文：支持高达 100 万 token 的上下文窗口。\n\nAgent 能力：内置工具调用和任务规划能力。',
        source: 'AI 科技评论',
        author: '张明',
        imageUrl: 'https://picsum.photos/seed/gpt5/800/400',
        url: 'https://example.com/gpt5',
        category: 'llm',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NewsArticle(
        id: '2',
        title: 'Google DeepMind 推出 Gemini 3.0，基准测试全面超越竞品',
        summary: 'Google DeepMind 发布新一代 Gemini 3.0 模型，在 MMLU、HumanEval 等多项基准测试中刷新记录。',
        content: 'Google DeepMind 今天发布了 Gemini 3.0，在多项权威基准测试中创下新纪录：\n\nMMLU: 92.1%\nHumanEval: 89.7%\nMATH: 78.3%\n\n核心技术突破包括混合专家（MoE）架构升级和全新的注意力机制。',
        source: 'TechCrunch 中文',
        author: '李华',
        imageUrl: 'https://picsum.photos/seed/gemini3/800/400',
        url: 'https://example.com/gemini3',
        category: 'llm',
        publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      NewsArticle(
        id: '3',
        title: '特斯拉 Optimus Gen-3 机器人开始在工厂执行复杂任务',
        summary: '特斯拉宣布其第三代人形机器人 Optimus Gen-3 已在弗里蒙特工厂投入试运行。',
        content: '特斯拉今日宣布，Optimus Gen-3 人形机器人已在其弗里蒙特工厂开始试运行。\n\n新一代 Optimus 灵巧手操作精度提升至 0.1mm，自主导航和避障能力大幅提升，能够理解语音指令并执行多步骤任务，电池续航达 12 小时。',
        source: '机器之心',
        author: '王强',
        imageUrl: 'https://picsum.photos/seed/optimus/800/400',
        url: 'https://example.com/optimus',
        category: 'robotics',
        publishedAt: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      NewsArticle(
        id: '4',
        title: 'NVIDIA 发布 Blackwell Ultra：AI 训练性能提升 3 倍',
        summary: 'NVIDIA 在 GTC 大会上发布新一代 Blackwell Ultra GPU，采用 3nm 工艺。',
        content: 'NVIDIA CEO 黄仁勋在 GTC 2026 大会上发布了 Blackwell Ultra GPU。\n\n核心规格：3nm 工艺制造，2080 亿晶体管，FP4 性能 20 PFLOPS，HBM4 显存 288GB。',
        source: '量子位',
        author: '赵晓',
        imageUrl: 'https://picsum.photos/seed/blackwell/800/400',
        url: 'https://example.com/blackwell',
        category: 'chip',
        publishedAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
      NewsArticle(
        id: '5',
        title: 'Waymo 自动驾驶出租车服务正式进入中国市场',
        summary: 'Alphabet 旗下 Waymo 宣布将在深圳和上海推出自动驾驶出租车服务。',
        content: 'Waymo 今日宣布正式进入中国市场。首批服务将在深圳南山区和上海浦东新区推出，首批投入 500 辆第六代 Waymo Driver 车辆，覆盖约 200 平方公里的服务区域。',
        source: '36氪',
        author: '陈宇',
        imageUrl: 'https://picsum.photos/seed/waymo/800/400',
        url: 'https://example.com/waymo',
        category: 'auto',
        publishedAt: DateTime.now().subtract(const Duration(hours: 16)),
      ),
      NewsArticle(
        id: '6',
        title: '新型 AI Agent 框架可自主完成软件开发全流程',
        summary: '斯坦福大学与 Anthropic 联合发布 DevAgent 框架，准确率达 78%。',
        content: 'DevAgent 能够自主完成需求文档分析和任务分解、技术方案设计、代码编写和单元测试、代码审查和优化、部署和监控。\n\n在 SWE-bench 基准测试中，DevAgent 的任务完成率达到 78%。',
        source: 'arXiv 精选',
        author: '刘博士',
        imageUrl: 'https://picsum.photos/seed/devagent/800/400',
        url: 'https://example.com/devagent',
        category: 'agent',
        publishedAt: DateTime.now().subtract(const Duration(hours: 20)),
      ),
      NewsArticle(
        id: '7',
        title: 'Meta 开源 Llama 4：参数量达 4000 亿，性能媲美闭源模型',
        summary: 'Meta 发布并开源 Llama 4 系列模型，采用 MoE 架构。',
        content: 'Llama 4 系列：Scout (170 亿参数)，Pro (700 亿参数)，Ultra (4000 亿参数)。Llama 4 Ultra 在 MMLU 上达到 89.2%，以 Apache 2.0 协议开源。',
        source: 'InfoQ',
        author: '周工',
        imageUrl: 'https://picsum.photos/seed/llama4/800/400',
        url: 'https://example.com/llama4',
        category: 'llm',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NewsArticle(
        id: '8',
        title: 'SAM 3 实现视频中任意物体的实时分割与追踪',
        summary: 'Meta AI 发布 SAM 3，可在 4K 视频中实时分割和追踪任意物体。',
        content: 'SAM 3 核心能力：4K 视频实时分割 60fps，零样本泛化，3D 感知，交互式编辑。该技术已被应用于视频编辑、AR/VR、自动驾驶等领域。',
        source: 'AI 前线',
        author: '孙明',
        imageUrl: 'https://picsum.photos/seed/sam3/800/400',
        url: 'https://example.com/sam3',
        category: 'vision',
        publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      ),
      NewsArticle(
        id: '9',
        title: 'AI 编程助手初创公司 CodeMind 融资 5 亿美元',
        summary: '红杉资本领投，估值达 50 亿美元，已有超过 100 万开发者使用。',
        content: 'CodeMind 完成 5 亿美元 B 轮融资，红杉资本领投，a16z、光速创投跟投，投后估值 50 亿美元。产品支持 50+ 编程语言。',
        source: '创投日报',
        author: '林越',
        imageUrl: 'https://picsum.photos/seed/codemind/800/400',
        url: 'https://example.com/codemind',
        category: 'investment',
        publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
      ),
      NewsArticle(
        id: '10',
        title: 'AI 首次独立发现全新抗生素化合物，登上 Nature 封面',
        summary: 'MIT 团队利用 AI 独立发现一种对多种超级细菌有效的全新抗生素化合物。',
        content: 'AI 系统在 1 亿个化合物中筛选出候选分子，新发现的化合物对 MRSA 等超级细菌有效，从发现到动物实验验证仅用 3 个月。',
        source: 'Nature 中文',
        author: '吴研',
        imageUrl: 'https://picsum.photos/seed/nature-ai/800/400',
        url: 'https://example.com/nature-ai',
        category: 'research',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NewsArticle(
        id: '11',
        title: 'Apple 发布 Apple Intelligence 2.0：Siri 全面重生',
        summary: 'Siri 获得大语言模型加持，可执行复杂的跨应用操作。',
        content: 'Siri 全面接入大语言模型，支持跨应用的复杂操作链，端侧模型与云端模型协同，隐私计算框架升级。',
        source: '少数派',
        author: '何言',
        imageUrl: 'https://picsum.photos/seed/apple-ai/800/400',
        url: 'https://example.com/apple-intelligence',
        category: 'product',
        publishedAt: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      ),
      NewsArticle(
        id: '12',
        title: '百度文心大模型 5.0 发布：中文理解能力创新高',
        summary: '中文 SuperCLUE 评分行业第一，向所有企业开发者免费开放。',
        content: '文心大模型 5.0 支持 200 万字超长上下文，多模态能力全面升级，新增代码生成和数学推理专项优化，企业级 API 免费开放。',
        source: '极客公园',
        author: '钱进',
        imageUrl: 'https://picsum.photos/seed/ernie5/800/400',
        url: 'https://example.com/ernie5',
        category: 'llm',
        publishedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    List<NewsArticle> filtered;
    if (category == 'all') {
      filtered = allNews;
    } else {
      filtered = allNews.where((a) => a.category == category).toList();
    }

    final start = (page - 1) * pageSize;
    if (start >= filtered.length) return [];
    final end = (start + pageSize) > filtered.length ? filtered.length : start + pageSize;
    return filtered.sublist(start, end);
  }
}
