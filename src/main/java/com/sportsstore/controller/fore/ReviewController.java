package com.sportsstore.controller.fore;

import com.sportsstore.dto.Result;
import com.sportsstore.pojo.Review;
import com.sportsstore.pojo.User;
import com.sportsstore.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller("foreReviewController")
@RequestMapping("/fore/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping("/add")
    @ResponseBody
    public Result<?> add(@RequestParam Integer productId,
                         @RequestParam Integer rating,
                         @RequestParam String content,
                         HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return Result.error(401, "请先登录");
        }
        return reviewService.addReview(user.getId(), productId, rating, content);
    }

    @GetMapping("/list")
    @ResponseBody
    public Result<List<Review>> list(@RequestParam Integer productId) {
        List<Review> reviews = reviewService.findByProductId(productId);
        return Result.success(reviews);
    }

    @GetMapping("/stats")
    @ResponseBody
    public Result<?> stats(@RequestParam Integer productId) {
        int count = reviewService.countByProductId(productId);
        Double avgRating = reviewService.avgRatingByProductId(productId);
        return Result.success(new ReviewStats(count, avgRating != null ? avgRating : 0));
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<?> delete(@RequestParam Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return Result.error(401, "请先登录");
        }
        return reviewService.delete(id, user.getId());
    }

    @GetMapping("/canReview")
    @ResponseBody
    public Result<Boolean> canReview(@RequestParam Integer productId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return Result.success(false);
        }
        boolean can = reviewService.canReview(user.getId(), productId);
        return Result.success(can);
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