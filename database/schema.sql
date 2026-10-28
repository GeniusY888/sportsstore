-- ============================================================
-- SportsStore 体育用品商城 - 数据库初始化脚本
-- 环境：MySQL 8.0+，字符集 utf8mb4
-- 使用：mysql -u root -p < database/schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS `sportsstore` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sportsstore`;

-- ----------------------------
-- 1. 用户表
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id`          INT          NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username`    VARCHAR(50)  NOT NULL COMMENT '用户名',
  `password`    VARCHAR(64)  NOT NULL COMMENT '密码（MD5加盐）',
  `phone`       VARCHAR(20)  DEFAULT NULL COMMENT '手机号',
  `email`       VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
  `avatar`      VARCHAR(255) DEFAULT NULL COMMENT '头像路径',
  `status`      TINYINT      NOT NULL DEFAULT 1 COMMENT '状态：1启用 0禁用',
  `create_time` DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- 2. 收货地址表
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id`            INT          NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id`       INT          NOT NULL COMMENT '所属用户ID',
  `receiver_name` VARCHAR(50)  NOT NULL COMMENT '收货人姓名',
  `phone`         VARCHAR(20)  NOT NULL COMMENT '联系电话',
  `province`      VARCHAR(50)  DEFAULT NULL COMMENT '省',
  `city`          VARCHAR(50)  DEFAULT NULL COMMENT '市',
  `district`      VARCHAR(50)  DEFAULT NULL COMMENT '区/县',
  `detail`        VARCHAR(255) NOT NULL COMMENT '详细地址',
  `is_default`    TINYINT      NOT NULL DEFAULT 0 COMMENT '是否默认：1是 0否',
  `create_time`   DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收货地址表';

-- ----------------------------
-- 3. 商品分类表
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id`          INT         NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name`        VARCHAR(50) NOT NULL COMMENT '分类名称',
  `sort_order`  INT         NOT NULL DEFAULT 0 COMMENT '排序（越小越靠前）',
  `create_time` DATETIME    DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- ----------------------------
-- 4. 规格组表
-- ----------------------------
DROP TABLE IF EXISTS `spec_group`;
CREATE TABLE `spec_group` (
  `id`          INT         NOT NULL AUTO_INCREMENT COMMENT '规格组ID',
  `category_id` INT         NOT NULL COMMENT '所属分类ID',
  `name`        VARCHAR(50) NOT NULL COMMENT '规格名称（如：尺码）',
  `sort_order`  INT         NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` DATETIME    DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规格组表';

