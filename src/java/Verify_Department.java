
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/Verify_Department"})
public class Verify_Department extends HttpServlet {

    private static Connection c1 = null;
    private static PreparedStatement st = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            databaseConnection();
            HttpSession session = request.getSession(true);
            //fromdepartmentpannel :
            // check dprtSts is null ornot further
            String dprtSts = session.getAttribute("dprtSts").toString();
            String status = request.getParameter("status");
            Long Prn = Long.parseLong(request.getParameter("prn"));
            out.print(dprtSts + "" + status + "" + Prn);
            int dr = updateNodues(Prn, dprtSts, status);

            if (dr > 0) {
                session.setAttribute("status", "success");

                response.sendRedirect("Department_Dashboard.jsp");
            } else {
                session.setAttribute("status", "failed");

                response.sendRedirect("Department_Dashboard.jsp");
            }
        }
    }

    private int updateNodues(Long prn, String columnName, String status) {

        try {
            String sql = "update noduse set " + columnName + "='" + status + "' where prn=?";
            st = c1.prepareStatement(sql);
            st.setLong(1, prn);

            int r = st.executeUpdate();
            c1.close();
            return r;
        } catch (Exception e) {
            try {
                c1.close();
            } catch (SQLException ex) {
                Logger.getLogger(Verify.class.getName()).log(Level.SEVERE, null, ex);
            }
            return 0;
        }
    }

    private void databaseConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/noduseClearance", "root", "root");

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
