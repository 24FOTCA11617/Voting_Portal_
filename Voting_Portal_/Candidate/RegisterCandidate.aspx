<%@ Page Title="Candidate Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterCandidate.aspx.cs" Inherits="Voting_Portal_.Candidate.RegisterCandidate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .candidate-page {
            width: 100%;
            max-width: 1450px;
            margin: 0 auto;
            padding: 30px 25px 50px;
            box-sizing: border-box;
        }

        .candidate-layout {
            display: flex !important;
            flex-direction: column !important;
            gap: 30px !important;
            width: 100%;
            align-items: stretch !important;
        }

        .candidate-card {
            width: 100% !important;
            max-width: 100% !important;
            box-sizing: border-box;
            background: #172033;
            border: 1px solid #334155;
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
        }

        .candidate-card-title {
            margin: 0 0 25px;
            padding-bottom: 17px;
            border-bottom: 1px solid #334155;
            color: #f8fafc;
            font-family: Arial, sans-serif;
            font-size: 24px;
            font-weight: 700;
        }

        .candidate-form {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 20px 25px;
            width: 100%;
        }

        .candidate-form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 0;
        }

        .candidate-form-group label {
            color: #cbd5e1;
            font-size: 13px;
            font-weight: 700;
            font-family: Arial, sans-serif;
        }

        .candidate-input {
            width: 100% !important;
            min-height: 46px;
            padding: 12px 14px !important;
            box-sizing: border-box !important;
            border: 1px solid #3b4d68 !important;
            border-radius: 10px !important;
            background: #0f172a !important;
            color: #f8fafc !important;
            font-size: 14px !important;
            font-family: Arial, sans-serif;
            outline: none !important;
        }

        .candidate-input:focus {
            border-color: #3b82f6 !important;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.12) !important;
        }

        .candidate-input::placeholder {
            color: #64748b !important;
        }

        textarea.candidate-input {
            min-height: 110px !important;
            resize: vertical;
            line-height: 1.6;
        }

        .candidate-file {
            width: 100% !important;
            min-height: 46px;
            padding: 10px !important;
            box-sizing: border-box;
            border: 1px dashed #475569;
            border-radius: 10px;
            background: #0f172a;
            color: #cbd5e1;
            font-size: 13px;
        }

        .candidate-form-group:nth-child(7),
        .candidate-form-group:nth-child(8) {
            grid-column: span 1;
        }

        .candidate-save-button {
            grid-column: 1 / -1;
            width: 260px !important;
            min-height: 48px !important;
            margin: 5px auto 0;
            border: none !important;
            border-radius: 10px !important;
            background: linear-gradient(135deg, #2563eb, #1d4ed8) !important;
            color: white !important;
            font-size: 14px !important;
            font-weight: 700 !important;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.25);
        }

        .candidate-save-button:hover {
            background: linear-gradient(135deg, #3b82f6, #2563eb) !important;
            transform: translateY(-1px);
        }

        .candidate-table-card {
            width: 100% !important;
            max-width: 100% !important;
            min-width: 0;
            box-sizing: border-box;
            background: #172033;
            border: 1px solid #334155;
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
            overflow: hidden;
        }

        .candidate-table-card .candidate-card-title {
            margin-bottom: 20px;
        }

        .candidate-table-container {
            width: 100%;
            max-width: 100%;
            overflow-x: auto;
            overflow-y: hidden;
            box-sizing: border-box;
            border: 1px solid #334155;
            border-radius: 14px;
            background: #1e293b;
        }

        .candidate-table {
            width: 100% !important;
            min-width: 1100px !important;
            border-collapse: collapse !important;
            border-spacing: 0 !important;
            color: #e2e8f0;
            font-family: Arial, sans-serif;
            font-size: 13px;
            table-layout: fixed !important;
        }

        .candidate-table th {
            height: 55px !important;
            padding: 15px 14px !important;
            background: #111c30 !important;
            color: #f8fafc !important;
            border: none !important;
            border-bottom: 2px solid #334155 !important;
            font-size: 11px !important;
            font-weight: 700 !important;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-align: left !important;
            white-space: nowrap !important;
            box-sizing: border-box;
        }

        .candidate-table td {
            min-height: 82px !important;
            padding: 14px !important;
            background: #1e293b !important;
            color: #cbd5e1 !important;
            border: none !important;
            border-bottom: 1px solid #334155 !important;
            vertical-align: middle !important;
            box-sizing: border-box;
        }

        .candidate-table tr:hover td {
            background: #27364d !important;
        }

        .candidate-table th:nth-child(1),
        .candidate-table td:nth-child(1) {
            width: 60px !important;
            text-align: center !important;
        }

        .candidate-table th:nth-child(2),
        .candidate-table td:nth-child(2) {
            width: 190px !important;
        }

        .candidate-table th:nth-child(3),
        .candidate-table td:nth-child(3) {
            width: 145px !important;
        }

        .candidate-table th:nth-child(4),
        .candidate-table td:nth-child(4) {
            width: 160px !important;
        }

        .candidate-table th:nth-child(5),
        .candidate-table td:nth-child(5) {
            width: 190px !important;
        }

        .candidate-table th:nth-child(6),
        .candidate-table td:nth-child(6) {
            width: 150px !important;
        }

        .candidate-table th:nth-child(7),
        .candidate-table td:nth-child(7) {
            width: 110px !important;
            text-align: center !important;
        }

        .candidate-table th:nth-child(8),
        .candidate-table td:nth-child(8) {
            width: 150px !important;
            text-align: center !important;
        }

        .candidate-table td:first-child {
            color: #60a5fa !important;
            font-weight: 700 !important;
            font-size: 14px !important;
        }

        .candidate-table td:nth-child(2) {
            color: #f8fafc !important;
            font-weight: 700 !important;
            line-height: 1.5 !important;
        }

        .candidate-table td:nth-child(3) {
            color: #93c5fd !important;
            font-weight: 600 !important;
        }

        .candidate-table td:nth-child(4) {
            color: #cbd5e1 !important;
        }

        .candidate-table td:nth-child(5) {
            color: #cbd5e1 !important;
        }

        .candidate-table td:nth-child(6) {
            color: #f1f5f9 !important;
            font-weight: 600 !important;
        }

        .candidate-image-container {
            width: 100%;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .candidate-image {
            width: 58px !important;
            height: 58px !important;
            min-width: 58px !important;
            max-width: 58px !important;
            min-height: 58px !important;
            max-height: 58px !important;
            padding: 0 !important;
            margin: 0 !important;
            display: block !important;
            object-fit: cover !important;
            object-position: center !important;
            border-radius: 50% !important;
            border: 3px solid #475569 !important;
            background: #0f172a !important;
            box-sizing: border-box !important;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .candidate-image:hover {
            border-color: #3b82f6 !important;
            transform: scale(1.07);
        }

        .candidate-action-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            white-space: nowrap;
        }

        .candidate-edit-button,
        .candidate-delete-button {
            display: inline-flex !important;
            align-items: center;
            justify-content: center;
            min-width: 58px;
            padding: 8px 11px !important;
            border-radius: 8px !important;
            font-size: 12px !important;
            font-weight: 700 !important;
            text-decoration: none !important;
            box-sizing: border-box;
        }

        .candidate-edit-button {
            background: rgba(59, 130, 246, 0.14) !important;
            color: #60a5fa !important;
            border: 1px solid rgba(59, 130, 246, 0.35) !important;
        }

        .candidate-edit-button:hover {
            background: rgba(59, 130, 246, 0.25) !important;
        }

        .candidate-delete-button {
            background: rgba(239, 68, 68, 0.13) !important;
            color: #f87171 !important;
            border: 1px solid rgba(239, 68, 68, 0.30) !important;
        }

        .candidate-delete-button:hover {
            background: rgba(239, 68, 68, 0.24) !important;
        }

        .candidate-table-container::-webkit-scrollbar {
            height: 8px;
        }

        .candidate-table-container::-webkit-scrollbar-track {
            background: #0f172a;
            border-radius: 10px;
        }

        .candidate-table-container::-webkit-scrollbar-thumb {
            background: #475569;
            border-radius: 10px;
        }

        .candidate-table-container::-webkit-scrollbar-thumb:hover {
            background: #64748b;
        }

        @media (max-width: 800px) {

            .candidate-page {
                padding: 20px 12px 35px;
            }

            .candidate-card,
            .candidate-table-card {
                padding: 20px;
                border-radius: 14px;
            }

            .candidate-form {
                grid-template-columns: 1fr;
                gap: 17px;
            }

            .candidate-save-button {
                width: 100% !important;
            }

            .candidate-card-title {
                font-size: 21px;
            }

            .candidate-table {
                min-width: 1100px !important;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="candidate-page">

        <div class="candidate-layout">

            <article class="candidate-card">

                <h2 class="candidate-card-title">
                    Candidate Registration
                </h2>

                <div class="candidate-form">

                    <div class="candidate-form-group">
                        <label>Candidate Name</label>

                        <asp:TextBox
                            ID="txtusername"
                            runat="server"
                            CssClass="candidate-input"
                            placeholder="Enter candidate full name">
                        </asp:TextBox>
                    </div>

                    <div class="candidate-form-group">
                        <label>Election Type</label>

                        <asp:DropDownList
                            ID="ddlElectionType"
                            runat="server"
                            CssClass="candidate-input">

                            <asp:ListItem Value="">Select Election Type</asp:ListItem>
                            <asp:ListItem Value="Lok Sabha">Lok Sabha</asp:ListItem>
                            <asp:ListItem Value="Vidhan Sabha">Vidhan Sabha</asp:ListItem>
                            <asp:ListItem Value="Rajya Sabha">Rajya Sabha</asp:ListItem>
                            <asp:ListItem Value="Vidhan Parishad">Vidhan Parishad</asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <div class="candidate-form-group">
                        <label>State / Union Territory</label>

                        <asp:DropDownList
                            ID="ddlState"
                            runat="server"
                            CssClass="candidate-input">

                            <asp:ListItem Value="">Select State / UT</asp:ListItem>
                            <asp:ListItem>Andhra Pradesh</asp:ListItem>
                            <asp:ListItem>Arunachal Pradesh</asp:ListItem>
                            <asp:ListItem>Assam</asp:ListItem>
                            <asp:ListItem>Bihar</asp:ListItem>
                            <asp:ListItem>Chhattisgarh</asp:ListItem>
                            <asp:ListItem>Goa</asp:ListItem>
                            <asp:ListItem>Gujarat</asp:ListItem>
                            <asp:ListItem>Haryana</asp:ListItem>
                            <asp:ListItem>Himachal Pradesh</asp:ListItem>
                            <asp:ListItem>Jharkhand</asp:ListItem>
                            <asp:ListItem>Karnataka</asp:ListItem>
                            <asp:ListItem>Kerala</asp:ListItem>
                            <asp:ListItem>Madhya Pradesh</asp:ListItem>
                            <asp:ListItem>Maharashtra</asp:ListItem>
                            <asp:ListItem>Manipur</asp:ListItem>
                            <asp:ListItem>Meghalaya</asp:ListItem>
                            <asp:ListItem>Mizoram</asp:ListItem>
                            <asp:ListItem>Nagaland</asp:ListItem>
                            <asp:ListItem>Odisha</asp:ListItem>
                            <asp:ListItem>Punjab</asp:ListItem>
                            <asp:ListItem>Rajasthan</asp:ListItem>
                            <asp:ListItem>Sikkim</asp:ListItem>
                            <asp:ListItem>Tamil Nadu</asp:ListItem>
                            <asp:ListItem>Telangana</asp:ListItem>
                            <asp:ListItem>Tripura</asp:ListItem>
                            <asp:ListItem>Uttar Pradesh</asp:ListItem>
                            <asp:ListItem>Uttarakhand</asp:ListItem>
                            <asp:ListItem>West Bengal</asp:ListItem>
                            <asp:ListItem>Andaman and Nicobar Islands</asp:ListItem>
                            <asp:ListItem>Chandigarh</asp:ListItem>
                            <asp:ListItem>Dadra and Nagar Haveli and Daman and Diu</asp:ListItem>
                            <asp:ListItem>Delhi</asp:ListItem>
                            <asp:ListItem>Jammu and Kashmir</asp:ListItem>
                            <asp:ListItem>Ladakh</asp:ListItem>
                            <asp:ListItem>Lakshadweep</asp:ListItem>
                            <asp:ListItem>Puducherry</asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <div class="candidate-form-group">
                        <label>Constituency</label>

                        <asp:TextBox
                            ID="txtConstituency"
                            runat="server"
                            CssClass="candidate-input"
                            placeholder="Enter constituency">
                        </asp:TextBox>
                    </div>

                    <div class="candidate-form-group">
                        <label>Political Party</label>

                        <asp:DropDownList
                            ID="ddlParty"
                            runat="server"
                            CssClass="candidate-input">

                            <asp:ListItem Value="">Select Political Party</asp:ListItem>
                            <asp:ListItem Value="BJP">Bharatiya Janata Party (BJP)</asp:ListItem>
                            <asp:ListItem Value="INC">Indian National Congress (INC)</asp:ListItem>
                            <asp:ListItem Value="AAP">Aam Aadmi Party (AAP)</asp:ListItem>
                            <asp:ListItem Value="BSP">Bahujan Samaj Party (BSP)</asp:ListItem>
                            <asp:ListItem Value="CPI">Communist Party of India (CPI)</asp:ListItem>
                            <asp:ListItem Value="CPI(M)">Communist Party of India (Marxist)</asp:ListItem>
                            <asp:ListItem Value="TMC">All India Trinamool Congress (TMC)</asp:ListItem>
                            <asp:ListItem Value="NCP">Nationalist Congress Party (NCP)</asp:ListItem>
                            <asp:ListItem Value="DMK">Dravida Munnetra Kazhagam (DMK)</asp:ListItem>
                            <asp:ListItem Value="AIADMK">All India Anna Dravida Munnetra Kazhagam</asp:ListItem>
                            <asp:ListItem Value="TDP">Telugu Desam Party (TDP)</asp:ListItem>
                            <asp:ListItem Value="BJD">Biju Janata Dal (BJD)</asp:ListItem>
                            <asp:ListItem Value="SP">Samajwadi Party (SP)</asp:ListItem>
                            <asp:ListItem Value="RJD">Rashtriya Janata Dal (RJD)</asp:ListItem>
                            <asp:ListItem Value="JD(U)">Janata Dal (United)</asp:ListItem>
                            <asp:ListItem Value="SHS">Shiv Sena (SHS)</asp:ListItem>
                            <asp:ListItem Value="Independent">Independent</asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <div class="candidate-form-group">
                        <label>Candidate Profile Image</label>

                        <asp:FileUpload
                            ID="imgupload"
                            runat="server"
                            CssClass="candidate-file">
                        </asp:FileUpload>
                    </div>

                    <div class="candidate-form-group">
                        <label>Manifesto / Candidate Bio</label>

                        <asp:TextBox
                            ID="txtaddress"
                            runat="server"
                            TextMode="MultiLine"
                            Rows="4"
                            CssClass="candidate-input"
                            placeholder="Enter candidate manifesto or biography">
                        </asp:TextBox>
                    </div>

                    <asp:Button
                        ID="Save_btn"
                        runat="server"
                        Text="Register Candidate"
                        CssClass="candidate-save-button"
                        OnClick="Save_btn_Click" />

                </div>

            </article>


            <article class="candidate-table-card">

                <h2 class="candidate-card-title">
                    Candidate Roster
                </h2>

                <div class="candidate-table-container">

                    <asp:GridView
                        ID="GridView1"
                        runat="server"
                        AutoGenerateColumns="False"
                        DataKeyNames="CandidateId"
                        OnRowCommand="GridView1_RowCommand"
                        CssClass="candidate-table"
                        GridLines="None"
                        Width="100%">

                        <Columns>

                            <asp:BoundField
                                DataField="CandidateId"
                                HeaderText="ID" />

                            <asp:BoundField
                                DataField="Name"
                                HeaderText="Candidate" />

                            <asp:BoundField
                                DataField="ElectionType"
                                HeaderText="Election" />

                            <asp:BoundField
                                DataField="State"
                                HeaderText="State / UT" />

                            <asp:BoundField
                                DataField="Constituency"
                                HeaderText="Constituency" />

                            <asp:BoundField
                                DataField="Party"
                                HeaderText="Party" />

                            <asp:TemplateField HeaderText="Profile">

                                <ItemTemplate>

                                    <div class="candidate-image-container">

                                        <asp:Image
                                            ID="imgCandidate"
                                            runat="server"
                                            ImageUrl='<%# Page.ResolveUrl(Eval("ImagePath").ToString()) %>'
                                            CssClass="candidate-image"
                                            AlternateText="Candidate Profile" />

                                    </div>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">

                                <ItemTemplate>

                                    <div class="candidate-action-container">

                                        <asp:LinkButton
                                            ID="btnEdit"
                                            runat="server"
                                            CommandName="cmd_edt"
                                            CommandArgument='<%# Eval("CandidateId") %>'
                                            Text="Edit"
                                            CssClass="candidate-edit-button">
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnDelete"
                                            runat="server"
                                            CommandName="cmd_del"
                                            CommandArgument='<%# Eval("CandidateId") %>'
                                            Text="Delete"
                                            CssClass="candidate-delete-button"
                                            OnClientClick="return confirm('Are you sure you want to delete this candidate?');">
                                        </asp:LinkButton>

                                    </div>

                                </ItemTemplate>

                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>

            </article>

        </div>

    </div>

</asp:Content>