<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="RPFS_ConsoleScheduler.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Console Scheduler</h1>


    </div>
    <div>
        <asp:Calendar ID="calPickup" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
            <WeekendDayStyle BackColor="#CCCCFF" />
        </asp:Calendar>
        <br />
        Pickup Time<asp:DropDownList ID="ddlPTimes" runat="server">
            <asp:ListItem Text="Morning" Value="0"></asp:ListItem>
            <asp:ListItem Text="Afternoon" Value="1"></asp:ListItem>
            <asp:ListItem Text="Evening" Value="2"></asp:ListItem>
            <asp:ListItem Text="After 11pm" Value="3"></asp:ListItem>
            </asp:DropDownList>
        <br />
        <asp:Calendar ID="calReturn" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
            <WeekendDayStyle BackColor="#CCCCFF" />
        </asp:Calendar>
        <br />
        Return Time<asp:DropDownList ID="ddlRTimes" runat="server">
            <asp:ListItem Text="Morning" Value="0"></asp:ListItem>
            <asp:ListItem Text="Afternoon" Value="1"></asp:ListItem>
            <asp:ListItem Text="Evening" Value="2"></asp:ListItem>
            <asp:ListItem Text="After 11pm" Value="3"></asp:ListItem>
            </asp:DropDownList>
        <br />
        <br />
        Total Days:&nbsp<asp:Label ID="lblTotalDays" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
