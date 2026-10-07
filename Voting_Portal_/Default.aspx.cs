using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Voting_Portal_
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string conStr = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Voters", con);
                    lblVoters.Text = cmd1.ExecuteScalar().ToString();

                    SqlCommand cmd2 = new SqlCommand("SELECT ISNULL(SUM(VoteCount),0) FROM Candidates", con);
                    lblVotes.Text = cmd2.ExecuteScalar().ToString();

                    SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM Candidates", con);
                    lblCandidates.Text = cmd3.ExecuteScalar().ToString();
                }
            }

        }
    }
}