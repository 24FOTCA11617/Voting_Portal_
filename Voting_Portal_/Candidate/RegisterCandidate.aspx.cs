
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Voting_Portal_.Candidate
{
    public partial class RegisterCandidate : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string fnm, nm;
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

        void upload()
        {
            string path = Path.GetExtension(imgupload.FileName).ToLower();

            if (path == ".jpg" || path == ".jpeg" || path == ".png")
            {
                nm = "Candidate/Candidate_images/" + Guid.NewGuid().ToString() + path;
                fnm = Server.MapPath("~/" + nm);

                string folderPath = Server.MapPath("~/Candidate/Candidate_images/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                imgupload.SaveAs(fnm);
            }
            else
            {
                Response.Write("<script>alert('Invalid file! Please upload a JPG, JPEG or PNG image.');</script>");
            }
        }

        void clear()
        {
            txtusername.Text = "";
            txtConstituency.Text = "";
            txtaddress.Text = "";

            ddlElectionType.ClearSelection();
            ddlState.ClearSelection();
            ddlParty.ClearSelection();

            ViewState["id"] = null;
            Save_btn.Text = "Register Candidate";
        }

        void ShowMessage(string message, bool success)
        {
            string safeMessage = message.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", "").Replace("\n", "");

            ClientScript.RegisterStartupScript(GetType(), "candidateMessage", "alert('" + safeMessage + "');", true);
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
                fillGrid();
            }
        }

        protected void Save_btn_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtusername.Text))
            {
                ShowMessage("Please enter candidate name.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(ddlElectionType.SelectedValue))
            {
                ShowMessage("Please select election type.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(ddlState.SelectedValue))
            {
                ShowMessage("Please select State / Union Territory.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(txtConstituency.Text))
            {
                ShowMessage("Please enter constituency.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(ddlParty.SelectedValue))
            {
                ShowMessage("Please select political party.", false);
                return;
            }

            string imagePath = "";
            bool isUpdate = ViewState["id"] != null;

            if (isUpdate)
            {
                imagePath = GetExistingImage(Convert.ToInt32(ViewState["id"]));
            }

            if (imgupload.HasFile)
            {
                string extension = Path.GetExtension(imgupload.FileName).ToLower();

                if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
                {
                    ShowMessage("Invalid file! Please upload a JPG, JPEG or PNG image.", false);
                    return;
                }

                upload();
                imagePath = "~/" + nm;
            }

            getCon();

            if (!isUpdate)
            {
                string query = "INSERT INTO Candidates (Name, ElectionType, State, Constituency, Party, Bio, ImagePath) VALUES ('" + txtusername.Text.Trim() + "', '" + ddlElectionType.SelectedValue + "', '" + ddlState.SelectedValue + "', '" + txtConstituency.Text.Trim() + "', '" + ddlParty.SelectedValue + "', '" + txtaddress.Text.Trim() + "', '" + imagePath + "')";

                cmd = new SqlCommand(query, con);

                int result = cmd.ExecuteNonQuery();

                closeCon();

                if (result > 0)
                {
                    ShowMessage("Candidate registered successfully.", true);
                    clear();
                    fillGrid();
                }
                else
                {
                    ShowMessage("Candidate registration failed.", false);
                }
            }
            else
            {
                string query = "UPDATE Candidates SET Name = '" + txtusername.Text.Trim() + "', ElectionType = '" + ddlElectionType.SelectedValue + "', State = '" + ddlState.SelectedValue + "', Constituency = '" + txtConstituency.Text.Trim() + "', Party = '" + ddlParty.SelectedValue + "', Bio = '" + txtaddress.Text.Trim() + "', ImagePath = '" + imagePath + "' WHERE CandidateId = " + Convert.ToInt32(ViewState["id"]);

                cmd = new SqlCommand(query, con);

                int result = cmd.ExecuteNonQuery();

                closeCon();

                if (result > 0)
                {
                    ShowMessage("Candidate details updated successfully.", true);
                    clear();
                    fillGrid();
                }
                else
                {
                    ShowMessage("Candidate update failed.", false);
                }
            }
        }

        string GetExistingImage(int candidateId)
        {
            string imagePath = "";

            getCon();

            string query = "SELECT ImagePath FROM Candidates WHERE CandidateId = " + candidateId;

            cmd = new SqlCommand(query, con);

            object result = cmd.ExecuteScalar();

            if (result != null && result != DBNull.Value)
            {
                imagePath = result.ToString();
            }

            closeCon();

            return imagePath;
        }

        void fillGrid()
        {
            getCon();

            string query = "SELECT CandidateId, Name, ElectionType, State, Constituency, Party, Bio, ImagePath FROM Candidates ORDER BY CandidateId DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();

            da.Fill(ds);

            GridView1.DataSource = ds.Tables[0];
            GridView1.DataBind();

            closeCon();
        }

        void filldata()
        {
            if (ViewState["id"] == null)
            {
                return;
            }

            getCon();

            string query = "SELECT CandidateId, Name, ElectionType, State, Constituency, Party, Bio, ImagePath FROM Candidates WHERE CandidateId = " + Convert.ToInt32(ViewState["id"]);

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();

            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                txtusername.Text = row["Name"].ToString();

                if (ddlElectionType.Items.FindByValue(row["ElectionType"].ToString()) != null)
                {
                    ddlElectionType.SelectedValue = row["ElectionType"].ToString();
                }

                if (ddlState.Items.FindByValue(row["State"].ToString()) != null)
                {
                    ddlState.SelectedValue = row["State"].ToString();
                }

                txtConstituency.Text = row["Constituency"].ToString();

                if (ddlParty.Items.FindByValue(row["Party"].ToString()) != null)
                {
                    ddlParty.SelectedValue = row["Party"].ToString();
                }

                txtaddress.Text = row["Bio"].ToString();
            }

            closeCon();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                ViewState["id"] = id;

                filldata();

                Save_btn.Text = "Update Candidate";
            }
            else if (e.CommandName == "cmd_del")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                DeleteCandidate(id);
            }
        }

        void DeleteCandidate(int candidateId)
        {
            string imagePath = GetExistingImage(candidateId);

            getCon();

            string query = "DELETE FROM Candidates WHERE CandidateId = " + candidateId;

            cmd = new SqlCommand(query, con);

            int result = cmd.ExecuteNonQuery();

            closeCon();

            if (result > 0)
            {
                DeleteImageFile(imagePath);

                ShowMessage("Candidate deleted successfully.", true);

                fillGrid();
            }
            else
            {
                ShowMessage("Candidate not found.", false);
            }
        }

        void DeleteImageFile(string imagePath)
        {
            if (!string.IsNullOrWhiteSpace(imagePath))
            {
                string physicalPath = Server.MapPath(imagePath);

                if (File.Exists(physicalPath))
                {
                    File.Delete(physicalPath);
                }
            }
        }
    }
}
