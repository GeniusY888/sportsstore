package com.sportsstore.controller.admin;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Review;
import com.sportsstore.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller("adminReviewController")
@RequestMapping("/admin/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping("/list")
    @ResponseBody
    public Result<List<Review>> list(@RequestParam(required = false) Integer productId) {
        List<Review> reviews;
        if (productId != null) {
            reviews = reviewService.findByProductId(productId);
        } else {
            reviews = reviewService.findAll();
        }
        return Result.success(reviews);
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<?> delete(@RequestParam Integer id) {
        return reviewService.adminDelete(id);
    }

    @GetMapping("/stats")
    @ResponseBody
    public Result<?> stats(@RequestParam(required = false) Integer productId) {
        if (productId != null) {
            int count = reviewService.countByProductId(productId);
            Double avgRating = reviewService.avgRatingByProductId(productId);
            return Result.success(new ReviewStats(count, avgRating != null ? avgRating : 0));
        }
        return Result.error(400, "请指定商品ID");
    }

    private static class ReviewStats {
        private int count;
        private double avgRating;

        public ReviewStats(int count, double avgRating) {
            this.count = count;
            this.avgRating = avgRating;
        }

        public int getCount() { return count; }
        public double getAvgRating() { return avgRating; }
    }
}