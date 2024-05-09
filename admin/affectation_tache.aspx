﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="affectation_tache.aspx.cs" Inherits="gestiontaches.affectation_tache" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion des tâches - Admin</title>
    <!-- Inclusion du fichier CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
    <style>body{background-color:#f8f9fa;font-family:Arial,sans-serif;}table{width:100%;border-collapse:collapse;border:2px solid #ddd;}th{background-color:#f2f2f2;border:1px solid #ddd;padding:8px;text-align:left;}td{border:1px solid #ddd;padding:8px;}tr:nth-child(odd){background-color:#f9f9f9;}.sidebar{background-color:#343a40;color:#fff;position:fixed;height:100%;overflow-y:auto;z-index:1;padding-top:20px;width:250px;}.container-main{margin-left:250px;padding:20px;}.box{background-color:#007bff;color:#fff;padding:20px;border-radius:10px;box-shadow:0 0 20px rgba(0,0,0,.1);margin-bottom:20px;}.card{margin-bottom:20px;}.card img{width:100px;height:100px;border-radius:50%;margin-bottom:10px;}.btn-danger{margin-bottom:0;}</style>

</head>
<body>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 sidebar">
                <nav class="navbar navbar-dark">
                    <ul class="navbar-nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="admin.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#home"></use></svg>
                                Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="utilisateur.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"></use></svg>
                                UTILISATEUR
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="tache.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"></use></svg>
                                TACHES
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="affectation_tache.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#grid"></use></svg>
                                AFFECTATION TACHE
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="rapport.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#people-circle"></use></svg>
                                RAPPORT
                            </a>
                        </li>                        <li class="nav-item" style="margin-top:300px">
    <a class="nav-link" href="/Default.aspx">
        <svg class="bi me-2" width="16" height="16"><use xlink:href="#power"></use></svg>
        Déconnexion
    </a>
</li>
                    </ul>
                </nav>
            </div>
            <div class="col-md-9 container-main">
                <h1>Affectation Des Tâches - Admin</h1>
                <div class="container">
                    <form id="form1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                
                   <h4 style="color:crimson;margin-right:70px">Affectation de Tâches</h4>
<div class="form-group">
    <label for="ddlTachee">Sélectionner une Tâche :</label>
    <asp:DropDownList ID="ddlTache" runat="server" CssClass="form-control"></asp:DropDownList>
</div>
<div class="form-group">
    <label for="ddlUtilisateure">Sélectionner un Utilisateur :</label>
    <asp:DropDownList ID="ddlUtilisateur" runat="server" CssClass="form-control"></asp:DropDownList>
</div>
<div class="form-group">
    <asp:Button ID="btnAffecterTache" runat="server" Text="Affecter la Tâche" CssClass="btn btn-primary" OnClick="btnAffecterTache_Click" />
</div>
            
                
            </div>
            <div class="col-md-6 grid-view" id="DivToPrint" runat="server">
                    <h5 style="color:crimson;margin-left:250px; width: 230px;">TOUS LES TACHES</h5>
    <asp:GridView ID="GridView1" CssClass="custom-table" runat="server" AutoGenerateDeleteButton="True" CellPadding="4" OnRowDeleting="GridView1_RowDeleting" Width="675px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" Height="16px" style="margin-right: 0px">
        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
        <RowStyle BackColor="White" ForeColor="#003399" />
        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        <SortedAscendingCellStyle BackColor="#EDF6F6" />
        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
        <SortedDescendingCellStyle BackColor="#D6DFDF" />
        <SortedDescendingHeaderStyle BackColor="#002876" />
    </asp:GridView>

<h5 style="color:crimson; margin-left:250px; width: 222px;">LES TACHES FINIS</h5>
<asp:GridView ID="GridView2" CssClass="custom-table" runat="server" CellPadding="4" Width="677px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" Height="16px" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
    <RowStyle BackColor="White" ForeColor="#003399" />
    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    <SortedAscendingCellStyle BackColor="#EDF6F6" />
    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
    <SortedDescendingCellStyle BackColor="#D6DFDF" />
    <SortedDescendingHeaderStyle BackColor="#002876" />
</asp:GridView>
<h5 style="color:crimson;margin-left:250px; width: 361px;">LES TACHES ENCORE PAS FINI</h5>
<asp:GridView ID="GridView3" CssClass="custom-table" runat="server" CellPadding="4" Width="679px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" Height="16px" OnSelectedIndexChanged="GridView3_SelectedIndexChanged">
    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
    <RowStyle BackColor="White" ForeColor="#003399" />
    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    <SortedAscendingCellStyle BackColor="#EDF6F6" />
    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
    <SortedDescendingCellStyle BackColor="#D6DFDF" />
    <SortedDescendingHeaderStyle BackColor="#002876" />
</asp:GridView>
            </div>
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
    </div>
        </div>
    </form>
        </div>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
