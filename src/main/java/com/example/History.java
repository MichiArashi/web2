package com.example;

import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class History {
    private static final String HISTORY_ATTRIBUTE = "history";

    public static void writeHistory(HttpSession session, Point result) {
        if (session == null) {
            return;
        }

        List<Point> history = readHistory(session);
        history.add(result);
        session.setAttribute(HISTORY_ATTRIBUTE, history);
    }

    public static List<Point> readHistory(HttpSession session) {
        if (session == null) {
            return new ArrayList<>();
        }

        Object historyObj = session.getAttribute(HISTORY_ATTRIBUTE);
        if (historyObj instanceof List) {
            return (List<Point>) historyObj;
        }
        return new ArrayList<>();
    }

    public static void resetHistory(HttpSession session) {
        if (session != null) {
            session.setAttribute(HISTORY_ATTRIBUTE, new ArrayList<Point>());
        }
    }
}

