using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;

using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web.Design;

namespace Voting_Portal_.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null ||
                Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/Unauthorized.aspx");
                return;
            }

            if (!IsPostBack)
            {
                loadMetrics();
                loadlogs();
            }
        }

        // LOAD DASHBOARD METRICS
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

       // LOAD VOTING LOGS
        void loadlogs()
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

       // 1. ELECTION RESULT SUMMARY REPORT
        protected void btnElectionResult_Click(object sender, EventArgs e)
        {
            getCon();

            da = new SqlDataAdapter(@"WITH CandidateResults AS (SELECT C.CandidateId,C.Name AS CandidateName, C.Party, COUNT(L.LogId) AS TotalVotes FROM Candidates C LEFT JOIN VoterLogs L ON C.CandidateId = L.CandidateId GROUP BY C.CandidateId,C.Name, C.Party ), FinalResults AS ( SELECT *,SUM(TotalVotes) OVER() AS TotalVotesCast, MAX(TotalVotes) OVER() AS HighestVotes FROM CandidateResults ) SELECT CandidateId,CandidateName,Party,TotalVotes,TotalVotesCast, CAST(TotalVotes * 100.0 / NULLIF(TotalVotesCast, 0) AS DECIMAL(10,2) ) AS VotePercentage, CASE WHEN TotalVotesCast = 0 THEN 'No Votes' WHEN TotalVotes = HighestVotes THEN 'Winner' ELSE 'Participant' END AS ResultStatus FROM FinalResults ORDER BY TotalVotes DESC", con);

            ds = new DataSet();
            da.Fill(ds);

            string xml = Server.MapPath("~/ReportData.xml");
            ds.WriteXmlSchema(xml);

            string path = Server.MapPath("~/ElectionResultSummary.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat,Response,true,"ElectionResultSummary");

            
        }

        // 2. CANDIDATE-WISE VOTING REPORT
        protected void btnCandidateReport_Click(object sender, EventArgs e)
        {
            getCon();

            da = new SqlDataAdapter(@"SELECT C.CandidateId,C.Name AS CandidateName,C.ElectionType,C.State,C.Constituency,C.Party,COUNT(L.LogId) AS VoteCount FROM Candidates C LEFT JOIN VoterLogs L ON C.CandidateId = L.CandidateId GROUP BY C.CandidateId,C.Name,C.ElectionType,C.State,C.Constituency,C.Party ORDER BY VoteCount DESC", con);

            ds = new DataSet();
            da.Fill(ds);

            string xml = Server.MapPath("~/CandidateReportData.xml");
            ds.WriteXmlSchema(xml);

            string path = Server.MapPath("~/CandidateWiseVoting.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat,
            Response, true, "CandidateWiseVoting");


        }

       // 3. VOTER REGISTRATION DETAILS REPORT
        protected void btnVoterReport_Click(object sender, EventArgs e)
        {
            getCon();

            da = new SqlDataAdapter(@"SELECT EpicId,FullName,Email,Mobile,Gender,City, CreatedAt AS RegistrationDate FROM Voters ORDER BY CreatedAt DESC", con);

            ds = new DataSet();
            da.Fill(ds);

            string xml = Server.MapPath("~/VoterReportData.xml");
            ds.WriteXmlSchema(xml);

            string path = Server.MapPath("~/VoterRegistrationDetails.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat,
            Response, true, "VoterRegistrationDetails");




        }

        // 4. VOTER TURNOUT AND STATUS REPORT
        protected void btnTurnoutReport_Click(object sender, EventArgs e)
        {
            getCon();

            da = new SqlDataAdapter(@"SELECT V.EpicId,V.FullName AS VoterName,CASE WHEN V.HasVoted = 1 THEN 'Voted' ELSE 'Pending' END AS VotingStatus,COUNT(*) OVER() AS RegisteredVoters,SUM(CASE WHEN V.HasVoted = 1 THEN 1 ELSE 0 END) OVER() AS VotedVoters,SUM(CASE WHEN V.HasVoted = 0 THEN 1 ELSE 0 END ) OVER() AS RemainingVoters,CAST(SUM(CASE WHEN V.HasVoted = 1 THEN 1 ELSE 0 END) OVER() * 100.0 / NULLIF(COUNT(*) OVER(), 0) AS DECIMAL(10,2) ) AS TurnoutPercentage FROM Voters V ORDER BY V.EpicId", con);

            ds = new DataSet();
            da.Fill(ds);

            string xml = Server.MapPath("~/TurnoutReportData.xml");
            ds.WriteXmlSchema(xml);


            string path = Server.MapPath("~/VoterTurnoutStatus.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat,
            Response, true, "VoterTurnoutStatus");


        }

   
        // 5. VOTING ACTIVITY AND AUDIT LOG REPORT
        protected void btnAuditReport_Click(object sender, EventArgs e)
        {
            getCon();

            da = new SqlDataAdapter(@"SELECT L.LogId,L.EpicId,L.CandidateId,C.Name AS CandidateName,CAST(L.[Timestamp] AS DATE ) AS VotingDate,CAST(L.[Timestamp] AS TIME ) AS VotingTime FROM VoterLogs L INNER JOIN Candidates C ON L.CandidateId = C.CandidateId ORDER BY L.[Timestamp] DESC", con);

            ds = new DataSet();
            da.Fill(ds);

            string xml = Server.MapPath("~/AuditReportData.xml");
            ds.WriteXmlSchema(xml);

            string path = Server.MapPath("~/VotingActivityAudit.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat,
            Response, true, "VotingActivityAudit");


            con.Close();
        }
    }
}
