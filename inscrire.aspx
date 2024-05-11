<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeBehind="inscrire.aspx.cs" Inherits="gestiontaches.inscrire" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        /* Votre CSS existant ici */
        .input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .input:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }body {
    overflow-y: scroll; /* Ajoute une barre de défilement verticale uniquement lorsque nécessaire */
}
    </style>
</head>
<body>
    <img class="wave" src="img/wave.png">
    <div class="container">
        <div class="img">
            <img src="img/bg.svg">
        </div>
        <div class="login-content">
            <form id="form1" runat="server">
                <img src="img/avatar.svg">
                <h2 class="title">Welcome</h2>
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Text=""></asp:Label>

                <div class="form-group">
                    <label for="nom">Nom</label>
                    <asp:TextBox ID="nom" runat="server" CssClass="input" tabindex="1" accesskey="N"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="prenom">Prénom</label>
                    <asp:TextBox ID="prenom" runat="server" CssClass="input" tabindex="2" accesskey="P"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="email">Adresse email</label>
                    <asp:TextBox ID="email" runat="server" CssClass="input" tabindex="3" accesskey="E"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regexEmail" runat="server" ErrorMessage="Entrez une adresse email valide." ControlToValidate="email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <label for="phone">Téléphone</label>
                    <asp:TextBox ID="phone" runat="server" CssClass="input" tabindex="4" accesskey="T"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regexPhone" runat="server" ErrorMessage="Entrez un numéro de téléphone valide." ControlToValidate="phone" ValidationExpression="^(\d{10})?$"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <label for="sexe">Sexe</label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="input" tabindex="5" accesskey="S">
                        <asp:ListItem Text="Femme" Value="female"></asp:ListItem>
                        <asp:ListItem Text="Homme" Value="male"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="input" tabindex="6" accesskey="M"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirmer le mot de passe</label>
                    <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password" CssClass="input" tabindex="7" accesskey="C"></asp:TextBox>
                    <asp:CompareValidator ID="comparePassword" runat="server" ControlToValidate="confirmPassword" ControlToCompare="password" ErrorMessage="Les mots de passe ne correspondent pas."></asp:CompareValidator>
                </div>

                <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary btn-block" OnClick="btnSubmit_Click" tabindex="8" accesskey="S" />
                <asp:Button ID="Button2" runat="server" Text="Retour" CssClass="btn btn-secondary btn-block" OnClick="btnretour_Click" tabindex="9" accesskey="R" />
            </form>
        </div>
    </div>
    <script type="text/javascript" src="js/main.js"></script>
</body>
</html>

