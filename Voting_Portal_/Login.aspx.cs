using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
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
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (drpRole.SelectedValue == "Admin")
            {
                if (txtUsername.Text.Trim() == "admin" && txtPassword.Text == "admin123")
                {
                    Session["UserRole"] = "Admin";
                    Session["Username"] = "System Administrator";

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
                getCon();

                cmd = new SqlCommand("SELECT * FROM Voters WHERE EpicId = '" + txtUsername.Text.Trim().ToUpper() + "'", con);
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

                    con.Close();

                    Response.Redirect("~/Voter/VoterProfile.aspx");
                }
                else
                {
                    lblMsg.Text = "EPIC Identification Number Not Registered!";
                    con.Close();
                }
            }
        }
    }
}


