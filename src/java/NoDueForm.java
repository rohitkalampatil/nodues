
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/NoDueForm"})
public class NoDueForm extends HttpServlet {

    private Connection c1 = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            databaseConnection();

            Long prn = Long.parseLong(request.getParameter("prn"));
            String year = request.getParameter("year");
            String accountSts = request.getParameter("status_account");
            String librarySts = request.getParameter("status_library");
            String hostelSts = request.getParameter("status_hostel");
            String laboratorySts = request.getParameter("status_laboratory");

            try {
                Statement st = null;
                st = c1.createStatement();
                String q = "select prn from students where prn=" + prn;
                ResultSet result = st.executeQuery(q);

                if (result.next()) {

                    PreparedStatement statement = c1.prepareStatement("insert into noduse values(?,?,?,?,?,?)");
                    statement.setLong(1, prn);
                    statement.setString(2, year);
                    statement.setString(3, accountSts);
                    statement.setString(4, librarySts);
                    statement.setString(5, hostelSts);
                    statement.setString(6, laboratorySts);

                    int r = statement.executeUpdate();
                    if (r > 0) {

                        c1.close();
                        // using session 
                        HttpSession s1 = request.getSession(true);
                        s1.setAttribute("status", "success");
                        response.sendRedirect("Department_ViewStudent.jsp");
                    }
                } else {
                    c1.close();
                    // using session 
                    HttpSession s1 = request.getSession(true);
                    s1.setAttribute("status", "failed");
                    response.sendRedirect("Department_ViewStudent.jsp");
                }
            } catch (Exception e) {
                try {
                    c1.close();
                    // using session
                    HttpSession s1 = request.getSession(true);
                    s1.setAttribute("status", "duplicate");
                    response.sendRedirect("Department_ViewStudent.jsp");
                } catch (SQLException ex) {
                    Logger.getLogger(NoDueForm.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

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
