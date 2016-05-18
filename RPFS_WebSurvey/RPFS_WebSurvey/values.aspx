<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="values.aspx.cs" Inherits="RPFS_WebSurvey.values" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Number of completed surveys:<asp:Label ID="lblCount" runat="server"></asp:Label>
        <asp:GridView ID="gvValues" runat="server"></asp:GridView>
        <br />
        <asp:GridView ID="gvPerValues" runat="server"></asp:GridView>
    </div>
    </form>
</body>
</html>
