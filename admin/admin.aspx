<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="gestiontaches.admin" %>

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
                <a class="nav-link active" href="admin.aspx">
                    <img src="/img/home.png" alt="Home Icon" class="nav-icon"/> <!-- Image pour Home -->
                    Home
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="utilisateur.aspx">
                    <img src="/img/utilisateuricon.png" alt="User Icon" class="nav-icon"/> <!-- Image pour Utilisateur -->
                    UTILISATEUR
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="tache.aspx">
                    <img src="/img/tacheicon.png" alt="Tasks Icon" class="nav-icon"/> <!-- Image pour Taches -->
                    TACHES
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="affectation_tache.aspx">
                    <img src="/img/afficon.png" alt="Assignment Icon" class="nav-icon"/> <!-- Image pour Affectation Tache -->
                    AFFECTATION TACHE
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="rapport.aspx">
                    <img src="/img/rapporticon.png" alt="Report Icon" class="nav-icon"/> <!-- Image pour Rapport -->
                    RAPPORT
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
                 <form id="form1" runat="server">
                <div class="container">
                     
                    <div class="row">
                        <div class="col-md-4">
                            <div class="box">
                                <h3>Nombre d'utilisateurs</h3>
                                <!-- Afficher le nombre d'utilisateurs -->
                                <p>Nombre total : <asp:Label ID="lblNombreUtilisateurs" runat="server"></asp:Label></p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="box">
                                <h3>Nombre de tâches</h3>
                                <!-- Afficher le nombre de tâches -->
                                <p>Nombre total : <asp:Label ID="lblNombreTaches" runat="server"></asp:Label></p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="box">
                                <h3>Nombre de tâches affectées</h3>
                                <!-- Afficher le nombre de tâches affectées -->
                                <p>Nombre total : <asp:Label ID="lblNombreTachesAffectees" runat="server"></asp:Label></p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Cartes des utilisateurs -->
                <div class="container">
                    <div class="row">
                        <asp:Repeater ID="rptUsers" runat="server">
    <ItemTemplate>
        <div class="col-md-3">
            <div class="card">
                <img class="card-img-top" src='data:image;base64,<%# Convert.ToBase64String(Eval("Photo") as byte[]) %>' alt="User Photo" />
                <div class="card-body">
                    <h5 class="card-title"><%# Eval("Nom") %> <%# Eval("Prenom") %></h5>
                    <p class="card-text"><strong>Email :</strong> <%# Eval("Email") %></p>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

                    </div>
                </div>
                <asp:GridView ID="GridView1" CssClass="custom-table" runat="server" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="1083px">
                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" ForeColor="#003399" />
                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                    <SortedDescendingHeaderStyle BackColor="#002876" />
                </asp:GridView>                                                     <div class="modal fade" id="modal-id" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <label for="id">ID</label>
    <input type="text" class="form-control" id="id" readonly>
</div>
<div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control" id="title" readonly>
</div>
<div class="form-group">
    <label for="desc">Description</label>
    <input type="text" class="form-control" id="desc" readonly>
</div>
<div class="form-group">
    <label for="priority">Priority</label>
    <input type="text" class="form-control" id="priority" readonly>
</div>

<div class="form-group">
    <label for="status">Status</label>
    <input type="text" class="form-control" id="status" readonly>
</div>
   
<div class="form-group">
    <label for="dated">DateDebut</label>
    <input type="text" class="form-control" id="dated" readonly>
</div>
                                    <div class="form-group">
    <label for="datef">DateFin</label>
    <input type="text" class="form-control" id="datef" readonly>
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
        
    </div>

       <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#GridView1 tbody').on('dblclick', 'tr', function () {
                var id = $(this).find('td:eq(0)').text();
                var title = $(this).find('td:eq(1)').text();
                var desc = $(this).find('td:eq(2)').text();
                var priority = $(this).find('td:eq(3)').text();
                var statuse = $(this).find('td:eq(4)').text();
                var dated = $(this).find('td:eq(5)').text();
                var datef = $(this).find('td:eq(6)').text();
                var formattedDated = moment(dated, "DD/MM/YYYY").format("DD/MM/YYYY");
                var formattedDatef = moment(datef, "DD/MM/YYYY").format("DD/MM/YYYY");
                $('#modal-id').find('#id').val(id);
                $('#modal-id').find('#title').val(title);
                $('#modal-id').find('#desc').val(desc);
                $('#modal-id').find('#priority').val(priority);
                $('#modal-id').find('#status').val(statuse);
                $('#modal-id').find('#dated').val(formattedDated);
                $('#modal-id').find('#datef').val(formattedDatef);
                $('#modal-id').modal('show');
            });
        });
    </script>
</body>
</html>
