using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;

namespace Voting_Portal_
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getCon()
        {
            con = new SqlConnection(s);
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (drpRole.SelectedValue == "Admin")
            {
                // Hardcoded Admin Authentication
                if (txtUsername.Text.Trim() == "admin" && txtPassword.Text == "admin123")
                {
                    Session["UserRole"] = "Admin";
                    Session["Username"] = "System Administrator";

                    // Creates authentication cookie for Web.config authorization rules
                    FormsAuthentication.SetAuthCookie("admin", false);

                    Response.Redirect("~/Admin/AdminDashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid Admin Credentials!";
                }
            }
            else
            {
                // Voter Authentication using Parameterized Query to prevent SQL Injection
                try
                {
                    getCon();
                    string query = "SELECT * FROM Voters WHERE EpicId = @EpicId";
                    cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@EpicId", txtUsername.Text.Trim().ToUpper());

                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow row = ds.Tables[0].Rows[0];

                        Session["UserRole"] = "Voter";
                        Session["EpicId"] = row["EpicId"].ToString();
                        Session["Username"] = row["FullName"].ToString();

                        FormsAuthentication.SetAuthCookie(row["EpicId"].ToString(), false);

                        Response.Redirect("~/Voter/VoterProfile.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "EPIC Identification Number Not Registered!";
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "An error occurred: " + ex.Message;
                }
                finally
                {
                    if (con != null && con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }
        }
    }
}