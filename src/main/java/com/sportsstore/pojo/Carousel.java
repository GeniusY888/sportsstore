package com.sportsstore.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 轮播图实体类
 */
public class Carousel implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private String imageUrl;
    private String linkUrl;
    private String title;
    private Integer sortOrder;
    private Integer status;         // 1=启用, 0=禁用
    private Date createTime;

    public Carousel() {}

    // ====== Getter & Setter ======
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getLinkUrl() { return linkUrl; }
    public void setLinkUrl(String linkUrl) { this.linkUrl = linkUrl; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
