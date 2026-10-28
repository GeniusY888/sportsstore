# SportsStore 体育用品商城

基于 **SSM 框架**（Spring + SpringMVC + MyBatis）开发的体育用品线上商城系统。个人独立完成的全栈项目：从需求分析、数据库设计（11 张业务表）、前后台功能开发到部署运行完整落地。

## 项目结构

```
sportsstore/
├── pom.xml                              # Maven 项目配置文件
├── README.md                            # 项目说明文档
├── 需求规格说明书.md                     # 需求规格说明
├── database/
│   └── schema.sql                       # 数据库初始化脚本（建表 + 测试数据）
├── picture/                             # 轮播图原始素材
│   ├── 轮播.jpg
│   ├── 轮播1.jpg
│   └── 轮播2.jpg
├── 示例图片/                             # 商品示例图片
└── src/
    ├── main/
    │   ├── java/com/sportsstore/
    │   │   ├── controller/
    │   │   │   ├── admin/               # 后台控制器
    │   │   │   │   ├── AdminLoginController.java
    │   │   │   │   ├── CategoryController.java
    │   │   │   │   ├── ProductController.java
    │   │   │   │   ├── UserController.java
    │   │   │   │   └── OrderController.java
    │   │   │   └── fore/                # 前台控制器
    │   │   │       ├── HomeController.java
    │   │   │       ├── UserController.java
    │   │   │       ├── ProductController.java
    │   │   │       ├── CartController.java
    │   │   │       └── OrderController.java
    │   │   ├── service/                 # 服务接口层
    │   │   │   ├── UserService.java
    │   │   │   ├── CategoryService.java
    │   │   │   ├── ProductService.java
    │   │   │   ├── CartService.java
    │   │   │   ├── OrderService.java
    │   │   │   ├── CarouselService.java
    │   │   │   └── impl/                # 服务实现
    │   │   │       ├── UserServiceImpl.java
    │   │   │       ├── CategoryServiceImpl.java
    │   │   │       ├── ProductServiceImpl.java
    │   │   │       ├── CartServiceImpl.java
    │   │   │       ├── OrderServiceImpl.java
    │   │   │       └── CarouselServiceImpl.java
    │   │   ├── mapper/                  # MyBatis Mapper 接口
    │   │   │   ├── UserMapper.java
    │   │   │   ├── AddressMapper.java
    │   │   │   ├── CategoryMapper.java
    │   │   │   ├── ProductMapper.java
    │   │   │   ├── CartMapper.java
    │   │   │   ├── OrderMapper.java
    │   │   │   └── CarouselMapper.java
    │   │   ├── pojo/                    # 实体类
    │   │   │   ├── User.java
    │   │   │   ├── Address.java
    │   │   │   ├── Category.java
    │   │   │   ├── Product.java
    │   │   │   ├── Cart.java
    │   │   │   ├── Order.java
    │   │   │   ├── OrderItem.java
    │   │   │   └── Carousel.java
    │   │   ├── dto/                     # 数据传输对象
    │   │   │   └── Result.java          # 统一响应结果
    │   │   ├── interceptor/             # 拦截器
    │   │   │   ├── UserLoginInterceptor.java
    │   │   │   └── AdminLoginInterceptor.java
    │   │   ├── filter/                  # (预留)过滤器目录
    │   │   ├── util/                    # 工具类
    │   │   │   ├── MD5Util.java
    │   │   │   └── FileUploadUtil.java
    │   │   └── exception/
    │   │       └── GlobalExceptionHandler.java
    │   ├── resources/
    │   │   ├── spring/
    │   │   │   ├── spring-dao.xml       # Spring-MyBatis 整合配置
    │   │   │   ├── spring-service.xml   # Spring 事务和服务配置
    │   │   │   └── spring-mvc.xml       # SpringMVC 配置
    │   │   ├── mapper/                  # MyBatis XML 映射文件
    │   │   │   ├── UserMapper.xml
    │   │   │   ├── AddressMapper.xml
    │   │   │   ├── CategoryMapper.xml
    │   │   │   ├── ProductMapper.xml
    │   │   │   ├── CartMapper.xml
    │   │   │   ├── OrderMapper.xml
    │   │   │   ├── CarouselMapper.xml
    │   │   │   ├── ReviewMapper.xml
    │   │   │   ├── SpecGroupMapper.xml
    │   │   │   └── SpecValueMapper.xml
    │   │   ├── jdbc.properties
    │   │   ├── log4j.properties
    │   │   └── mybatis-config.xml
    │   └── webapp/
    │       ├── index.jsp                # 入口页（跳转到首页）
    │       ├── WEB-INF/
    │       │   ├── web.xml
    │       │   └── jsp/
    │       │       ├── fore/            # 前台页面
    │       │       │   ├── header.jsp
    │       │       │   ├── footer.jsp
    │       │       │   ├── home.jsp
    │       │       │   ├── login.jsp
    │       │       │   ├── register.jsp
    │       │       │   ├── userCenter.jsp
    │       │       │   ├── productList.jsp
    │       │       │   ├── productDetail.jsp
    │       │       │   ├── cart.jsp
    │       │       │   ├── checkout.jsp
    │       │       │   ├── orderList.jsp
    │       │       │   └── orderDetail.jsp
    │       │       ├── admin/           # 后台页面
    │       │       │   ├── header.jsp
    │       │       │   ├── footer.jsp
    │       │       │   ├── login.jsp
    │       │       │   ├── dashboard.jsp
    │       │       │   ├── categoryList.jsp
    │       │       │   ├── productList.jsp
    │       │       │   ├── productAdd.jsp
    │       │       │   ├── productEdit.jsp
    │       │       │   ├── userList.jsp
    │       │       │   ├── orderList.jsp
    │       │       │   └── orderDetail.jsp
    │       │       └── error/
    │       │           ├── 404.jsp
    │       │           └── 500.jsp
    │       └── static/
    │           ├── css/
    │           │   └── style.css
    │           ├── js/
    │           ├── images/
    │           │   └── carousel/        # 轮播图文件
    │           │       ├── 轮播.jpg
    │           │       ├── 轮播1.jpg
    │           │       └── 轮播2.jpg
    │           └── upload/              # 上传文件目录
    │               └── product/
    └── test/java/com/sportsstore/       # 测试代码目录
```

