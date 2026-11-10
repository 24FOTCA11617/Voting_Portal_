using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace Voting_Portal_
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        string fnm, nm;

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Save_btn_Click(object sender, EventArgs e)
        {
            getCon();

            string epicId = txtepic.Text.Trim().ToUpper();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Voters WHERE EpicId = '" + epicId + "'", con);

            if (Convert.ToInt16(cmd.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "EPIC ID already registered.";
                return;
            }

            string imagePath = "";

            if (Flpimg.HasFile)
            {
                string ext = Path.GetExtension(Flpimg.FileName).ToLower();

                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
                {
                     nm = "Voter/Voter_images/" + Path.GetFileName(Flpimg.FileName);

                     fnm = Server.MapPath("~/" + nm);

                    if (!Directory.Exists(Server.MapPath("~/Voter/Voter_images/")))
                    {
                        Directory.CreateDirectory(Server.MapPath("~/Voter/Voter_images/"));
                    }

                    Flpimg.SaveAs(fnm);
                    imagePath = "~/" + nm;
                }
                else
                {
                    lblMsg.Text = "Invalid file! Please upload a JPG, JPEG or PNG image.";
                    return;
                }
            }

            cmd = new SqlCommand("INSERT INTO Voters (EpicId, FullName, Email, Mobile, Gender, City, Address, VoterImage) VALUES ('" + epicId + "', '" + txtusername.Text.Trim() + "', '" + txtemail.Text.Trim() + "', '" + txtmbl.Text.Trim() + "', '" + rdogen.SelectedValue + "', '" + drpcity.SelectedValue + "', '" + txtaddress.Text.Trim() + "', '" + imagePath + "')", con);
            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                lblMsg.Text = "Registration successful!";

                txtepic.Text = "";
                txtusername.Text = "";
                txtemail.Text = "";
                txtmbl.Text = "";
                txtaddress.Text = "";

                rdogen.ClearSelection();
                drpcity.SelectedIndex = 0;
            }
            else
            {
                lblMsg.Text = "Registration failed.";
            }
        }
    }
}
