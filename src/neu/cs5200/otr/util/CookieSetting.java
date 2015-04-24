package neu.cs5200.otr.util;

import neu.cs5200.otr.dao.PersonDAO;
import neu.cs5200.otr.entity.Person;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by shunlin on 3/22/15.
 */
public class CookieSetting {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private PersonDAO pd;

    public CookieSetting(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
        this.pd = new PersonDAO();
    }

    public int login(String username, String password) {
        Person person = pd.getPersonByUsernameAndPassword(username, password);
        if (person == null) return -1;
        else {
            request.getSession().setAttribute("username", person.getUserId());
            return person.getUserId();
        }
    }

    public boolean checkLogin()  {
        if (session.getAttribute("userId") != null) return true;
        else return false;
    }

    //
    // 通过session获取当前浏览网页的用户的ID, 若未登录返回-1
    //
    // @return		返回浏览网页的用户ID, 或-1(游客)
    //
    public int getViewerId()  {
        if (session.getAttribute("userId") != null) return (Integer)session.getAttribute("userId");
        else return -1;
    }

    public HttpServletResponse logout()  {
        session.removeAttribute("userId");
        session.invalidate();
        return this.cancelRememberMe();
    }

    //
    // 下次自动登录, 有效期3天(259200s), 设置cookie
    //
    // @param $uid		自动登录的uid
    //
    public HttpServletResponse rememberMe(int userId)  {
        Person person = pd.getPersonByUserId(userId);
        Cookie username = new Cookie("username", person.getName());
        Cookie password = new Cookie("password", MD5(person.getPassword()));
        username.setMaxAge(259200);
        password.setMaxAge(259200);
        response.addCookie(username);
        response.addCookie(password);
        return response;
    }

    //
    // 取消下次登录, 设置过期cookie
    //
    // @param $uid		自动登录的uid
    //
    public HttpServletResponse cancelRememberMe()  {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().compareTo("username") == 0 ||
                        cookies[i].getName().compareTo("password") == 0) {
                    cookies[i].setMaxAge(0);
                    response.addCookie(cookies[i]);
                }
            }
        }
        return response;
    }

    public int autoLogin()  {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) return -1;
        boolean usernameFlag = false;
        boolean passwordFlag = false;
        String username = "";
        String password = "";
        Cookie usernameCookie = null;
        Cookie passwordCookie = null;
        for (Cookie cookie : cookies) {
            if (cookie.getName().compareTo("username") == 0) {
                usernameFlag = true;
                username = cookie.getValue();
                usernameCookie = cookie;
            }
            if (cookie.getName().compareTo("password") == 0) {
                passwordFlag = true;
                password = cookie.getValue();
                passwordCookie = cookie;
            }
        }
        if (usernameFlag && passwordFlag) {
            Person person = pd.getPersonByUsername(username);
            if (person != null) {
                if (person.getName().equals(username) && MD5(person.getPassword()).equals(password)) {
                    request.getSession().setAttribute("userId", person.getUserId());
                    usernameCookie.setMaxAge(259200);
                    passwordCookie.setMaxAge(259200);
                    response.addCookie(usernameCookie);
                    response.addCookie(passwordCookie);
                    return person.getUserId();
                }
            }
        }
        return -1;
    }

    public String MD5(String md5) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
        }
        return null;
    }
}
