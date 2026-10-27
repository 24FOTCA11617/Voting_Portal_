using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Voting_Portal_.Voter
{
    public partial class VoterBallot : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                fillCandidates();
            }
        }
        void fillCandidates()
        {
            getCon();
            da = new SqlDataAdapter("Select * from Candidates", con);
            ds = new DataSet();
            da.Fill(ds);
            rptCandidates.DataSource = ds;
            rptCandidates.DataBind();
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            getCon();
            da = new SqlDataAdapter("Select * from Voters where EpicId='" + txtepic.Text.Trim().ToUpper() + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                bool hasVoted = Convert.ToBoolean(ds.Tables[0].Rows[0]["HasVoted"]);
                if (hasVoted)
                {
                    lblStatus.Text = "Already Voted";
                    lblStatus.CssClass = "voter-status has-voted";
                    Session["IsVerified"] = false;
                }
                else
                {
                    lblStatus.Text = "Verified & Eligible";
                    lblStatus.CssClass = "voter-status verified";
                    Session["IsVerified"] = true;
                    Session["EpicId"] = txtepic.Text.Trim().ToUpper();
                }
            }
            else
            {
                lblStatus.Text = "EPIC ID Not Found";
                lblStatus.CssClass = "voter-status has-voted";
                Session["IsVerified"] = false;
            }
            fillCandidates();
        }

        protected void rptCandidates_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cast_vote")
            {
                if (Session["IsVerified"] == null || !(bool)Session["IsVerified"])
                {
                    Response.Write("<script>alert('Please verify your EPIC ID first.');</script>");
                    return;
                }

                string candidateId = e.CommandArgument.ToString();
                string epic = Session["EpicId"].ToString();

                getCon();

                // Increment vote count
                cmd = new SqlCommand("Update Candidates set VoteCount = VoteCount + 1 where CandidateId='" + candidateId + "'", con);
                cmd.ExecuteNonQuery();

                // Update Voter Status
                cmd = new SqlCommand("Update Voters set HasVoted = 1 where EpicId='" + epic + "'", con);
                cmd.ExecuteNonQuery();

                // Log Transaction
                cmd = new SqlCommand("Insert into VoterLogs(EpicId, CandidateId) values('" + epic + "', '" + candidateId + "')", con);
                cmd.ExecuteNonQuery();

                Session["IsVerified"] = false;
                lblStatus.Text = "Vote Cast Successfully";
                lblStatus.CssClass = "voter-status has-voted";

                Response.Write("<script>alert('Your vote has been securely recorded!');</script>");
                fillCandidates();

            }
        }
    }
}