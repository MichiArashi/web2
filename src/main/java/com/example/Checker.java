package com.example;

public class Checker {

    public static Point handlePointCheck(double x, double y, double r) {
        // Rectangle in Quadrant II:
        boolean inRectangle = (x <= r && x >= 0) &&
                (y <= 0 && y >= -r/2);

        // Triangle in Quadrant III:
        boolean inTriangle = (x >= -r/2 && x <= 0) &&
                (y >= -r/2 && y <= 0) &&
                (y >= x);

        // Quarter circle in Quadrant IV:
        boolean inQuarterCircle = (x <= 0 && x >= -r) &&
                (y <= r && y >= 0) &&
                (x * x + y * y <= r * r);

        boolean success = inRectangle || inTriangle || inQuarterCircle;

        return new Point(success, r, x, y);
    }
}



