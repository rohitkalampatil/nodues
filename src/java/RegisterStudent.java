
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

@WebServlet(urlPatterns = {"/RegisterStudent"})
public class RegisterStudent extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            Connection c1 = null;

            String department = request.getParameter("department");
            String year = request.getParameter("year");
            String sName = request.getParameter("name");
            Long prn = Long.parseLong(request.getParameter("prn"));
            Long contact = Long.parseLong(request.getParameter("contact"));
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            String password = generatePassword(sName, prn);

            try {
                Class.forName("com.mysql.jdbc.Driver");
                c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/noduseClearance", "root", "root");
                PreparedStatement statement = c1.prepareStatement("insert into students values(?,?,?,?,?,?,?,?)");
                statement.setString(1, sName);
                statement.setLong(2, prn);
                statement.setString(3, department);
                statement.setString(4, year);
                statement.setLong(5, contact);
                statement.setString(6, email);
                statement.setString(7, address);
                statement.setString(8, password);

                int r = statement.executeUpdate();
                if (r > 0) {

                    c1.close();
                    // using session 
                    HttpSession s1 = request.getSession(true);
                    s1.setAttribute("status", "success");
                    response.sendRedirect("Department_AddStudent.jsp");
                }

                c1.close();
            } catch (Exception e) {
                try {
                    c1.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RegisterStudent.class.getName()).log(Level.SEVERE, null, ex);
                }
                out.print(e);
            }

        }

    }

    protected String generatePassword(String sName, Long prn) {
        String Prn = "" + prn;
        String namePart = sName.substring(0, Math.min(sName.length(), 4));

        // Extract the last 4 digits of prn
        String prnPart;
        if (Prn.length() >= 4) {
            prnPart = Prn.substring(Prn.length() - 4);
        } else {
            // Handle the case where prn has less than 4 digits
            prnPart = Prn;
        }
        return namePart + prnPart;
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
