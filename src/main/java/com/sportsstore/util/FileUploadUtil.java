package com.sportsstore.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * 文件上传工具类
 */
public class FileUploadUtil {

    /**
     * 上传文件到指定目录
     * @param file     上传的文件
     * @param basePath 基础路径 (如 webapp/static/upload/)
     * @param subDir   子目录 (如 product/, avatar/)
     * @return 相对路径 (如 static/upload/product/xxx.jpg), 失败返回 null
     */
    public static String upload(MultipartFile file, String basePath, String subDir) {
        if (file == null || file.isEmpty()) {
            return null;
        }

        // 生成唯一文件名
        String originalFilename = file.getOriginalFilename();
        String suffix = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String fileName = UUID.randomUUID().toString().replaceAll("-", "") + suffix;

        // 构建目标路径
        String uploadDir = basePath + File.separator + subDir;
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 写入目标目录
        File dest = new File(dir, fileName);
        try {
            file.transferTo(dest);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        // 同时复制到源码目录 (防止Rebuild后图片丢失)
        String srcPath = uploadDir.replace("target" + File.separator + "sportsstore",
                                           "src" + File.separator + "main" + File.separator + "webapp");
        if (!srcPath.equals(uploadDir)) {
            File srcDir = new File(srcPath);
            if (!srcDir.exists()) srcDir.mkdirs();
            try {
                java.nio.file.Files.copy(dest.toPath(), new File(srcDir, fileName).toPath());
            } catch (IOException ignored) {}
        }

        // 返回相对路径
        return "static/upload/" + subDir + "/" + fileName;
    }

    /**
     * 删除文件
     */
    public static boolean delete(String filePath) {
        if (filePath == null || filePath.isEmpty()) return false;
        File file = new File(filePath);
        return file.exists() && file.delete();
    }
}
