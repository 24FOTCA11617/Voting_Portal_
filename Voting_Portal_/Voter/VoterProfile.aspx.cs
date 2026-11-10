
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace Voting_Portal_.Voter
{
    public partial class VoterProfile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string fnm = "";
        string nm = "";

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void closeCon()
        {
            if (con != null && con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }

        // LOAD PROFILE AUTOMATICALLY
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EpicId"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                filldata();
            }
        }

        // IMAGE UPLOAD
        void upload()
        {
            string path = Path.GetExtension(Flpimg.FileName).ToLower();

            if (path == ".jpg" || path == ".jpeg" || path == ".png")
            {
                nm = "Voter/Voter_images/" + Guid.NewGuid().ToString() + path;

                string folderPath = Server.MapPath("~/Voter/Voter_images/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                fnm = Server.MapPath("~/" + nm);

                Flpimg.SaveAs(fnm);
            }
        }

        // FILL PROFILE DETAILS FROM DATABASE
        void filldata()
        {
            getCon();

            string epicId = Session["EpicId"].ToString();

            string query = "SELECT * FROM Voters WHERE EpicId = '" + epicId + "'";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                // TEXTBOX VALUES
                txtepic.Text = row["EpicId"].ToString();
                txtusername.Text = row["FullName"].ToString();
                txtemail.Text = row["Email"].ToString();
                txtmbl.Text = row["Mobile"].ToString();
                txtaddress.Text = row["Address"].ToString();

                // CITY DROPDOWN
                string city = row["City"].ToString();

                if (drpcity.Items.FindByValue(city) != null)
                {
                    drpcity.SelectedValue = city;
                }

                // GENDER RADIO BUTTON
                string gender = row["Gender"].ToString();

                if (rdogen.Items.FindByValue(gender) != null)
                {
                    rdogen.SelectedValue = gender;
                }

                // EXISTING IMAGE PATH
                fnm = row["VoterImage"].ToString();

                // VOTING STATUS
                bool hasVoted = Convert.ToBoolean(row["HasVoted"]);

                if (hasVoted)
                {
                    lblVoteStatus.Text = "VOTE CASTED (Completed)";
                    lblVoteStatus.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblVoteStatus.Text = "ELIGIBLE TO VOTE (Pending)";
                    lblVoteStatus.ForeColor = System.Drawing.Color.OrangeRed;
                }

                // GRIDVIEW
                gvVoterProfile.DataSource = ds.Tables[0];
                gvVoterProfile.DataBind();
            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "No voter profile found for this account.";
            }

            closeCon();
        }

        // UPDATE VOTER PROFILE
        protected void Save_btn_Click(object sender, EventArgs e)
        {
            if (Flpimg.HasFile)
            {
                string path = Path.GetExtension(Flpimg.FileName).ToLower();

                if (path != ".jpg" && path != ".jpeg" && path != ".png")
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Please upload a JPG, JPEG or PNG image.";
                    return;
                }

                upload();
            }

            getCon();

            string epicId = Session["EpicId"].ToString();

            string query;

            if (Flpimg.HasFile)
            {
                string imagePath = "~/" + nm;

                query = "UPDATE Voters SET FullName = '" + txtusername.Text.Trim() + "', Email = '" + txtemail.Text.Trim() + "', Mobile = '" + txtmbl.Text.Trim() + "', Gender = '" + rdogen.SelectedValue + "', City = '" + drpcity.SelectedValue + "', Address = '" + txtaddress.Text.Trim() + "', VoterImage = '" + imagePath + "' WHERE EpicId = '" + epicId + "'";
            }
            else
            {
                query = "UPDATE Voters SET FullName = '" + txtusername.Text.Trim() + "', Email = '" + txtemail.Text.Trim() + "', Mobile = '" + txtmbl.Text.Trim() + "', Gender = '" + rdogen.SelectedValue + "', City = '" + drpcity.SelectedValue + "', Address = '" + txtaddress.Text.Trim() + "' WHERE EpicId = '" + epicId + "'";
            }

            cmd = new SqlCommand(query, con);

            int result = cmd.ExecuteNonQuery();

            closeCon();

            if (result > 0)
            {
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Profile Particulars Updated Successfully!";
            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Profile update failed.";
            }

            // LOAD THE UPDATED PROFILE
            filldata();
        }
    }
}
