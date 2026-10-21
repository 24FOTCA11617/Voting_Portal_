<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Voting_Portal_.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .admin-dashboard {
            width: 100%;
            max-width: 1450px;
            margin: 0 auto;
            padding: 30px 25px 50px;
            box-sizing: border-box;
        }

        .admin-header {
            margin-bottom: 28px;
        }

        .admin-header h1 {
            margin: 0;
            color: #f8fafc;
            font-family: Arial, sans-serif;
            font-size: 34px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .admin-header p {
            margin: 9px 0 0;
            color: #94a3b8;
            font-family: Arial, sans-serif;
            font-size: 15px;
            line-height: 1.6;
        }

        .admin-header-line {
            width: 65px;
            height: 4px;
            margin-top: 16px;
            border-radius: 10px;
            background: linear-gradient(90deg, #f97316, #3b82f6);
        }

        .dashboard-metrics {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 20px;
            width: 100%;
            margin-bottom: 25px;
        }

        .metric-card {
            position: relative;
            min-height: 145px;
            padding: 23px;
            box-sizing: border-box;
            overflow: hidden;
            border: 1px solid #334155;
            border-radius: 16px;
            background: linear-gradient(145deg, #1e293b, #172033);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.20);
            transition: all 0.25s ease;
        }

        .metric-card:hover {
            transform: translateY(-3px);
            border-color: #475569;
            box-shadow: 0 16px 35px rgba(0, 0, 0, 0.28);
        }

        .metric-card::after {
            content: "";
            position: absolute;
            right: -25px;
            bottom: -35px;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: rgba(59, 130, 246, 0.08);
        }

        .metric-card.orange::after {
            background: rgba(249, 115, 22, 0.10);
        }

        .metric-card.green::after {
            background: rgba(34, 197, 94, 0.10);
        }

        .metric-card.blue::after {
            background: rgba(59, 130, 246, 0.10);
        }

        .metric-card.purple::after {
            background: rgba(168, 85, 247, 0.10);
        }

        .metric-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            margin-bottom: 15px;
            border-radius: 11px;
            background: #0f172a;
            border: 1px solid #334155;
            font-size: 19px;
        }

        .metric-title {
            display: block;
            margin-bottom: 8px;
            color: #94a3b8;
            font-family: Arial, sans-serif;
            font-size: 13px;
            font-weight: 600;
        }

        .metric-value {
            display: block;
            color: #f8fafc;
            font-family: Arial, sans-serif;
            font-size: 28px;
            font-weight: 700;
            line-height: 1.2;
        }

        .metric-description {
            display: block;
            margin-top: 7px;
            color: #64748b;
            font-family: Arial, sans-serif;
            font-size: 11px;
        }

        .admin-main-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.55fr) minmax(300px, 0.8fr);
            gap: 22px;
            width: 100%;
            margin-bottom: 25px;
        }

        .admin-card {
            width: 100%;
            box-sizing: border-box;
            padding: 25px;
            border: 1px solid #334155;
            border-radius: 17px;
            background: #172033;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.20);
        }

        .admin-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 1px solid #334155;
        }

        .admin-card-title {
            margin: 0;
            color: #f8fafc;
            font-family: Arial, sans-serif;
            font-size: 21px;
            font-weight: 700;
        }

        .admin-card-subtitle {
            margin: 5px 0 0;
            color: #64748b;
            font-family: Arial, sans-serif;
            font-size: 12px;
        }

        .overview-list {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .overview-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            padding: 16px 5px;
            border-bottom: 1px solid #26364d;
        }

        .overview-row:last-child {
            border-bottom: none;
        }

        .overview-label {
            color: #94a3b8;
            font-family: Arial, sans-serif;
            font-size: 13px;
        }

        .overview-value {
            color: #f8fafc;
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: 700;
            text-align: right;
        }

        .leader-card {
            position: relative;
            overflow: hidden;
        }

        .leader-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 22px;
        }

        .leader-label {
            color: #94a3b8;
            font-family: Arial, sans-serif;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.7px;
        }

        .leader-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: rgba(249, 115, 22, 0.12);
            border: 1px solid rgba(249, 115, 22, 0.3);
            font-size: 18px;
        }

        .leader-name {
            margin: 0;
            color: #f8fafc;
            font-family: Arial, sans-serif;
            font-size: 26px;
            font-weight: 700;
            line-height: 1.3;
        }

        .leader-votes {
            margin-top: 8px;
            color: #60a5fa;
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: 600;
        }

        .leader-progress {
            width: 100%;
            height: 8px;
            margin-top: 22px;
            overflow: hidden;
            border-radius: 20px;
            background: #0f172a;
        }

        .leader-progress-fill {
            width: 65%;
            height: 100%;
            border-radius: 20px;
            background: linear-gradient(90deg, #f97316, #f59e0b);
        }

        .leader-note {
            margin-top: 12px;
            color: #64748b;
            font-family: Arial, sans-serif;
            font-size: 11px;
        }

        .admin-tools-card {
            margin-bottom: 25px;
        }

        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .admin-action-button {
            min-height: 45px;
            padding: 0 18px !important;
            border-radius: 9px !important;
            border: 1px solid transparent !important;
            font-family: Arial, sans-serif !important;
            font-size: 13px !important;
            font-weight: 700 !important;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .admin-export-button {
            background: #334155 !important;
            color: #f8fafc !important;
            border-color: #475569 !important;
        }

        .admin-export-button:hover {
            background: #475569 !important;
            transform: translateY(-1px);
        }

        .admin-reset-button {
            background: #dc2626 !important;
            color: #ffffff !important;
            border-color: #ef4444 !important;
        }

        .admin-reset-button:hover {
            background: #ef4444 !important;
            transform: translateY(-1px);
        }

        .audit-card {
            width: 100%;
            box-sizing: border-box;
            padding: 25px;
            border: 1px solid #334155;
            border-radius: 17px;
            background: #172033;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.20);
        }

        .audit-table-container {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #334155;
            border-radius: 13px;
            background: #1e293b;
        }

        .audit-grid {
            width: 100% !important;
            min-width: 650px;
            border-collapse: collapse !important;
            border-spacing: 0 !important;
            color: #e2e8f0;
            font-family: Arial, sans-serif;
            font-size: 13px;
        }

        .audit-grid th {
            padding: 15px 14px !important;
            background: #111c30 !important;
            color: #f8fafc !important;
            border: none !important;
            border-bottom: 2px solid #334155 !important;
            font-size: 11px !important;
            font-weight: 700 !important;
            text-align: left !important;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        .audit-grid td {
            padding: 15px 14px !important;
            background: #1e293b !important;
            color: #cbd5e1 !important;
            border: none !important;
            border-bottom: 1px solid #334155 !important;
            vertical-align: middle !important;
        }

        .audit-grid tr:hover td {
            background: #27364d !important;
        }

        .audit-grid tr:last-child td {
            border-bottom: none !important;
        }

        .audit-grid td:first-child {
            color: #60a5fa !important;
            font-weight: 700 !important;
        }

        .audit-grid td:nth-child(3) {
            color: #f8fafc !important;
            font-weight: 600 !important;
        }

        .audit-grid td:last-child {
            color: #94a3b8 !important;
            white-space: nowrap;
        }

        .audit-empty {
            padding: 30px;
            color: #64748b;
            text-align: center;
            font-family: Arial, sans-serif;
            font-size: 13px;
        }

        .dashboard-footer-note {
            display: flex;
            align-items: center;
            gap: 9px;
            margin-top: 18px;
            color: #64748b;
            font-family: Arial, sans-serif;
            font-size: 11px;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #22c55e;
            box-shadow: 0 0 0 4px rgba(34, 197, 94, 0.10);
        }

        @media (max-width: 1050px) {

            .dashboard-metrics {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .admin-main-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 700px) {

            .admin-dashboard {
                padding: 20px 12px 35px;
            }

            .admin-header h1 {
                font-size: 27px;
            }

            .admin-header p {
                font-size: 13px;
            }

            .dashboard-metrics {
                grid-template-columns: 1fr;
            }

            .admin-card,
            .audit-card {
                padding: 20px;
                border-radius: 14px;
            }

            .metric-card {
                min-height: 130px;
            }

            .admin-card-title {
                font-size: 19px;
            }

            .leader-name {
                font-size: 22px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .admin-action-button {
                width: 100%;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-dashboard">

        <div class="admin-header">

            <h1>Admin Control Panel</h1>

            <p>
                Monitor election activity, voter participation, candidate performance
                and system audit information.
            </p>

            <div class="admin-header-line"></div>

        </div>


        <div class="dashboard-metrics">

            <div class="metric-card blue">

                <div class="metric-icon">👥</div>

                <span class="metric-title">
                    Registered Voters
                </span>

                <span class="metric-value">
                    <asp:Label ID="lblRegisteredVoters" runat="server" Text="0" />
                </span>

                <span class="metric-description">
                    Total voters registered in the system
                </span>

            </div>


            <div class="metric-card green">

                <div class="metric-icon">🗳️</div>

                <span class="metric-title">
                    Total Votes
                </span>

                <span class="metric-value">
                    <asp:Label ID="lblTotalVotes" runat="server" Text="0" />
                </span>

                <span class="metric-description">
                    Votes currently recorded
                </span>

            </div>


            <div class="metric-card orange">

                <div class="metric-icon">👤</div>

                <span class="metric-title">
                    Candidates
                </span>

                <span class="metric-value">
                    <asp:Label ID="lblCandidates" runat="server" Text="0" />
                </span>

                <span class="metric-description">
                    Candidates registered for election
                </span>

            </div>


            <div class="metric-card purple">

                <div class="metric-icon">📊</div>

                <span class="metric-title">
                    Voter Turnout
                </span>

                <span class="metric-value">
                    <asp:Label ID="lblTurnout" runat="server" Text="0%" />
                </span>

                <span class="metric-description">
                    Percentage of registered voters who voted
                </span>

            </div>

        </div>


        <div class="admin-main-grid">

            <article class="admin-card">

                <div class="admin-card-header">

                    <div>
                        <h2 class="admin-card-title">
                            Election Overview
                        </h2>

                        <p class="admin-card-subtitle">
                            Current voting statistics
                        </p>
                    </div>

                </div>


                <div class="overview-list">

                    <div class="overview-row">

                        <span class="overview-label">
                            Registered Voters
                        </span>

                        <span class="overview-value">
                            <asp:Label ID="lblOverviewVoters" runat="server" Text="0" />
                        </span>

                    </div>


                    <div class="overview-row">

                        <span class="overview-label">
                            Votes Cast
                        </span>

                        <span class="overview-value">
                            <asp:Label ID="lblOverviewVotes" runat="server" Text="0" />
                        </span>

                    </div>


                    <div class="overview-row">

                        <span class="overview-label">
                            Remaining Voters
                        </span>

                        <span class="overview-value">
                            <asp:Label ID="lblRemainingVoters" runat="server" Text="0" />
                        </span>

                    </div>


                    <div class="overview-row">

                        <span class="overview-label">
                            Registered Candidates
                        </span>

                        <span class="overview-value">
                            <asp:Label ID="lblOverviewCandidates" runat="server" Text="0" />
                        </span>

                    </div>


                    <div class="overview-row">

                        <span class="overview-label">
                            Latest Activity
                        </span>

                        <span class="overview-value">
                            <asp:Label ID="lblLastActivity" runat="server" Text="No activity" />
                        </span>

                    </div>

                </div>

            </article>


            <article class="admin-card leader-card">

                <div class="leader-top">

                    <span class="leader-label">
                        Leading Contender
                    </span>

                    <div class="leader-icon">
                        🏆
                    </div>

                </div>

                <h2 class="leader-name">
                    <asp:Label ID="lblLeader" runat="server" Text="--" />
                </h2>

                <div class="leader-votes">

                    <asp:Label ID="lblLeaderVotes" runat="server" Text="0 votes" />

                </div>

                <div class="leader-progress">

                    <div class="leader-progress-fill"></div>

                </div>

                <div class="leader-note">
                    Current leading candidate based on recorded vote count.
                </div>

            </article>

        </div>


        <article class="admin-card admin-tools-card">

            <div class="admin-card-header">

                <div>

                    <h2 class="admin-card-title">
                        Administration Tools
                    </h2>

                    <p class="admin-card-subtitle">
                        Manage election records and system audit information
                    </p>

                </div>

            </div>


            <div class="action-buttons">

                <asp:Button
                    ID="btnExport"
                    runat="server"
                    Text="📥 Export Audit Log (CSV)"
                    CssClass="admin-action-button admin-export-button"
                    OnClick="btnExport_Click" />


                <asp:Button
                    ID="btnReset"
                    runat="server"
                    Text="⚠️ Emergency Reset Polls"
                    CssClass="admin-action-button admin-reset-button"
                    OnClick="btnReset_Click"
                    OnClientClick="return confirm('WARNING: This will reset all vote counts, voter voting status and audit logs. Continue?');" />

            </div>

        </article>


        <article class="audit-card">

            <div class="admin-card-header">

                <div>

                    <h2 class="admin-card-title">
                        Audit Log Stream
                    </h2>

                    <p class="admin-card-subtitle">
                        Recent voter activity and recorded candidate selections
                    </p>

                </div>

            </div>


            <div class="audit-table-container">

                <asp:GridView
                    ID="gvLogs"
                    runat="server"
                    CssClass="audit-grid"
                    Width="100%"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    EmptyDataText="No voting activity has been recorded yet.">

                    <Columns>

                        <asp:BoundField
                            DataField="LogId"
                            HeaderText="LOG ID" />

                        <asp:BoundField
                            DataField="EpicId"
                            HeaderText="EPIC ID" />

                        <asp:BoundField
                            DataField="VotedCandidate"
                            HeaderText="VOTED CANDIDATE" />

                        <asp:BoundField
                            DataField="Timestamp"
                            HeaderText="TIMESTAMP"
                            DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />

                    </Columns>

                    <EmptyDataRowStyle CssClass="audit-empty" />

                </asp:GridView>

            </div>


            <div class="dashboard-footer-note">

                <span class="status-dot"></span>

                <span>
                    Election monitoring system is active
                </span>

            </div>

        </article>

    </div>

</asp:Content>