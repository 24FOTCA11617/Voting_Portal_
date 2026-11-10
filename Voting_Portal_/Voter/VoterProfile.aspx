
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VoterProfile.aspx.cs" Inherits="Voting_Portal_.Voter.VoterProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .voter-profile-page {
            width: 100%;
            max-width: 100%;
            overflow-x: hidden;
        }

        .voter-profile-card {
            width: 650px;
            max-width: calc(100% - 40px);
            margin: 25px auto 35px auto;
            box-sizing: border-box;
        }

        .voter-grid-section {
            width: calc(100% - 50px);
            margin: 30px auto;
            padding: 22px;
            box-sizing: border-box;
            background: #111f35;
            border: 1px solid #29466c;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
        }

        .grid-title-area {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 20px;
        }

        .grid-title-icon {
            width: 46px;
            height: 46px;
            min-width: 46px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #2563eb;
            border-radius: 12px;
            font-size: 22px;
        }

        .grid-title-text h3 {
            margin: 0;
            color: #f8fafc;
            font-size: 24px;
            font-weight: 700;
        }

        .grid-title-text p {
            margin: 5px 0 0 0;
            color: #94a3b8;
            font-size: 14px;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
            overflow-y: hidden;
            border: 1px solid #29466c;
            border-radius: 12px;
            background: #0f1d31;
        }

        .professional-grid {
            width: 1450px !important;
            min-width: 1450px !important;
            max-width: none !important;
            table-layout: fixed !important;
            border-collapse: separate !important;
            border-spacing: 0 !important;
            color: #dbeafe;
            font-size: 14px;
        }

        .professional-grid th {
            height: 58px !important;
            padding: 14px !important;
            box-sizing: border-box;
            background: #172b48 !important;
            color: #e0ecff !important;
            border-bottom: 1px solid #31527c !important;
            border-right: 1px solid #29466c !important;
            text-align: left !important;
            vertical-align: middle !important;
            font-size: 12px !important;
            font-weight: 700 !important;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            white-space: normal !important;
        }

        .professional-grid td {
            height: 115px !important;
            padding: 14px !important;
            box-sizing: border-box;
            background: #102039 !important;
            color: #cbd5e1 !important;
            border-bottom: 1px solid #263f61 !important;
            border-right: 1px solid #263f61 !important;
            vertical-align: middle !important;
            line-height: 1.5;
            overflow: hidden;
        }

        .professional-grid tr:hover td {
            background: #172d4b !important;
        }

        .professional-grid th:nth-child(1),
        .professional-grid td:nth-child(1) {
            width: 125px !important;
        }

        .professional-grid th:nth-child(2),
        .professional-grid td:nth-child(2) {
            width: 135px !important;
        }

        .professional-grid th:nth-child(3),
        .professional-grid td:nth-child(3) {
            width: 230px !important;
        }

        .professional-grid th:nth-child(4),
        .professional-grid td:nth-child(4) {
            width: 145px !important;
        }

        .professional-grid th:nth-child(5),
        .professional-grid td:nth-child(5) {
            width: 120px !important;
        }

        .professional-grid th:nth-child(6),
        .professional-grid td:nth-child(6) {
            width: 135px !important;
        }

        .professional-grid th:nth-child(7),
        .professional-grid td:nth-child(7) {
            width: 285px !important;
        }

        .professional-grid th:nth-child(8),
        .professional-grid td:nth-child(8) {
            width: 125px !important;
            text-align: center !important;
        }

        .professional-grid th:nth-child(9),
        .professional-grid td:nth-child(9) {
            width: 180px !important;
            text-align: center !important;
        }

        .epic-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 10px;
            border-radius: 9px;
            background: #163b75;
            border: 1px solid #2563eb;
            color: #60a5fa;
            font-weight: 700;
            font-size: 13px;
        }

        .voter-name {
            color: #f8fafc;
            font-size: 15px;
            font-weight: 700;
            white-space: normal;
        }

        .email-cell {
            color: #93c5fd;
            font-size: 13px;
            overflow-wrap: anywhere;
            word-break: break-word;
        }

        .mobile-cell {
            color: #dbeafe;
            font-weight: 600;
            white-space: nowrap;
        }

        .gender-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 13px;
            border-radius: 20px;
            background: #173b70;
            border: 1px solid #2563eb;
            color: #93c5fd;
            font-weight: 600;
        }

        .city-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 14px;
            border-radius: 20px;
            background: #263b59;
            border: 1px solid #405979;
            color: #cbd5e1;
            font-weight: 600;
        }

        .address-cell {
            color: #cbd5e1;
            font-size: 13px;
            line-height: 1.55;
            white-space: normal;
            overflow-wrap: break-word;
            word-break: normal;
        }

        .voter-image-wrapper {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .professional-grid .voter-grid-image {
            display: block !important;
            width: 78px !important;
            height: 78px !important;
            min-width: 78px !important;
            min-height: 78px !important;
            max-width: 78px !important;
            max-height: 78px !important;
            object-fit: cover !important;
            object-position: center !important;
            border-radius: 50% !important;
            border: 3px solid #60a5fa !important;
            padding: 2px !important;
            box-sizing: border-box !important;
            background: #0b1628 !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.35);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 9px 12px;
            min-width: 145px;
            box-sizing: border-box;
            border-radius: 25px;
            font-size: 11px;
            font-weight: 700;
            white-space: normal;
            text-align: center;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            min-width: 8px;
            border-radius: 50%;
            display: inline-block;
        }

        .status-voted {
            background: rgba(34, 197, 94, 0.15);
            border: 1px solid rgba(34, 197, 94, 0.45);
            color: #4ade80;
        }

        .status-voted .status-dot {
            background: #4ade80;
        }

        .status-pending {
            background: rgba(251, 146, 60, 0.15);
            border: 1px solid rgba(251, 146, 60, 0.45);
            color: #fb923c;
        }

        .status-pending .status-dot {
            background: #fb923c;
        }

        .grid-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 15px;
            padding: 0 5px;
        }

        .record-count {
            color: #94a3b8;
            font-size: 13px;
        }

        .record-indicator {
            padding: 6px 12px;
            border-radius: 18px;
            background: #1e3a5f;
            border: 1px solid #31527c;
            color: #93c5fd;
            font-size: 12px;
            font-weight: 600;
        }

        @media (max-width: 900px) {
            .voter-grid-section {
                width: calc(100% - 30px);
                padding: 15px;
            }

            .professional-grid {
                width: 1450px !important;
                min-width: 1450px !important;
            }
        }

        @media (max-width: 600px) {
            .voter-grid-section {
                width: calc(100% - 20px);
                padding: 12px;
            }

            .grid-title-text h3 {
                font-size: 20px;
            }

            .grid-title-text p {
                font-size: 12px;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="voter-profile-page">

        <div class="voter-card voter-profile-card">

            <h2>Voter Particulars &amp; Status</h2>

            <div class="admin-form">

                <div class="form-group">
                    <label>EPIC Identification</label>
                    <asp:TextBox ID="txtepic" runat="server"
                        CssClass="input-control" ReadOnly="true" />
                </div>

                <div class="form-group">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtusername" runat="server"
                        CssClass="input-control" />
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtemail" runat="server"
                        CssClass="input-control" />
                </div>

                <div class="form-group">
                    <label>Mobile Number</label>
                    <asp:TextBox ID="txtmbl" runat="server"
                        CssClass="input-control" />
                </div>

                <div class="form-group">
                    <label>Gender</label>
                    <asp:RadioButtonList ID="rdogen" runat="server"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Value="Male">Male</asp:ListItem>
                        <asp:ListItem Value="Female">Female</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="form-group">
                    <label>City Constituency</label>
                    <asp:DropDownList ID="drpcity" runat="server"
                        CssClass="input-control">
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
                    <label>Registered Address</label>
                    <asp:TextBox ID="txtaddress" runat="server"
                        TextMode="MultiLine" Rows="3"
                        CssClass="input-control" />
                </div>

                <div class="form-group">
                    <label>Profile Image</label>
                    <asp:FileUpload ID="Flpimg" runat="server" />
                </div>

                <div class="form-group">
                    <label>Polling Status</label>
                    <asp:Label ID="lblVoteStatus" runat="server"
                        Font-Bold="true" />
                </div>

                <asp:Button ID="Save_btn" runat="server"
                    Text="Update Profile"
                    CssClass="btn btn-primary"
                    OnClick="Save_btn_Click" />

                <asp:Label ID="lblMsg" runat="server"
                    ForeColor="Green"
                    Style="display:block; margin-top:10px;" />

            </div>
        </div>

        <div class="voter-grid-section">

            <div class="grid-title-area">
                <div class="grid-title-icon">👤</div>
                <div class="grid-title-text">
                    <h3>Voter Information</h3>
                    <p>Registered voter details and current polling status</p>
                </div>
            </div>

            <div class="table-responsive">

                <asp:GridView ID="gvVoterProfile" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="professional-grid"
                    GridLines="None"
                    EmptyDataText="No voter information found."
                    HeaderStyle-CssClass="grid-header-row"
                    RowStyle-CssClass="grid-row"
                    AlternatingRowStyle-CssClass="grid-alt-row">

                    <Columns>

                        <asp:TemplateField HeaderText="EPIC ID">
                            <ItemTemplate>
                                <span class="epic-badge"><%# Eval("EpicId") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Full Name">
                            <ItemTemplate>
                                <div class="voter-name"><%# Eval("FullName") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email Address">
                            <ItemTemplate>
                                <div class="email-cell"><%# Eval("Email") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Mobile Number">
                            <ItemTemplate>
                                <div class="mobile-cell"><%# Eval("Mobile") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Gender">
                            <ItemTemplate>
                                <span class="gender-badge"><%# Eval("Gender") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Constituency">
                            <ItemTemplate>
                                <span class="city-badge"><%# Eval("City") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Registered Address">
                            <ItemTemplate>
                                <div class="address-cell"><%# Eval("Address") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Profile">
                            <ItemTemplate>
                                <div class="voter-image-wrapper">
                                    <asp:Image ID="imgVoter" runat="server"
                                        ImageUrl='<%# Eval("VoterImage") %>'
                                        CssClass="voter-grid-image"
                                        AlternateText="Voter Profile" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Polling Status">
                            <ItemTemplate>
                                <span class='<%# Convert.ToBoolean(Eval("HasVoted")) ? "status-badge status-voted" : "status-badge status-pending" %>'>
                                    <span class="status-dot"></span>
                                    <%# Convert.ToBoolean(Eval("HasVoted")) ? "VOTE CASTED" : "ELIGIBLE TO VOTE" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>

            </div>

            <div class="grid-footer">
                <span class="record-count">Registered voter record</span>
                <span class="record-indicator">1 Record</span>
            </div>

        </div>

    </div>

</asp:Content>
