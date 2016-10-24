<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MvpResults.aspx.cs" Inherits="RPFS_AllstarTracker.MvpResults" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="gvVotes" runat="server" AllowSorting="true" OnSorting="gvVotes_Sorting"></asp:GridView>
</asp:Content>