-- ----------------------------
-- 5. 规格值表
-- ----------------------------
DROP TABLE IF EXISTS `spec_value`;
CREATE TABLE `spec_value` (
  `id`          INT          NOT NULL AUTO_INCREMENT COMMENT '规格值ID',
  `group_id`    INT          NOT NULL COMMENT '所属规格组ID',
  `value`       VARCHAR(100) NOT NULL COMMENT '规格值（如：XL）',
  `sort_order`  INT          NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规格值表';

-- ----------------------------
-- 6. 商品表
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id`           INT            NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name`         VARCHAR(100)   NOT NULL COMMENT '商品名称',
  `description`  TEXT           COMMENT '商品描述',
  `price`        DECIMAL(10,2)  NOT NULL COMMENT '售价',
  `stock`        INT            NOT NULL DEFAULT 0 COMMENT '库存',
  `image`        VARCHAR(255)   DEFAULT NULL COMMENT '主图（相对路径）',
  `images`       VARCHAR(1000)  DEFAULT NULL COMMENT '详情图（逗号分隔）',
  `category_id`  INT            NOT NULL COMMENT '所属分类ID',
  `status`       TINYINT        NOT NULL DEFAULT 1 COMMENT '状态：1上架 0下架',
  `sales_volume` INT            NOT NULL DEFAULT 0 COMMENT '销量',
  `is_hot`       TINYINT        NOT NULL DEFAULT 0 COMMENT '是否热门：1是',
  `is_new`       TINYINT        NOT NULL DEFAULT 0 COMMENT '是否新品：1是',
  `create_time`  DATETIME       DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time`  DATETIME       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status_create` (`status`, `create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- ----------------------------
-- 7. 购物车表
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id`          INT          NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id`     INT          NOT NULL COMMENT '用户ID',
  `product_id`  INT          NOT NULL COMMENT '商品ID',
  `spec`        VARCHAR(100) DEFAULT NULL COMMENT '规格信息',
  `quantity`    INT          NOT NULL DEFAULT 1 COMMENT '数量',
  `create_time` DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- ----------------------------
-- 8. 订单表（order 为 MySQL 关键字，需反引号）
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id`              INT           NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no`        VARCHAR(32)   NOT NULL COMMENT '订单编号（唯一）',
  `user_id`         INT           NOT NULL COMMENT '下单用户ID',
  `total_amount`    DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
  `status`          TINYINT       NOT NULL DEFAULT 0 COMMENT '状态：0未付款 1已付款 2已发货 3已完成 4已取消',
  `receiver_name`   VARCHAR(50)   NOT NULL COMMENT '收货人',
  `receiver_phone`  VARCHAR(20)   NOT NULL COMMENT '收货电话',
  `receiver_address` VARCHAR(255) NOT NULL COMMENT '收货地址',
  `remark`          VARCHAR(255)  DEFAULT NULL COMMENT '订单备注',
  `pay_time`        DATETIME      DEFAULT NULL COMMENT '支付时间',
  `ship_time`       DATETIME      DEFAULT NULL COMMENT '发货时间',
  `complete_time`   DATETIME      DEFAULT NULL COMMENT '完成时间',
  `cancel_time`     DATETIME      DEFAULT NULL COMMENT '取消时间',
  `create_time`     DATETIME      DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- ----------------------------
-- 9. 订单明细表
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `id`            INT           NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id`      INT           NOT NULL COMMENT '所属订单ID',
  `product_id`    INT           NOT NULL COMMENT '商品ID',
  `product_name`  VARCHAR(100)  NOT NULL COMMENT '商品名称快照',
  `product_image` VARCHAR(255)  DEFAULT NULL COMMENT '商品图片快照',
  `product_price` DECIMAL(10,2) NOT NULL COMMENT '成交单价快照',
  `spec`          VARCHAR(100)  DEFAULT NULL COMMENT '规格快照',
  `quantity`      INT           NOT NULL DEFAULT 1 COMMENT '购买数量',
  `subtotal`      DECIMAL(10,2) NOT NULL COMMENT '小计金额',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';

-- ----------------------------
-- 10. 商品评价表
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id`          INT           NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `user_id`     INT           NOT NULL COMMENT '评价用户ID',
  `product_id`  INT           NOT NULL COMMENT '商品ID',
  `rating`      INT           DEFAULT NULL COMMENT '评分（1-5）',
  `content`     VARCHAR(500)  DEFAULT NULL COMMENT '评价内容',
  `create_time` DATETIME      DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评价表';

-- ----------------------------
-- 11. 轮播图表
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel` (
  `id`          INT          NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `image_url`   VARCHAR(255) NOT NULL COMMENT '图片路径',
  `link_url`    VARCHAR(255) DEFAULT NULL COMMENT '跳转链接',
  `title`       VARCHAR(100) DEFAULT NULL COMMENT '标题',
  `sort_order`  INT          NOT NULL DEFAULT 0 COMMENT '排序',
  `status`      TINYINT      NOT NULL DEFAULT 1 COMMENT '状态：1启用 0停用',
  `create_time` DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='轮播图表';

-- ============================================================
-- 测试数据
-- ============================================================

-- 用户（密码均为 MD5 加盐，盐值 sportsstore_2024）
-- admin    明文 admin123
-- testuser 明文 123456
INSERT INTO `user` (`username`, `password`, `phone`, `email`, `status`) VALUES
('admin',    'fddc7ca91bed6271d1659e0aa38e2f93', '13800000000', 'admin@sportsstore.com',    1),
('testuser', '26af0daeb2cbe0804b7337022edd7a1c', '13900000000', 'testuser@sportsstore.com', 1);

-- 商品分类
INSERT INTO `category` (`name`, `sort_order`) VALUES
('篮球运动', 1),
('足球运动', 2),
('健身训练', 3),
('球拍运动', 4),
('户外装备', 5);

-- 商品（图片引用 static/upload/product 下的示例图片）
INSERT INTO `product` (`name`, `description`, `price`, `stock`, `image`, `category_id`, `status`, `sales_volume`, `is_hot`, `is_new`) VALUES
('专业比赛篮球', '室内外通用7号PU篮球，手感细腻，耐磨损', 129.00, 50, 'static/upload/product/03b09455b80b46f48111adaa547fd7f0.jpg', 1, 1, 36, 1, 0),
('比赛级足球', '5号机缝足球，适合训练与业余比赛', 99.00, 40, 'static/upload/product/07d23c02a9324b9495efc59597b10078.jpg', 2, 1, 22, 1, 0),
('可调节哑铃套装', '10kg 可拆卸哑铃一对，居家健身必备', 199.00, 30, 'static/upload/product/091ef20654484cc89727dc3bd5eaeaa4.jpg', 3, 1, 45, 1, 1),
('运动护膝', '透气针织护膝，运动防护缓震', 39.00, 100, 'static/upload/product/1357cffb1b61419cb4b1e6ec4bb44b96.jpg', 3, 1, 88, 0, 0),
('防雾游泳镜', '高清防雾硅胶泳镜，男女通用', 49.00, 80, 'static/upload/product/16908af500d24c6fb4f3f83517b2c9a1.jpg', 4, 1, 51, 0, 1),
('加厚瑜伽垫', 'NBR 环保材质 10mm 加厚防滑瑜伽垫', 79.00, 60, 'static/upload/product/195d10562401446eba30f186856db22c.jpg', 3, 1, 67, 1, 1),
('全碳素羽毛球拍', '轻量碳纤维拍框，攻防兼备', 159.00, 35, 'static/upload/product/216b7c3255af4377b31791a010da94ac.jpg', 4, 1, 18, 0, 1),
('户外双肩背包', '40L 大容量防水背包，登山徒步适用', 139.00, 45, 'static/upload/product/30e9b26135bc42dabd921e32534713ee.jpg', 5, 1, 29, 0, 0),
('速干运动服套装', '吸湿排汗速干面料，训练跑步两用', 119.00, 55, 'static/upload/product/34d4413dd76647d6bfea1df87f85c803.jpg', 5, 1, 33, 0, 1),
('训练足球袜', '加厚毛巾底专业足球袜', 25.00, 120, 'static/upload/product/39405704ee1b49b2b44040928a5f346d.jpg', 2, 1, 74, 0, 0);

-- 轮播图（图片在 static/images/carousel 目录）
INSERT INTO `carousel` (`image_url`, `link_url`, `title`, `sort_order`, `status`) VALUES
('static/images/carousel/轮播.jpg',  NULL, '新品上市', 1, 1),
('static/images/carousel/轮播1.jpg', NULL, '热卖推荐', 2, 1),
('static/images/carousel/轮播2.jpg', NULL, '运动装备节', 3, 1);

-- 商品评价示例
INSERT INTO `review` (`user_id`, `product_id`, `rating`, `content`) VALUES
(2, 1, 5, '球手感很好，弹性适中，推荐！'),
(2, 3, 4, '哑铃做工不错，就是稍重了点。');
