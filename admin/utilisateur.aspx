<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="utilisateur.aspx.cs" Inherits="gestiontaches.utilisateur" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion des tâches - Admin</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
<style>body{background-color:#f8f9fa;font-family:Arial,sans-serif}table{width:100%;border-collapse:collapse;border:2px solid #ddd}th{background-color:#f2f2f2;border:1px solid #ddd;padding:8px;text-align:left}td{border:1px solid #ddd;padding:8px}tr:nth-child(odd){background-color:#f9f9f9}.sidebar{background-color:black;color:#fff;position:fixed;height:100%;overflow-y:auto;z-index:1;padding-top:20px;width:250px;border-radius:10px}.container-main{margin-left:250px;padding:20px}.form-group label{font-weight:bold;margin-bottom:5px}.form-group input[type="text"],.form-group input[type="email"],.form-group input[type="password"]{width:100%;padding:10px;border:1px solid #ccc;border-radius:5px;box-sizing:border-box;margin-bottom:15px}.form-group input[readonly]{background-color:#f0f0f0}.btn{background-color:#007bff;color:#fff;border:none;padding:10px 20px;border-radius:5px;cursor:pointer}.btn:hover{background-color:#0056b3}.modal-body .form-group{margin-bottom:15px}.modal-header{background-color:#007bff;color:#fff;border-bottom:none}.modal-title{color:#fff}.modal-footer{border-top:none}.col-md-3.sidebar{overflow-y:auto}.modal-header .close{color:#fff}.nav-item{display:flex;align-items:center}.nav-icon{width:20px;height:auto;margin-right:10px}.nav-link{border-radius:5px;transition:background-color 0.3s}.nav-link:hover{background-color:#ffc107}</style>

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
            <div class="col-md-9 container-main" style="zoom:80%">
                
                <div class="container">
                        <form id="form1" runat="server">
            

    <div class="container">
        <div class="row">
            <div class="col-md-6">
                
                    <div class="form-group">
                        <asp:Label ID="Label7" runat="server" Text="ID" AssociatedControlID="id"></asp:Label>
                        <asp:TextBox ID="id" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label8" runat="server" Text="Nom" AssociatedControlID="nom"></asp:Label>
                        <asp:TextBox ID="nom" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label9" runat="server" Text="Prénom" AssociatedControlID="prenom"></asp:Label>
                        <asp:TextBox ID="prenom" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label10" runat="server" Text="Adresse email" AssociatedControlID="email"></asp:Label>
                        <asp:TextBox ID="email" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
             <div class="form-group">
    <label for="avatar">Choisir une image</label>
    <asp:FileUpload ID="avatarUpload" runat="server" />
</div>


                    <div class="form-group">
                        <asp:Label ID="Label11" runat="server" Text="Téléphone" AssociatedControlID="phone"></asp:Label>
                        <asp:TextBox ID="phone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="password">Mot de passe</label>
                        <asp:TextBox ID="password" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                <div class="form-group">
    <asp:Label ID="Label1" runat="server" Text="sexe" AssociatedControlID="role"></asp:Label>
    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
        <asp:ListItem Text="f" Value="girl"></asp:ListItem>
        <asp:ListItem Text="g" Value="boys"></asp:ListItem>
    </asp:DropDownList>
</div>
                    <div class="form-group">
                        <asp:Label ID="Label12" runat="server" Text="Rôle" AssociatedControlID="role"></asp:Label>
                        <asp:DropDownList ID="role" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Administrateur" Value="admin"></asp:ListItem>
                            <asp:ListItem Text="Étudiant" Value="etudiant"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
              


                    <div class="form-group">
                        <asp:Button ID="Button5" runat="server" Text="Delete" CssClass="btn btn-danger btn-submit" OnClick="btndelete_Clickz" Width="84px"></asp:Button>
                        <asp:Button ID="Button6" runat="server" Text="Update" CssClass="btn btn-warning btn-submit" OnClick="btnupdate_Click"></asp:Button>
                        <asp:Button ID="Button7" runat="server" Text="Submit" CssClass="btn btn-primary btn-submit" OnClick="btnSubmit_Click"></asp:Button>
                    </div>
                
            </div>
            <div class="col-md-6 grid-view" id="DivToPrint" runat="server">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowDeleting="GridView1_RowDeleting"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chk" runat="server" OnCheckedChanged="chk_CheckedChanged" AutoPostBack="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UserID" HeaderText="UserID" />
                    <asp:BoundField DataField="Nom" HeaderText="Nom" />
                    <asp:BoundField DataField="Prenom" HeaderText="Prénom" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Telephone" HeaderText="Téléphone" />
                    <asp:BoundField DataField="Role" HeaderText="Rôle" />
                    <asp:BoundField DataField="Password" HeaderText="Mot de passe" />
                    <asp:BoundField DataField="Sexe" HeaderText="Sexe" />
                    <asp:TemplateField HeaderText="Photo">
                        <ItemTemplate>
                            <asp:Image ID="imgPhoto" runat="server" ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Photo")) %>' Height="100px" Width="100px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
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
    <label for="photo">Photo</label>
    <asp:Image ID="photo" runat="server" CssClass="form-control" Height="100px" Width="100px" />
</div>

                                            <div class="form-group">
        <label for="id">ID</label>
        <input type="text" class="form-control" id="id" readonly>
    </div>
    <div class="form-group">
        <label for="nom">Nom</label>
        <input type="text" class="form-control" id="nom" readonly>
    </div>
    <div class="form-group">
        <label for="prenom">Prénom</label>
        <input type="text" class="form-control" id="prenom" readonly>
    </div>
    <div class="form-group">
        <label for="email">Adresse email</label>
        <input type="email" class="form-control" id="email" readonly>
    </div>
    <div class="form-group">
        <label for="phone">Téléphone</label>
        <input type="text" class="form-control" id="phone" readonly>
    </div>
    <div class="form-group">
        <label for="role">Rôle</label>
        <input type="text" class="form-control" id="role" readonly>
    </div>
   
    <div class="form-group">
        <label for="sexe">Sexe</label>
        <input type="text" class="form-control" id="sexe" readonly>
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
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // Ajoutez un gestionnaire d'événements double-clic à chaque ligne de la GridView
            $('#GridView1 tbody').on('dblclick', 'tr', function () {
                // Récupérez les données de la ligne
                var id = $(this).find('td:eq(1)').text(); // L'ID est dans la deuxième colonne
                var nom = $(this).find('td:eq(2)').text();
                var prenom = $(this).find('td:eq(3)').text();
                var email = $(this).find('td:eq(4)').text();
                var phone = $(this).find('td:eq(5)').text();
                var role = $(this).find('td:eq(6)').text();
                var sexe = $(this).find('td:eq(8)').text();
                var imgSrc = $(this).find('td:eq(9) img').attr('src'); // Récupérez l'URL de l'image

                // Remplissez les champs de la fenêtre modale avec ces données
                $('#modal-id').find('#id').val(id);
                $('#modal-id').find('#nom').val(nom);
                $('#modal-id').find('#prenom').val(prenom);
                $('#modal-id').find('#email').val(email);
                $('#modal-id').find('#phone').val(phone);
                $('#modal-id').find('#role').val(role);
                $('#modal-id').find('#sexe').val(sexe);
                $('#modal-id').find('#photo').attr('src', imgSrc); // Affichez l'image

                // Affichez la fenêtre modale
                $('#modal-id').modal('show');
            });
        });

    </script>
</body>
</html>
