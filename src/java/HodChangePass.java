
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/HodChangePass"})
public class HodChangePass extends HttpServlet {

    private Connection c1 = null;
    private PreparedStatement statement = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            databaseConnection();
            HttpSession session = request.getSession(true);
            String hodId = session.getAttribute("hodid").toString();

            String oldpass = request.getParameter("password");
            String newPass = request.getParameter("pwd1");
            String confPass = request.getParameter("pwd2");

            try {
                statement = c1.prepareStatement("select password from hod where hodId=?");
                statement.setString(1, hodId);
                ResultSet r = statement.executeQuery();
                if (r.next()) {
                    if (oldpass.equals(r.getString("password"))) {
                        if (newPass.length() >= 4 && newPass.length() <= 8) {
                            if (newPass.equals(confPass)) {

                                statement = c1.prepareStatement("update hod set password=? where hodId=?");
                                statement.setString(1, newPass);
                                statement.setString(2, hodId);
                                int rr = statement.executeUpdate();
                                if (rr > 0) {
                                    c1.close();
                                    session.setAttribute("status", "success");
                                    response.sendRedirect("Hod_ChangePassword.jsp");
                                }
                            } else {
                                c1.close();
                                session.setAttribute("error", "New Password and Confirm Password missmatched");
                                response.sendRedirect("Hod_ChangePassword.jsp");
                            }
                        } else {
                            c1.close();
                            session.setAttribute("error", "password must minimum 4 or max 8 charecter long");
                            response.sendRedirect("Hod_ChangePassword.jsp");
                        }
                    } else {
                        c1.close();
                        session.setAttribute("error", "Wrong Old Password");
                        response.sendRedirect("Hod_ChangePassword.jsp");
                    }
                }
            } catch (Exception e) {
                try {
                    c1.close();
                    session.setAttribute("status", "failed");
                    response.sendRedirect("Hod_ChangePassword.jsp");
                } catch (SQLException ex) {
                    Logger.getLogger(DeptChangepass.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
        }
    }

    private void databaseConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/noduseclearance", "root", "root");

        } catch (Exception e) {
            try {
                c1.close();
            } catch (SQLException ex) {
                Logger.getLogger(RegisterStudent.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
