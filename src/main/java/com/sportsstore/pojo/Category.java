package com.sportsstore.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 商品分类实体类
 */
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private String name;
    private Integer sortOrder;
    private Date createTime;

    public Category() {}

    public Category(String name) {
        this.name = name;
    }

    // ====== Getter & Setter ======
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    @Override
    public String toString() {
        return "Category{id=" + id + ", name='" + name + '\'' + '}';
    }
}
