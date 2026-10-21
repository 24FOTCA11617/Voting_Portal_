using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;

namespace Voting_Portal_.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
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
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/Unauthorized.aspx");
                return;
            }

            if (!IsPostBack)
            {
                loadMetrics();
                loadLogs();
            }
        }

        void loadMetrics()
        {
            getCon();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Voters", con);
            int registeredVoters = Convert.ToInt32(cmd.ExecuteScalar());

            cmd = new SqlCommand("SELECT ISNULL(SUM(VoteCount), 0) FROM Candidates", con);
            int totalVotes = Convert.ToInt32(cmd.ExecuteScalar());

            cmd = new SqlCommand("SELECT COUNT(*) FROM Candidates", con);
            int totalCandidates = Convert.ToInt32(cmd.ExecuteScalar());

            cmd = new SqlCommand("SELECT TOP 1 Name, VoteCount FROM Candidates ORDER BY VoteCount DESC, CandidateId ASC", con);

            string leaderName = "--";
            int leaderVotes = 0;

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                leaderName = reader["Name"].ToString();
                leaderVotes = Convert.ToInt32(reader["VoteCount"]);
            }

            reader.Close();

            decimal turnout = 0;

            if (registeredVoters > 0)
            {
                turnout = ((decimal)totalVotes / registeredVoters) * 100;
            }

            if (turnout > 100)
            {
                turnout = 100;
            }

            int remainingVoters = registeredVoters - totalVotes;

            if (remainingVoters < 0)
            {
                remainingVoters = 0;
            }

            lblRegisteredVoters.Text = registeredVoters.ToString();
            lblTotalVotes.Text = totalVotes.ToString();
            lblCandidates.Text = totalCandidates.ToString();
            lblTurnout.Text = turnout.ToString("0.0") + "%";
            lblLeader.Text = leaderName;
            lblLeaderVotes.Text = leaderVotes.ToString() + " votes";

            lblOverviewVoters.Text = registeredVoters.ToString();
            lblOverviewVotes.Text = totalVotes.ToString();
            lblRemainingVoters.Text = remainingVoters.ToString();
            lblOverviewCandidates.Text = totalCandidates.ToString();

            cmd = new SqlCommand("SELECT TOP 1 Timestamp FROM VoterLogs ORDER BY Timestamp DESC", con);
            object lastActivity = cmd.ExecuteScalar();

            if (lastActivity != null && lastActivity != DBNull.Value)
            {
                DateTime activityTime = Convert.ToDateTime(lastActivity);
                lblLastActivity.Text = activityTime.ToString("dd MMM yyyy, hh:mm tt");
            }
            else
            {
                lblLastActivity.Text = "No activity";
            }

            con.Close();
        }

        void loadLogs()
        {
            getCon();

            string query = "SELECT L.LogId, L.EpicId, C.Name AS VotedCandidate, L.Timestamp FROM VoterLogs L INNER JOIN Candidates C ON L.CandidateId = C.CandidateId ORDER BY L.Timestamp DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            gvLogs.DataSource = ds.Tables[0];
            gvLogs.DataBind();

            con.Close();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            getCon();

            cmd = new SqlCommand("SELECT L.EpicId, C.Name AS CandidateName, L.Timestamp FROM VoterLogs L INNER JOIN Candidates C ON L.CandidateId = C.CandidateId ORDER BY L.Timestamp DESC", con);

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("EPIC ID,Candidate Choice,Timestamp");

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                string epicId = dr["EpicId"].ToString().Replace("\"", "\"\"");
                string candidate = dr["CandidateName"].ToString().Replace("\"", "\"\"");
                string timestamp = Convert.ToDateTime(dr["Timestamp"]).ToString("dd-MM-yyyy HH:mm:ss");

                sb.AppendLine("\"" + epicId + "\",\"" + candidate + "\",\"" + timestamp + "\"");
            }

            dr.Close();
            con.Close();

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("Content-Disposition", "attachment;filename=Voter_Audit_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";
            Response.Write(sb.ToString());
            Response.Flush();

            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            getCon();

            SqlTransaction transaction = con.BeginTransaction();

            cmd = new SqlCommand("UPDATE Candidates SET VoteCount = 0", con, transaction);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("UPDATE Voters SET HasVoted = 0", con, transaction);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("DELETE FROM VoterLogs", con, transaction);
            cmd.ExecuteNonQuery();

            transaction.Commit();
            transaction.Dispose();

            con.Close();

            loadMetrics();
            loadLogs();

            ClientScript.RegisterStartupScript(GetType(), "ResetSuccess", "alert('All voting registers have been reset successfully.');", true);
        }
    }
}
