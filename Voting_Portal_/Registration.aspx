<%@ Page Title="Voter Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Voting_Portal_.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="voter-card" style="max-width: 600px; margin: 0 auto;">
        <h2>Voter Onboarding Registration</h2>
        <div class="admin-form">
            
            <div class="form-group">
                <label>EPIC Card ID</label>
                <asp:TextBox ID="txtepic" runat="server" CssClass="input-control" Required="true" placeholder="Enter EPIC ID" />
            </div>

            <div class="form-group">
                <label>Full Name</label>
                <asp:TextBox ID="txtusername" runat="server" CssClass="input-control" Required="true" placeholder="Enter full name" />
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <asp:TextBox ID="txtemail" runat="server" TextMode="Email" CssClass="input-control" Required="true" placeholder="example@email.com" />
            </div>

            <div class="form-group">
                <label>Mobile Number</label>
                <asp:TextBox ID="txtmbl" runat="server" TextMode="Phone" CssClass="input-control" Required="true" placeholder="10-digit mobile number" />
            </div>

            <div class="form-group">
                <label>Gender</label>
                <asp:RadioButtonList ID="rdogen" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
                    <asp:ListItem Value="Male" Selected="True">Male</asp:ListItem>
                    <asp:ListItem Value="Female">Female</asp:ListItem>
                </asp:RadioButtonList>
            </div>


            <div class="form-group">
            <asp:DropDownList ID="drpcity" runat="server" CssClass="input-control">

    <asp:ListItem Value="Ahmedabad">Ahmedabad</asp:ListItem>
    <asp:ListItem Value="Bengaluru">Bengaluru</asp:ListItem>
    <asp:ListItem Value="Bhopal">Bhopal</asp:ListItem>
    <asp:ListItem Value="Bhubaneswar">Bhubaneswar</asp:ListItem>
    <asp:ListItem Value="Chandigarh">Chandigarh</asp:ListItem>
    <asp:ListItem Value="Chennai">Chennai</asp:ListItem>
    <asp:ListItem Value="Coimbatore">Coimbatore</asp:ListItem>
    <asp:ListItem Value="Dehradun">Dehradun</asp:ListItem>
    <asp:ListItem Value="Delhi">Delhi</asp:ListItem>
    <asp:ListItem Value="Gandhinagar">Gandhinagar</asp:ListItem>
    <asp:ListItem Value="Goa">Goa</asp:ListItem>
    <asp:ListItem Value="Gurugram">Gurugram</asp:ListItem>
    <asp:ListItem Value="Guwahati">Guwahati</asp:ListItem>
    <asp:ListItem Value="Hyderabad">Hyderabad</asp:ListItem>
    <asp:ListItem Value="Indore">Indore</asp:ListItem>
    <asp:ListItem Value="Jaipur">Jaipur</asp:ListItem>
    <asp:ListItem Value="Jammu">Jammu</asp:ListItem>
    <asp:ListItem Value="Kanpur">Kanpur</asp:ListItem>
    <asp:ListItem Value="Kochi">Kochi</asp:ListItem>
    <asp:ListItem Value="Kolkata">Kolkata</asp:ListItem>
    <asp:ListItem Value="Lucknow">Lucknow</asp:ListItem>
    <asp:ListItem Value="Ludhiana">Ludhiana</asp:ListItem>
    <asp:ListItem Value="Mumbai">Mumbai</asp:ListItem>
    <asp:ListItem Value="Mysuru">Mysuru</asp:ListItem>
    <asp:ListItem Value="Nagpur">Nagpur</asp:ListItem>
    <asp:ListItem Value="Nashik">Nashik</asp:ListItem>
    <asp:ListItem Value="Noida">Noida</asp:ListItem>
    <asp:ListItem Value="Patna">Patna</asp:ListItem>
    <asp:ListItem Value="Prayagraj">Prayagraj</asp:ListItem>
    <asp:ListItem Value="Pune">Pune</asp:ListItem>
    <asp:ListItem Value="Raipur">Raipur</asp:ListItem>
    <asp:ListItem Value="Rajkot">Rajkot</asp:ListItem>
    <asp:ListItem Value="Ranchi">Ranchi</asp:ListItem>
    <asp:ListItem Value="Srinagar">Srinagar</asp:ListItem>
    <asp:ListItem Value="Surat">Surat</asp:ListItem>
    <asp:ListItem Value="Thane">Thane</asp:ListItem>
    <asp:ListItem Value="Thiruvananthapuram">Thiruvananthapuram</asp:ListItem>
    <asp:ListItem Value="Udaipur">Udaipur</asp:ListItem>
    <asp:ListItem Value="Vadodara">Vadodara</asp:ListItem>
    <asp:ListItem Value="Varanasi">Varanasi</asp:ListItem>
    <asp:ListItem Value="Vijayawada">Vijayawada</asp:ListItem>
    <asp:ListItem Value="Visakhapatnam">Visakhapatnam</asp:ListItem>

                </asp:DropDownList>
                
                </div>

            <div class="form-group">
                <label>Full Address</label>
                <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="input-control" placeholder="Enter full residential address" />
            </div>

            <div class="form-group">
             <label>Profile Image</label>
            <asp:FileUpload ID="Flpimg" runat="server" />

            </div>

            <asp:Button ID="Save_btn" runat="server" Text="Register Voter" CssClass="btn btn-primary btn-block" OnClick="Save_btn_Click" />
            <asp:Label ID="lblMsg" runat="server" ForeColor="Green" style="display:block; margin-top:10px; text-align:center;" />

        </div>
    
</asp:Content>