## 技术栈

| 层级 | 技术 |
|------|------|
| 核心框架 | Spring 5.3 + SpringMVC + MyBatis 3.5 |
| 数据库 | MySQL 8.0 |
| 连接池 | Druid 1.2 |
| 分页插件 | PageHelper 5.3 |
| 前端框架 | Bootstrap 3 + jQuery |
| 模板引擎 | JSP + JSTL |
| 构建工具 | Maven 3.x |
| 服务器 | Tomcat 9.0 |
| JDK | 1.8+ |

## 功能模块

### 前台用户端
- **用户模块**：注册、登录（MD5加密）、个人中心、密码修改
- **首页**：轮播图展示、热门推荐、新品上市
- **商品浏览**：分类筛选、模糊搜索、分页展示、详情查看
- **购物车**：添加/删除/修改数量、实时计算总价
- **订单系统**：下单（事务扣库存）、支付、取消（还库存）、确认收货

### 后台管理端
- **管理员登录**：独立入口，拦截器权限控制
- **分类管理**：CRUD、删除校验（有商品禁止删除）
- **商品管理**：CRUD、图片上传、上架/下架
- **用户管理**：用户列表、启用/禁用
- **订单管理**：全站订单查询、发货、完成

### 系统底层
- 全局 UTF-8 编码过滤器
- 前台/后台双拦截器权限控制
- PageHelper 分页全覆盖
- Spring 声明式事务
- MD5 加盐密码加密
- 文件上传（商品图片）

## 数据库表

| 表名 | 说明 |
|------|------|
| `user` | 用户表 |
| `address` | 收货地址表 |
| `category` | 商品分类表 |
| `product` | 商品表 |
| `cart` | 购物车表 |
| `order` | 订单表 |
| `order_item` | 订单明细表 |
| `carousel` | 轮播图表 |
| `review` | 商品评价表 |
| `spec_group` | 规格组表 |
| `spec_value` | 规格值表 |

## 快速启动

### 1. 环境准备
- JDK 1.8+
- Maven 3.x
- MySQL 8.0+
- Tomcat 9.0
- IntelliJ IDEA (推荐)

### 2. 初始化数据库

```bash
mysql -u root -p < database/schema.sql
```

或使用 Navicat 等工具执行 `database/schema.sql`。

### 3. 修改数据库连接

编辑 `src/main/resources/jdbc.properties`：

```properties
jdbc.url=jdbc:mysql://localhost:3306/sportsstore?useUnicode=true&characterEncoding=utf8mb4&serverTimezone=Asia/Shanghai
jdbc.username=root
jdbc.password=你的MySQL密码
```

### 4. 导入 IDEA
1. File → Open → 选择项目根目录
2. 等待 Maven 依赖下载完成
3. 配置 Tomcat：Run → Edit Configurations → Tomcat Server → Local
4. Deployment 添加 `sportsstore:war exploded`
5. Application context 设为 `/sportsstore`

### 5. 启动运行
- 启动 Tomcat
- 前台首页: `http://localhost:8080/sportsstore`
- 后台管理: `http://localhost:8080/sportsstore/admin/login`

### 默认账号
| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | admin123 |
| 测试用户 | testuser | 123456 |

## 系统架构

```
┌──────────────────────────────────────────────────────┐
│                    浏览器 (Browser)                    │
├────────────────────┬─────────────────────────────────┤
│   前台 (Fore)       │       后台 (Admin)               │
│   /fore/**          │       /admin/**                  │
├────────────────────┴─────────────────────────────────┤
│              SpringMVC (DispatcherServlet)            │
│         ├── Interceptor (登录拦截)                     │
│         └── Controller 层                             │
├──────────────────────────────────────────────────────┤
│                  Service 层 (业务逻辑)                  │
│         └── Spring 声明式事务                           │
├──────────────────────────────────────────────────────┤
│                  Mapper 层 (数据访问)                   │
│         └── MyBatis + PageHelper                     │
├──────────────────────────────────────────────────────┤
│                  MySQL 数据库                          │
└──────────────────────────────────────────────────────┘
```

## 订单状态流转

```
未付款 (0) ──支付──▶ 已付款 (1) ──发货──▶ 已发货 (2) ──确认收货──▶ 已完成 (3)
    │                                                         
    └──取消──▶ 已取消 (4) [返还库存]
```

## 课程设计考核点覆盖

- [x] SSM 三层架构 + MVC 模式
- [x] Maven 项目构建管理
- [x] MyBatis 数据持久化与关联映射
- [x] Spring 声明式事务（下单扣库存一致性）
- [x] SpringMVC 拦截器（前台/后台权限控制）
- [x] 全局编码过滤器
- [x] PageHelper 分页全覆盖
- [x] 文件上传（商品图片）
- [x] MD5 加盐密码加密
- [x] 完整订单状态流转
- [x] 统一异常处理
- [x] Bootstrap 响应式 UI
