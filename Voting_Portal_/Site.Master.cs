using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Voting_Portal_
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                bool isLoggedIn = Session["UserRole"] != null;
                bool isAdmin = isLoggedIn && Session["UserRole"].ToString() == "Admin";

                // Toggle Logout button visibility
                if (btnLogout != null)
                {
                    btnLogout.Visible = isLoggedIn;
                }
            }
        }

               
            

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear and abandon the current session
            Session.Clear();
            Session.Abandon();

            // Sign out from Forms Authentication
            System.Web.Security.FormsAuthentication.SignOut();

            // Redirect to Login page
            Response.Redirect("~/Login.aspx");
        }
    }
}