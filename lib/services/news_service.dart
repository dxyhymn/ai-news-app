import '../models/news_article.dart';

class NewsService {
  /// 获取模拟的 AI 新闻数据
  /// 实际项目中替换为真实 API 调用
  Future<List<NewsArticle>> fetchNews({
    String category = 'all',
    int page = 1,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _generateMockNews(category, page, pageSize);
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final allNews = _generateMockNews('all', 1, 50);
    return allNews
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()) ||
            article.summary.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<NewsArticle> _generateMockNews(
      String category, int page, int pageSize) {
    final allNews = <NewsArticle>[
      NewsArticle(
        id: '1',
        title: 'OpenAI 发布 GPT-5：多模态推理能力实现重大突破',
        summary:
            'OpenAI 今日正式发布 GPT-5 模型，该模型在复杂推理、代码生成和多模态理解方面展现出显著提升。GPT-5 支持超长上下文窗口，并首次实现了真正的多步推理能力。',
        content: '''OpenAI 今日正式发布了备受期待的 GPT-5 大语言模型。这一代模型在多个关键领域实现了重大突破：

1. **推理能力大幅提升**：GPT-5 在数学推理、逻辑推理和因果推理方面的表现比 GPT-4 提升了 40% 以上。

2. **原生多模态**：模型原生支持文本、图像、音频和视频的理解与生成，不再需要独立的视觉模型。

3. **超长上下文**：支持高达 100 万 token 的上下文窗口，能够处理整本书籍或大型代码库。

4. **Agent 能力**：内置工具调用和任务规划能力，可以自主完成复杂的多步骤任务。

业内分析人士认为，GPT-5 的发布标志着大语言模型从"对话工具"向"通用智能助手"的重要转变。''',
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
        summary:
            'Google DeepMind 发布新一代 Gemini 3.0 模型，在 MMLU、HumanEval 等多项基准测试中刷新记录，并宣布向开发者开放 API。',
        content: '''Google DeepMind 今天发布了 Gemini 3.0，这是其最新一代多模态 AI 模型。

该模型在多项权威基准测试中创下新纪录：
- MMLU: 92.1%（此前最高 90.4%）
- HumanEval: 89.7%
- MATH: 78.3%

Gemini 3.0 的核心技术突破包括混合专家（MoE）架构升级和全新的注意力机制。''',
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
        summary:
            '特斯拉宣布其第三代人形机器人 Optimus Gen-3 已在弗里蒙特工厂投入试运行，能够自主完成零件分拣、质量检测等复杂任务。',
        content: '''特斯拉今日宣布，Optimus Gen-3 人形机器人已在其弗里蒙特工厂开始试运行。

新一代 Optimus 具有以下特点：
- 灵巧手操作精度提升至 0.1mm
- 自主导航和避障能力大幅提升
- 能够理解语音指令并执行多步骤任务
- 电池续航达 12 小时

马斯克表示，预计 2027 年将有超过 1000 台 Optimus 在特斯拉工厂工作。''',
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
        summary:
            'NVIDIA 在 GTC 大会上发布新一代 Blackwell Ultra GPU，采用 3nm 工艺，AI 训练性能较上一代提升 3 倍，推理效率提升 5 倍。',
        content: '''NVIDIA CEO 黄仁勋在 GTC 2026 大会上发布了 Blackwell Ultra GPU。

核心规格：
- 3nm 工艺制造
- 2080 亿晶体管
- FP4 性能: 20 PFLOPS
- HBM4 显存: 288GB
- 功耗: 1200W

黄仁勋称这是"迄今为止最大的性能飞跃"，并宣布微软、Google、Meta 已下单数百万片。''',
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
        summary:
            'Alphabet 旗下 Waymo 宣布与中国合作伙伴达成协议，将在深圳和上海推出自动驾驶出租车服务，首批投入 500 辆无人车。',
        content: '''Waymo 今日宣布正式进入中国市场，与国内合作伙伴共同推出自动驾驶出租车服务。

首批服务将在深圳南山区和上海浦东新区推出：
- 首批投入 500 辆第六代 Waymo Driver 车辆
- 覆盖约 200 平方公里的服务区域
- 24 小时全天候运营
- 通过微信小程序即可叫车

这是 Waymo 在美国以外的首个商业化落地市场。''',
        source: '36氪',
        author: '陈宇',
        imageUrl: 'https://picsum.photos/seed/waymo/800/400',
        url: 'https://example.com/waymo',
        category: 'auto',
        publishedAt: DateTime.now().subtract(const Duration(hours: 16)),
      ),
      NewsArticle(
        id: '6',
        title: '突破性研究：新型 AI Agent 框架可自主完成软件开发全流程',
        summary:
            '斯坦福大学与 Anthropic 联合发布 DevAgent 框架，AI Agent 可自主完成从需求分析到代码部署的完整软件开发流程，准确率达 78%。',
        content: '''斯坦福大学和 Anthropic 联合发布了名为 DevAgent 的 AI Agent 框架。

DevAgent 能够自主完成：
- 需求文档分析和任务分解
- 技术方案设计
- 代码编写和单元测试
- 代码审查和优化
- 部署和监控

在 SWE-bench 基准测试中，DevAgent 的任务完成率达到 78%，远超之前的最佳成绩 45%。''',
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
        summary:
            'Meta 发布并开源 Llama 4 系列模型，最大版本参数量达 4000 亿，采用 MoE 架构，在多项评测中达到 GPT-4 级别性能。',
        content: '''Meta 今日发布了 Llama 4 系列开源大模型。

模型阵容：
- Llama 4 Scout (170 亿参数)：适合端侧部署
- Llama 4 Pro (700 亿参数)：平衡性能和成本
- Llama 4 Ultra (4000 亿参数)：旗舰模型，MoE 架构

Llama 4 Ultra 在 MMLU 上达到 89.2%，接近闭源模型最佳水平。所有模型均以 Apache 2.0 协议开源。''',
        source: 'InfoQ',
        author: '周工',
        imageUrl: 'https://picsum.photos/seed/llama4/800/400',
        url: 'https://example.com/llama4',
        category: 'llm',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NewsArticle(
        id: '8',
        title: 'AI 视觉新突破：SAM 3 实现视频中任意物体的实时分割与追踪',
        summary:
            'Meta AI 发布 Segment Anything Model 3 (SAM 3)，可在 4K 视频中实时分割和追踪任意物体，速度达 60fps。',
        content: '''Meta AI 发布了 SAM 3（Segment Anything Model 3），在计算机视觉领域取得重要突破。

SAM 3 核心能力：
- 4K 视频实时分割：60fps
- 零样本泛化：无需微调即可处理任意物体
- 3D 感知：支持深度估计和 3D 重建
- 交互式编辑：通过自然语言指定分割目标

该技术已被应用于视频编辑、AR/VR、自动驾驶等领域。''',
        source: 'AI 前线',
        author: '孙明',
        imageUrl: 'https://picsum.photos/seed/sam3/800/400',
        url: 'https://example.com/sam3',
        category: 'vision',
        publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      ),
      NewsArticle(
        id: '9',
        title: '红杉资本领投：AI 编程助手初创公司融资 5 亿美元',
        summary:
            'AI 编程助手公司 CodeMind 完成 5 亿美元 B 轮融资，由红杉资本领投，估值达 50 亿美元。该公司旗下产品已被超过 100 万开发者使用。',
        content: '''AI 编程助手公司 CodeMind 今日宣布完成 5 亿美元 B 轮融资。

融资详情：
- 金额：5 亿美元
- 领投：红杉资本
- 跟投：a16z、光速创投
- 投后估值：50 亿美元

CodeMind 的核心产品是一款 AI 编程助手，支持 50+ 编程语言，已有超过 100 万活跃开发者。资金将用于扩大研发团队和拓展企业级市场。''',
        source: '创投日报',
        author: '林越',
        imageUrl: 'https://picsum.photos/seed/codemind/800/400',
        url: 'https://example.com/codemind',
        category: 'investment',
        publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
      ),
      NewsArticle(
        id: '10',
        title: 'Nature 封面：AI 首次独立发现全新抗生素化合物',
        summary:
            'MIT 研究团队利用 AI 系统独立发现了一种全新的抗生素化合物，对多种超级细菌有效。该研究发表在 Nature 杂志封面。',
        content: '''MIT 研究团队在 Nature 上发表封面论文，报告了 AI 在药物发现领域的重大突破。

关键发现：
- AI 系统在 1 亿个化合物中筛选出候选分子
- 新发现的化合物对 MRSA 等超级细菌有效
- 从发现到动物实验验证仅用 3 个月
- 传统方法通常需要 3-5 年

这是 AI 首次完全独立（而非辅助人类）发现具有临床潜力的新型抗生素。''',
        source: 'Nature 中文',
        author: '吴研',
        imageUrl: 'https://picsum.photos/seed/aidrugdiscovery/800/400',
        url: 'https://example.com/nature-ai-antibiotic',
        category: 'research',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NewsArticle(
        id: '11',
        title: 'Apple 发布 Apple Intelligence 2.0：Siri 全面重生',
        summary:
            'Apple 在 WWDC 上发布 Apple Intelligence 2.0，Siri 获得大语言模型加持，可执行复杂的跨应用操作，支持持续对话和上下文理解。',
        content: '''Apple 在 WWDC 2026 上发布了 Apple Intelligence 2.0。

核心更新：
- Siri 全面接入大语言模型
- 支持跨应用的复杂操作链
- 端侧模型与云端模型协同
- 隐私计算框架 Private Cloud Compute 升级
- 开发者可将自己的 AI 能力集成到 Siri

Apple Intelligence 2.0 将随 iOS 20 在今年秋季推送。''',
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
        summary:
            '百度发布文心大模型 5.0，在中文理解、中文创作和中国文化知识方面大幅领先，并宣布向所有企业开发者免费开放。',
        content: '''百度今日发布文心大模型 5.0。

主要亮点：
- 中文 SuperCLUE 评分行业第一
- 支持 200 万字超长上下文
- 多模态能力全面升级
- 新增代码生成和数学推理专项优化
- 企业级 API 免费开放

李彦宏表示，AI 原生应用时代已经到来，百度将全力推动大模型的普惠化。''',
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
      filtered =
          allNews.where((article) => article.category == category).toList();
    }

    final start = (page - 1) * pageSize;
    if (start >= filtered.length) return [];
    final end =
        (start + pageSize) > filtered.length ? filtered.length : start + pageSize;

    return filtered.sublist(start, end);
  }
}
