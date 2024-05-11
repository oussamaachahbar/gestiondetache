using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;





namespace gestiontaches
{
    public partial class utilisateur : Page

    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView(); // Appel à la méthode pour lier les données à la GridView lors du premier chargement de la page
            }
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }


        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = GridView1.DataKeys[e.RowIndex].Value.ToString();

            try
            {
                string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
                string query = "DELETE FROM Utilisateur WHERE UserID = @id";

                using (SqlConnection connection = new SqlConnection(strConn))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Utilisateur a été supprimé avec succès.')", true);
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Utilisateur non trouvé ou impossible de le supprimer.')", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", $"alert('Une erreur s'est produite lors de la suppression de l'utilisateur : {ex.Message}')", true);
            }

            BindGridView(); // Réactualiser le GridView après la suppression
        }

        protected bool IsAssignmentExists(string nom, string prenom)
        {
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour vérifier si l'utilisateur existe déjà
            string query = "SELECT COUNT(*) FROM Utilisateur WHERE Nom = @nom AND Prenom = @prenom";

            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(strConn))
            {
                // Utilisation de SqlCommand pour exécuter la requête SQL
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Ajout des paramètres à la commande SQL
                    command.Parameters.AddWithValue("@nom", nom);
                    command.Parameters.AddWithValue("@prenom", prenom);

                    // Ouverture de la connexion
                    connection.Open();

                    // Exécution de la commande SQL et récupération du nombre d'enregistrements correspondants
                    int count = (int)command.ExecuteScalar();

                    // Retourne true si un enregistrement avec le même nom et prénom existe déjà, sinon retourne false
                    return count > 0;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Récupérer les valeurs saisies dans les champs
            string nomValue = nom.Text;
            string prenomValue = prenom.Text;
            string emailValue = email.Text;
            string phoneValue = phone.Text;
            string roleValue = role.SelectedValue;
            string passwordValue = password.Text; // Nouveau champ pour le mot de passe
            string sexevalue = DropDownList1.SelectedValue; // Assurez-vous d'utiliser SelectedValue pour récupérer la valeur sélectionnée du DropDownList

            // Vérifier si les champs obligatoires sont remplis
            if (string.IsNullOrEmpty(nomValue) || string.IsNullOrEmpty(prenomValue) || string.IsNullOrEmpty(emailValue) || string.IsNullOrEmpty(passwordValue))
            {
                Response.Write("<script>alert('Veuillez remplir tous les champs obligatoires.');</script>");
                return;
            }

            // Vérifier si un fichier a été téléchargé
            if (avatarUpload.HasFile)
            {
                // Convertir le fichier en tableau de bytes
                byte[] imageData = avatarUpload.FileBytes;

                // Chaîne de connexion à votre base de données à partir du fichier Web.config
                string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

                // Requête SQL pour vérifier si un utilisateur avec le même nom et prénom existe déjà
                string checkQuery = "SELECT COUNT(*) FROM Utilisateur WHERE Nom = @nom AND Prenom = @prenom";

                // Utilisation de SqlConnection pour se connecter à la base de données
                using (SqlConnection connection = new SqlConnection(strConn))
                {
                    connection.Open();

                    // Utilisation de SqlCommand pour exécuter la requête SQL de vérification
                    using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                    {
                        // Ajout des paramètres à la commande SQL de vérification
                        checkCommand.Parameters.AddWithValue("@nom", nomValue);
                        checkCommand.Parameters.AddWithValue("@prenom", prenomValue);

                        // Exécution de la commande SQL de vérification
                        int existingUserCount = (int)checkCommand.ExecuteScalar();

                        // Vérifier si un utilisateur avec le même nom et prénom existe déjà
                        if (existingUserCount > 0)
                        {
                            Response.Write("<script>alert('Un utilisateur avec le même nom et prénom existe déjà. Veuillez fournir des valeurs uniques.');</script>");
                            return;
                        }
                    }

                    // Requête SQL pour insérer les données dans la table Utilisateurs
                    string insertQuery = "INSERT INTO Utilisateur (Nom, Prenom, Email, Telephone, Role, Password, Sexe, Photo) " +
                                        "VALUES (@nom, @prenom, @email, @phone, @role, @password, @sexe, @photo)";

                    // Utilisation de SqlCommand pour exécuter la requête SQL d'insertion
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        // Ajout des paramètres à la commande SQL d'insertion
                        command.Parameters.AddWithValue("@nom", nomValue);
                        command.Parameters.AddWithValue("@prenom", prenomValue);
                        command.Parameters.AddWithValue("@email", emailValue);
                        command.Parameters.AddWithValue("@phone", phoneValue);
                        command.Parameters.AddWithValue("@role", roleValue);
                        command.Parameters.AddWithValue("@password", passwordValue);
                        command.Parameters.AddWithValue("@sexe", sexevalue);
                        command.Parameters.AddWithValue("@photo", imageData);

                        // Exécution de la commande SQL d'insertion
                        int rowsAffected = command.ExecuteNonQuery();

                        // Vérification si l'insertion a réussi
                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Données insérées avec succès !');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Erreur lors de l\'insertion des données.');</script>");
                        }
                    }
                }

                // Effacer les champs après l'insertion des données
                ClearFields();

                // Recharger la GridView après l'insertion des données
                BindGridView();
            }
            else
            {
                Response.Write("<script>alert('Veuillez sélectionner une image.');</script>");
            }
        }

        private void ClearFields()
        {
            // Effacer les champs de saisie après l'insertion des données
            id.Text = "";
            nom.Text = "";
            prenom.Text = "";
            email.Text = "";
            phone.Text = "";
            role.ClearSelection();
            password.Text = "";
            DropDownList1.ClearSelection();
        }












        private void BindGridView()
        {
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour sélectionner les utilisateurs sans inclure la colonne de mot de passe
            string query = "SELECT UserID, Nom, Prenom, Email, Telephone, Role, Password, Sexe, Photo FROM Utilisateur WHERE Role='etudiant'";

            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(strConn))
            {
                // Utilisation de SqlDataAdapter pour récupérer les données de la base de données
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    // Création d'un DataTable pour stocker les données récupérées
                    DataTable dataTable = new DataTable();

                    // Remplissage du DataTable avec les données récupérées
                    adapter.Fill(dataTable);

                    // Liaison du DataTable à la GridView pour afficher les données
                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }
        protected void chk_CheckedChanged(object sender, EventArgs e)
        {
            int rowIndex = ((GridViewRow)(sender as System.Web.UI.Control).NamingContainer).RowIndex;
            System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)GridView1.Rows[rowIndex].FindControl("chk");
            if (cb.Checked)
            {
                id.Text = GridView1.Rows[rowIndex].Cells[1].Text;

                nom.Text = GridView1.Rows[rowIndex].Cells[2].Text;
                prenom.Text = GridView1.Rows[rowIndex].Cells[3].Text;
                email.Text = GridView1.Rows[rowIndex].Cells[4].Text;
                phone.Text = GridView1.Rows[rowIndex].Cells[5].Text;
                role.SelectedValue = GridView1.Rows[rowIndex].Cells[6].Text;
                password.Text = GridView1.Rows[rowIndex].Cells[7].Text.ToString();
                DropDownList1.SelectedValue = GridView1.Rows[rowIndex].Cells[8].Text;

            }
            else
            {
                id.Text = "";
                nom.Text = "";
                prenom.Text = "";
                email.Text = "";
                phone.Text = "";
                role.Text = "";
                password.Text = "";
                DropDownList1.Text = "";
            }
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowIndex = ((GridViewRow)(sender as System.Web.UI.Control).NamingContainer).RowIndex;
            System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)GridView1.Rows[rowIndex].FindControl("chk");
            if (cb.Checked)
            {

            }
        }
        protected void btnupdate_Click(object sender, EventArgs e)
        {


            String nb = id.Text;
            String nb1 = nom.Text;
            String nb2 = prenom.Text;
            String nb3 = email.Text;
            String nb4 = phone.Text;
            String nb5 = role.SelectedValue;
            String nb6 = password.Text;
            String nb7 = DropDownList1.SelectedValue;


            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "UPDATE Utilisateur SET Nom=@nom, Prenom=@prenom, Email=@email, "
                         + "Telephone=@tel, Role=@role, Password=@pass,Sexe=@sexe WHERE UserID=@id";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", nb);
                    command.Parameters.AddWithValue("@nom", nb1);
                    command.Parameters.AddWithValue("@prenom", nb2);
                    command.Parameters.AddWithValue("@email", nb3);
                    command.Parameters.AddWithValue("@tel", nb4);
                    command.Parameters.AddWithValue("@role", nb5);
                    command.Parameters.AddWithValue("@pass", nb6);
                    command.Parameters.AddWithValue("@sexe", nb7);

                    try
                    {
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {


                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Utilisateur modifiée avec succès !')", true);
                            id.Text = "";
                            nom.Text = "";
                            prenom.Text = "";
                            email.Text = "";
                            phone.Text = "";
                            Label12.Text = "";
                            password.Text = "";
                            Label1.Text = "";
                            BindGridView();
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Aucune utilisateur n'a été supprimée.')", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", $"alert('Erreur lors de la suppression de la utilisateur : {ex.Message}')", true);
                    }
                }
            }
        }




        protected void btndelete_Clickz(object sender, EventArgs e)
        {
            string nb = id.Text;
            string nomComplet = nom.Text + " " + prenom.Text;
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string queryCheckTasks = "SELECT COUNT(*) FROM TaskAssignment WHERE UserName = @nomComplet";
            string queryDeleteUser = "DELETE FROM Utilisateur WHERE UserID = @id AND CONCAT(Nom, Prenom) != @nomComplet"; // Ne supprime que si le nom complet n'est pas celui de l'utilisateur actuellement connecté

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand commandCheckTasks = new SqlCommand(queryCheckTasks, connection))
                {
                    commandCheckTasks.Parameters.AddWithValue("@nomComplet", nomComplet);

                    try
                    {
                        connection.Open();
                        int tasksCount = (int)commandCheckTasks.ExecuteScalar();

                        if (tasksCount > 0)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Impossible de supprimer cet utilisateur car des tâches lui sont assignées.')", true);
                        }
                        else
                        {
                            using (SqlCommand commandDeleteUser = new SqlCommand(queryDeleteUser, connection))
                            {
                                commandDeleteUser.Parameters.AddWithValue("@id", nb);
                                commandDeleteUser.Parameters.AddWithValue("@nomComplet", nomComplet);
                                int rowsAffected = commandDeleteUser.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Utilisateur supprimé avec succès !')", true);
                                    id.Text = "";
                                    nom.Text = "";
                                    prenom.Text = "";
                                    email.Text = "";
                                    phone.Text = "";
                                    Label12.Text = "";
                                    password.Text = "";
                                    Label1.Text = "";
                                    BindGridView();
                                }
                                else
                                {
                                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Aucun utilisateur n'a été supprimé.')", true);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", $"alert('Erreur lors de la suppression de l'utilisateur : {ex.Message}')", true);
                    }
                }
            }
        }



        protected void btnGenerateWord_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=GridViewExport.doc");
            Response.ContentType = "application/vnd.ms-word";
            using (StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(stringWriter);
                GridView1.AllowPaging = false;
                this.BindGridView();
                GridView1.HeaderRow.BackColor = Color.White;
                foreach (GridViewRow row in GridView1.Rows)
                {

                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                    }
                }
                GridView1.RenderControl(hw);
                Response.Output.Write(stringWriter.ToString());
                Response.Flush();
                Response.End();
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {

        }
    }







}

