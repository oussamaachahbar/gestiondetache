<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="etudiant.aspx.cs" Inherits="gestiontaches.etudiant.etudiant" EnableEventValidation="false" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion des tâches - Admin</title>
    <!-- Inclusion du fichier CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
            <style>body{background-color:#f8f9fa;font-family:Arial,sans-serif}.sidebar{background-color:black;color:#fff;position:fixed;height:100%;overflow-y:auto;z-index:1;padding-top:20px;width:250px;border-radius:10px}.container-main{margin-left:250px;padding:20px}.modal-body .form-group{margin-bottom:15px}.modal-header{background-color:#007bff;color:#fff;border-bottom:none}.modal-title{color:#fff}.modal-footer{border-top:none}.modal-header .close{color:#fff}.box{background-color:#007bff;color:#ffffff;padding:20px;border-radius:10px;box-shadow:0 0 20px rgba(0,0,0,0.1);margin-bottom:20px}.card{margin-bottom:20px}.card img{width:100px;height:100px;border-radius:50%;margin-bottom:10px}.btn-danger{margin-bottom:0px}table{width:100%;border-collapse:collapse;border:2px solid #ddd}th{background-color:#f2f2f2;border:1px solid #ddd;padding:8px;text-align:left}td{border:1px solid #ddd;padding:8px}tr:nth-child(odd){background-color:#f9f9f9}.nav-link{border-radius:5px;transition:background-color 0.3s}.nav-link:hover{background-color:#ffc107}.nav-icon{width:20px;height:auto;margin-right:10px}</style>

</head>
<body>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
                                               <div class="col-md-3 sidebar">
    <nav class="navbar navbar-dark">
        <ul class="navbar-nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href='<%= "Dashbord.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                    <img src="/img/home.png" alt="Home Icon" class="nav-icon"/> <!-- Image pour Home -->
                    Home
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%= "etudiant.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                    <img src="/img/afficon.png" alt="User Icon" class="nav-icon"/> <!-- Image pour Utilisateur -->
                    Taches Associer
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%= "tache_re_no.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                    <img src="/img/tacheicon.png" alt="Tasks Icon" class="nav-icon"/> <!-- Image pour Taches -->
                    Taches En Fait
                </a>
            </li>
           
            <li class="nav-item" style="margin-top:300px">
                <a class="nav-link" href="/Default.aspx">
                    <img src="/img/out.png" alt="Logout Icon" class="nav-icon"/> <!-- Image pour Déconnexion -->
                    Déconnexion
                </a>
            </li>
        </ul>
    </nav>
</div>

            <!-- Contenu principal -->
            <div class="col-md-9 container-main">
                <h1>Utilisateur - Admin</h1>
                <!-- Le contenu principal ici -->
                <div class="container">
                               <form id="form1" runat="server" class="container">
        
           <asp:GridView ID="GridView1" runat="server" CellPadding="4" Width="1225px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" Height="16px" >
    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
    <RowStyle BackColor="White" ForeColor="#003399" />
    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    <SortedAscendingCellStyle BackColor="#EDF6F6" />
    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
    <SortedDescendingCellStyle BackColor="#D6DFDF" />
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:CheckBox ID="chk" runat="server"  AutoPostBack="True" OnCheckedChanged="chk_CheckedChanged" CssClass="red-background" />
                <asp:CheckBox ID="chke" runat="server"  AutoPostBack="True" OnCheckedChanged="chk_CheckedChanged" CssClass="green-background" />

            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
               <SortedDescendingHeaderStyle BackColor="#002876" />
</asp:GridView>
        <div style="margin-top:10px">
            <asp:Button ID="Button1" runat="server" Text="Print" class="btn btn-danger" OnClick="Button1_Click" Width="133px"/>
        </div>
                                                                                          <div class="modal fade" id="modal-id" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Informations de l'utilisateur</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    
                                        <div class="form-group">
    <label for="idtaskass">TASK ASSIGNEMENT  ID</label>
    <input type="text" class="form-control" id="idtaskass" readonly>
</div>
<div class="form-group">
    <label for="idtask">TaskID</label>
    <input type="text" class="form-control" id="idtask" readonly>
</div>
<div class="form-group">
    <label for="userid">UserID</label>
    <input type="text" class="form-control" id="userid" readonly>
</div>
<div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control" id="title" readonly>
</div>

<div class="form-group">
    <label for="username">UserName</label>
    <input type="text" class="form-control" id="username" readonly>
</div>
   
<div class="form-group">
    <label for="dated">DateDebut</label>
    <input type="text" class="form-control" id="dated" readonly>
</div>
                                    <div class="form-group">
    <label for="datef">DateFin</label>
    <input type="text" class="form-control" id="datef" readonly>
</div>
                                    <div class="form-group">
    <label for="priority">Priority</label>
    <input type="text" class="form-control" id="priority" readonly>
</div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                                </div>
                            </div>
                        </div>
                    </div>
    </form>
        </div>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
            <!-- JavaScript de Bootstrap -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
            <!-- Inclure la bibliothèque moment.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // Ajoutez un gestionnaire d'événements double-clic à chaque ligne de la GridView
            $('#GridView1 tbody').on('dblclick', 'tr', function () {
                // Récupérez les données de la ligne
                var idtaskass = $(this).find('td:eq(1)').text();
                var idtask = $(this).find('td:eq(2)').text();
                var userid = $(this).find('td:eq(3)').text();
                var title = $(this).find('td:eq(4)').text();
                var username = $(this).find('td:eq(5)').text();
                var priority = $(this).find('td:eq(8)').text();
                var dated = $(this).find('td:eq(6)').text(); // Récupérer la date de début à partir de la sixième colonne
                var datef = $(this).find('td:eq(7)').text(); // Récupérer la date de fin à partir de la septième colonne

                // Formater les dates avec moment.js
                var formattedDated = moment(dated).format("DD/MM/YYYY");
                var formattedDatef = moment(datef).format("DD/MM/YYYY");

                // Remplissez les champs de la fenêtre modale avec ces données formatées
               
                $('#modal-id').find('#idtaskass').val(idtaskass);
                $('#modal-id').find('#idtask').val(idtask);
                $('#modal-id').find('#userid').val(userid);
                $('#modal-id').find('#title').val(title);
                $('#modal-id').find('#username').val(username);

                $('#modal-id').find('#dated').val(formattedDated);
                $('#modal-id').find('#datef').val(formattedDatef);
                $('#modal-id').find('#priority').val(priority);

                
                // Affichez la fenêtre modale
                $('#modal-id').modal('show');
            });
        });
    </script>
</body>
</html>
