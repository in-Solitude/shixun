package ngw.part.student;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/Student/*")
public class StudentFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化过滤器
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
// 获取请求URL
        String requestUrl = httpRequest.getRequestURL().toString();

// 如果是CSS文件，则跳过过滤器
        if (requestUrl.endsWith(".css")||requestUrl.endsWith("Servlet")||requestUrl.endsWith("Login.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // 获取当前会话
        HttpSession session = httpRequest.getSession(false);

        // 检查用户是否已登录
        boolean isLoggedIn = (session != null && session.getAttribute("Student") != null);

        // 如果用户未登录，则重定向到登录页面
        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/Student/Login.jsp");
            return;
        }

        // 用户已登录，继续处理请求
        chain.doFilter(request, response);
        return;
    }

    @Override
    public void destroy() {
        // 销毁过滤器
    }
}

