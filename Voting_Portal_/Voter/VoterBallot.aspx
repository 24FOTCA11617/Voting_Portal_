<%@ Page Title="Official Digital Ballot" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VoterBallot.aspx.cs" Inherits="Voting_Portal_.Voter.VoterBallot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <style type="text/css">
        .ballot-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 15px;
        }

        /* Page Header */
        .section-header {
            margin-bottom: 25px;
        }
        .section-header h1 {
            font-size: 2.2rem !important;
            font-weight: 800 !important;
            color: #ffffff !important;
            margin: 0 0 6px 0 !important;
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }
        .section-header p {
            font-size: 0.98rem !important;
            color: #94a3b8 !important;
            margin: 0 !important;
        }

        /* EPIC Verification Box */
        .voter-card {
            background: rgba(18, 27, 44, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 14px;
            padding: 20px 24px;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.35);
        }
        .voter-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .voter-card-header label {
            font-size: 0.95rem;
            font-weight: 600;
            color: #cbd5e1;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .voter-status {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
            font-size: 0.78rem;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        .input-group {
            display: flex;
            gap: 12px;
        }
        .input-group input[type="text"] {
            flex: 1;
            background: #0d1527;
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 8px;
            padding: 12px 16px;
            color: #ffffff;
            font-size: 0.95rem;
            outline: none;
            transition: border-color 0.2s;
        }
        .input-group input[type="text"]:focus {
            border-color: #3b82f6;
        }
        .btn-secondary {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 0 24px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-secondary:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
        }

        /* Protocol Banner */
        .protocol-banner {
            background: rgba(30, 58, 138, 0.25);
            border-left: 4px solid #3b82f6;
            border-radius: 8px;
            padding: 12px 18px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #93c5fd;
            font-size: 0.88rem;
        }

        /* Candidates Grid */
        .candidates-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 35px;
        }
        .candidate-card {
            background: rgba(18, 27, 44, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.25s ease;
            display: flex;
            flex-direction: column;
        }
        .candidate-card:hover {
            transform: translateY(-5px);
            border-color: rgba(59, 130, 246, 0.4);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4);
        }
        
        .candidate-avatar-container {
            width: 100%;
            height: 200px;
            background: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
            box-sizing: border-box;
        }
        .candidate-avatar {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .candidate-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .candidate-info h3 {
            font-size: 1.2rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0 0 4px 0;
        }
        .candidate-party {
            font-size: 0.88rem;
            color: #38bdf8;
            font-weight: 600;
            display: block;
            margin-bottom: 10px;
        }
        .candidate-bio {
            font-size: 0.85rem;
            color: #94a3b8;
            line-height: 1.4;
            margin: 0 0 18px 0;
        }
        /* Container styling with modern rounded badge look */
.candidate-avatar-container {
    width: 100%;
    height: 180px;
    background: rgba(13, 21, 39, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 15px;
    box-sizing: border-box;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

/* Forces image to scale smoothly without dark side bars */
.candidate-avatar {
    max-width: 130px;
    max-height: 130px;
    width: 100%;
    height: auto;
    object-fit: contain;
    border-radius: 50%;
    background: #ffffff;
    padding: 8px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
}

        /* Voting Button */
        .btn-primary {
            background: linear-gradient(135deg, #10b981, #059669);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 12px 20px;
            font-size: 0.95rem;
            font-weight: 700;
            cursor: pointer;
            width: 100%;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.25);
            transition: all 0.2s;
        }
        .btn-primary:hover:not(:disabled) {
            background: linear-gradient(135deg, #059669, #047857);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.35);
        }
        .btn-primary:disabled {
            background: #334155;
            color: #64748b;
            cursor: not-allowed;
            box-shadow: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ballot-container">
        
        <!-- Header -->
        <div class="section-header">
            <h1>Official Digital Ballot</h1>
            <p>Verify EPIC Identity and cast a single vote securely.</p>
        </div>

        <!-- EPIC Verification Box -->
        <div class="voter-card">
            <div class="voter-card-header">
                <label><i class="fa-solid fa-id-card"></i> Verify EPIC Identification Number</label>
                <asp:Label ID="lblStatus" runat="server" CssClass="voter-status" Text="Unverified" />
            </div>
            <div class="input-group">
                <asp:TextBox ID="txtepic" runat="server" placeholder="e.g. IND-892104" />
                <asp:Button ID="btnVerify" runat="server" Text="Verify ID" CssClass="btn btn-secondary" OnClick="btnVerify_Click" />
            </div>
        </div>

        <!-- Security Protocol Banner -->
        <div class="protocol-banner">
            <i class="fa-solid fa-shield-halved"></i>
            <span><strong>Encrypted Ballot Protocol:</strong> Verification is required to enable voting action on candidate options below.</span>
        </div>

        <!-- Candidates Repeater Grid -->
        <asp:Repeater ID="rptCandidates" runat="server" OnItemCommand="rptCandidates_ItemCommand">
            <HeaderTemplate>
                <div class="candidates-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <article class="candidate-card">
                    <div class="candidate-avatar-container">
                        <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("Name") %>' class="candidate-avatar" />
                    </div>
                    <div class="candidate-info">
                        <div>
                            <h3><%# Eval("Name") %></h3>
                            <span class="candidate-party"><%# Eval("Party") %></span>
                            <p class="candidate-bio"><%# Eval("Bio") %></p>
                        </div>
                        <asp:Button ID="btnVote" runat="server" CommandName="cast_vote" CommandArgument='<%# Eval("CandidateId") %>' Text="Vote Leader" CssClass="btn btn-primary" Enabled='<%# Convert.ToBoolean(Session["IsVerified"] ?? false) %>' />
                    </div>
                </article>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>