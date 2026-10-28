package com.sportsstore.pojo;

import java.util.Date;
import java.util.List;

public class SpecGroup {
    private Integer id;
    private Integer categoryId;
    private String name;
    private Integer sortOrder;
    private Date createTime;
    private List<SpecValue> values;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public List<SpecValue> getValues() { return values; }
    public void setValues(List<SpecValue> values) { this.values = values; }
}