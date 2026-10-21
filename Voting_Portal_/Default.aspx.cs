using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Voting_Portal_
{
    public partial class Default : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        //SqlDataAdapter da;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

                con = new SqlConnection(s);
                con.Open();

                cmd = new SqlCommand("SELECT COUNT(*) FROM Voters", con);
                lblVoters.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT ISNULL(SUM(VoteCount), 0) FROM Candidates", con);
                lblVotes.Text = cmd.ExecuteScalar().ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM Candidates", con);
                lblCandidates.Text = cmd.ExecuteScalar().ToString();

                con.Close();
            }
        }
    }
}
