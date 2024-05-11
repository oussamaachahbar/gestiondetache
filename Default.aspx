<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="gestiontaches._Default" %>

<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">

	<link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/a81368914c.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
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
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<h5>Username</h5>
           		   		<asp:TextBox ID="txtUsername" runat="server" CssClass="input"></asp:TextBox>
           		   </div>
           		</div>
           		<div class="input-div pass">
           		   <div class="i"> 
           		    	<i class="fas fa-lock"></i>
           		   </div>
           		   <div class="div">
           		    	<h5>Password</h5>
           		    	<asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password"></asp:TextBox>
            	   </div>
            	</div>
            	<a href="#">Forgot Password?</a>
            	<asp:Button ID="btnLogin" runat="server" CssClass="btn" Text="Login" OnClick="btnLogin_Click" />
                <asp:Button ID="Button1" runat="server" CssClass="btn" Text="inscrire" OnClick="btnInscrire_Click" />

            </form>
        </div>
    </div>
    <script type="text/javascript" src="js/main.js"></script>
</body>
</html>
