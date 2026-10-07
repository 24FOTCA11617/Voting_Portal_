<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Voting_Portal_.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="voter-card" style="max-width: 450px; margin: 2rem auto;">
        <h2>Role-Based Portal Login</h2>
        <div class="admin-form">
            <div class="form-group">
                <label>Select Identity Role</label>
                <asp:DropDownList ID="drpRole" runat="server">
                    <asp:ListItem Value="Voter">Voter (EPIC Login)</asp:ListItem>
                    <asp:ListItem Value="Admin">System Administrator</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Identifier / Username (EPIC ID or Admin)</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-control" Required="true" />
            </div>
            <div class="form-group">
                <label>Security Key / Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-control" />
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Access Portal" CssClass="btn btn-primary btn-block" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Style="display:block; margin-top:10px;" />
        </div>
    </div>
</asp:Content>
