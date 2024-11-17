package com.example.util;

import org.springframework.stereotype.Component;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
@Component
//随机验证码图片生成
public class CaptchaGeneratorUtil {

    public static String generateCaptchaImage(OutputStream outputStream) throws IOException {
        int width = 120;
        int height = 40;

        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        Random random = new Random();

        // 设置背景颜色
        g.setColor(new Color(183, 172, 172));
        g.fillRect(0, 0, width, height);

        // 设置字体和字体大小
        Font font = new Font("Arial", Font.BOLD, 30);
        g.setFont(font);

        // 生成随机验证码字符串
        String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        String captcha = sb.toString();

        // 将验证码绘制在图片上
        g.setColor(Color.BLACK);
        g.drawString(captcha, 20, 35);

        // 保存图片
        ImageIO.write(image, "jpg", outputStream);

        g.dispose();
        return captcha;
    }
}