<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="gestiontaches._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css" />

    <!-- Utilisation de Bootstrap pour un style moderne -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    <style>
    /* Style pour le corps de la page */
body {
    background-image: url('admin/black.jfif');
    background-size: cover; /* Ajuste la taille de l'image pour couvrir tout le corps */
    background-position: center; /* Centre l'image sur le corps */
    background-repeat: no-repeat; /* Empêche la répétition de l'image */
    height: 100vh; /* Utilise toute la hauteur de la fenêtre visible */
    margin: 0; /* Supprime les marges par défaut */
    padding: 0; /* Supprime les rembourrages par défaut */
}

/* Style pour le conteneur principal */
.container {
    max-width: 400px;
    margin: 0 auto;
    margin-top: 10%; /* Espacement du haut ajusté */
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    background-color: rgba(255, 255, 255, 0.8); /* Fond semi-transparent blanc */
}

/* Style pour le titre */
h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333; /* Couleur du texte */
}

/* Style pour l'étiquette de message */
#lblMessage {
    margin-bottom: 10px;
    color: red; /* Couleur du texte */
}

/* Style pour les champs de texte */
.form-group {
    margin-bottom: 20px;
}

/* Style pour les champs de texte */
.form-control {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc; /* Bordure grise */
    border-radius: 4px;
}

/* Style pour les boutons */
.btn {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

/* Style pour le bouton de connexion */
.btn-primary {
    background-color: #007bff; /* Couleur de fond bleue */
    color: #fff; /* Couleur du texte blanc */
}

/* Style pour le bouton S'inscrire */
.btn-secondary {
    background-color: #6c757d; /* Couleur de fond gris */
    color: #fff; /* Couleur du texte blanc */
}

/* Style pour le bouton de connexion */
.btn-block {
    display: block;
}
</style>

</head>
<body style="background-image: url('admin/black.jfif');">
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="text-center mb-4">Login</h2>
            <div class="form-group">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Text=""></asp:Label>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary btn-block" Text="Login" OnClick="btnLogin_Click" />
            </div>
            <div class="form-group">
                <asp:Button ID="btnInscrire" runat="server" CssClass="btn btn-secondary btn-block btn-inscrire" Text="S'inscrire" OnClick="btnInscrire_Click" />
            </div>
        </div>
    </form>
</body>
</html>
