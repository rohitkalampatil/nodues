
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(urlPatterns = {"/Login"})
public class Login extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           HttpSession s1 = request.getSession(true);
            s1.setAttribute("department", null);
            
            String department = request.getParameter("department");
            String password = request.getParameter("password");
            Connection c1;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/noduseclearance", "root", "root");
                PreparedStatement st = c1.prepareStatement("select password,departmentName from department where departmentName=?");
                st.setString(1, department);

                ResultSet r = st.executeQuery();
                if (r.next()) {
                    if (password.equals(r.getString("password"))) {
                        s1.setAttribute("department", department);
                        response.sendRedirect("Department_Dashboard.jsp");

                    } else {

                        s1.setAttribute("error", "Invalid Password");
                        s1.setAttribute("departmentName", department);
                        response.sendRedirect("Department_Login.jsp");
                    }
                } else {

                    s1.setAttribute("error", "Select Department");
                    response.sendRedirect("Department_Login.jsp");
                }
                c1.close();

            } catch (Exception e) {
                
                response.sendRedirect("Department_Login.jsp");
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
