<%@ Page Title="Live Public Portal Hub" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Voting_Portal_.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <style type="text/css">
        
        .portal-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 20px 10px;
        }

        .section-header {
            margin-bottom: 30px;
        }

        .portal-title {
            font-size: 2.2rem !important;
            font-weight: 800 !important;
            letter-spacing: 0.05em !important;
            color: #ffffff !important;
            margin: 0 0 6px 0 !important;
            text-transform: uppercase !important;
        }

        .portal-subtitle {
            font-size: 1rem !important;
            color: #94a3b8 !important;
            margin: 0 !important;
        }

        /* Dashboard Cards Grid */
        .dashboard-metrics {
            display: grid !important;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)) !important;
            gap: 24px !important;
        }

        /* Metric Card Base */
        .metric-card {
            position: relative !important;
            background: #121c2d !important;
            border-radius: 16px !important;
            padding: 24px !important;
            border: 1px solid rgba(255, 255, 255, 0.08) !important;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35) !important;
            overflow: hidden !important;
            transition: transform 0.2s ease, box-shadow 0.2s ease !important;
        }

        .metric-card:hover {
            transform: translateY(-3px) !important;
            box-shadow: 0 14px 35px rgba(0, 0, 0, 0.45) !important;
        }

        /* Left Accent Lines */
        .metric-card::before {
            content: '' !important;
            position: absolute !important;
            left: 0 !important;
            top: 15% !important;
            bottom: 15% !important;
            width: 4px !important;
            border-radius: 0 4px 4px 0 !important;
        }

        .card-teal::before { background: linear-gradient(180deg, #10b981 0%, #06b6d4 100%) !important; }
        .card-orange::before { background: linear-gradient(180deg, #f59e0b 0%, #ef4444 100%) !important; }
        .card-purple::before { background: linear-gradient(180deg, #06b6d4 0%, #8b5cf6 100%) !important; }

        /* Inner Card Content */
        .card-header-flex {
            display: flex !important;
            justify-content: space-between !important;
            align-items: center !important;
            margin-bottom: 20px !important;
        }

        .metric-title {
            font-size: 1rem !important;
            font-weight: 500 !important;
            color: #cbd5e1 !important;
        }

        /* Icons */
        .card-icon-box {
            width: 44px !important;
            height: 44px !important;
            border-radius: 12px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            font-size: 1.25rem !important;
        }

        .icon-teal { background: rgba(16, 185, 129, 0.15) !important; color: #34d399 !important; }
        .icon-orange { background: rgba(245, 158, 11, 0.15) !important; color: #fbbf24 !important; }
        .icon-purple { background: rgba(139, 92, 246, 0.15) !important; color: #c084fc !important; }

        /* Numbers */
        .metric-value-text {
            font-size: 3.5rem !important;
            font-weight: 700 !important;
            color: #ffffff !important;
            line-height: 1 !important;
            margin-bottom: 16px !important;
            display: block !important;
        }

        /* Trend Footer */
        .card-footer-flex {
            display: flex !important;
            align-items: center !important;
        }

        .trend-icon {
            color: #64748b !important;
            font-size: 1.1rem !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="portal-container">
        <!-- Section Header -->
        <div class="section-header">
            <h1 class="portal-title">LIVE PUBLIC PORTAL HUB</h1>
            <p class="portal-subtitle">Real-time Election Parameters & Analytics</p>
        </div>

        <!-- Dashboard Metrics Cards -->
        <div class="dashboard-metrics">
            
            <!-- Card 1: Registered Voters -->
            <div class="metric-card card-teal">
                <div class="card-header-flex">
                    <span class="metric-title">Total Registered Voters</span>
                    <div class="card-icon-box icon-teal">
                        <i class="fa-solid fa-user-check"></i>
                    </div>
                </div>
                <div class="metric-value-text">
                    <asp:Label ID="lblVoters" runat="server" Text="1" />
                </div>
                <div class="card-footer-flex">
                    <i class="fa-solid fa-arrow-trend-up trend-icon"></i>
                </div>
            </div>

            <!-- Card 2: Recorded Votes -->
            <div class="metric-card card-orange">
                <div class="card-header-flex">
                    <span class="metric-title">Total Votes Recorded</span>
                    <div class="card-icon-box icon-orange">
                        <i class="fa-solid fa-box-archive"></i>
                    </div>
                </div>
                <div class="metric-value-text">
                    <asp:Label ID="lblVotes" runat="server" Text="0" />
                </div>
                <div class="card-footer-flex">
                    <i class="fa-solid fa-arrow-trend-up trend-icon"></i>
                </div>
            </div>

            <!-- Card 3: Active Contenders -->
            <div class="metric-card card-purple">
                <div class="card-header-flex">
                    <span class="metric-title">Active Contenders</span>
                    <div class="card-icon-box icon-purple">
                        <i class="fa-solid fa-users"></i>
                    </div>
                </div>
                <div class="metric-value-text">
                    <asp:Label ID="lblCandidates" runat="server" Text="4" />
                </div>
                <div class="card-footer-flex">
                    <i class="fa-solid fa-arrow-trend-up trend-icon"></i>
                </div>
            </div>

        </div>
    </div>
</asp:Content>