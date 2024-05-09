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
    public partial class admin : System.Web.UI.Page
    {
        basedonner b = new basedonner();
        protected List<UserModel> Users { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }

            LoadTaskData();
            LoadAssignedTaskData();
            LoadUserData();
            Users = GetUsersFromDatabase();
            // Mettre à jour l'affichage des données
            BindUserData();
            if (!IsPostBack)
            {
                BindGridView();
            }
        }
        private void BindGridView()
        {
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour sélectionner les utilisateurs sans inclure la colonne de mot de passe
            string query = "SELECT * FROM Taskee";

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
        protected List<UserModel> GetUsersFromDatabase()
        {
            List<UserModel> users = new List<UserModel>();

            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string connectionString = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour sélectionner les utilisateurs depuis la table Utilisateur
            string query = "SELECT Nom, Prenom, Email, Sexe, Photo FROM Utilisateur";

            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Utilisation de SqlCommand pour exécuter la requête SQL
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        // Ouverture de la connexion
                        connection.Open();

                        // Utilisation de SqlDataReader pour lire les données de la base de données
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            // Lecture des données et ajout à la liste des utilisateurs
                            while (reader.Read())
                            {
                                UserModel user = new UserModel();
                                user.Nom = reader["Nom"].ToString();
                                user.Prenom = reader["Prenom"].ToString();
                                user.Email = reader["Email"].ToString();
                                user.Sexe = reader["Sexe"].ToString();
                                user.Photo = (byte[])reader["Photo"]; // Récupération des données de l'image
                                users.Add(user);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Gestion des exceptions
                        // Vous pouvez gérer les erreurs de connexion ici
                        Console.WriteLine("Erreur : " + ex.Message);
                    }
                }
            }

            return users;
        }

        protected void BindUserData()
        {
            rptUsers.DataSource = Users;
            rptUsers.DataBind();
        }

        // Modèle pour représenter un utilisateur
        public class UserModel
        {
            public string Nom { get; set; }
            public string Prenom { get; set; }
            public string Email { get; set; }
            public string Sexe { get; set; }
            public byte[] Photo { get; set; } // Champ pour stocker les données de l'image
        }


        private void LoadUserData()
        {
            string query = "SELECT COUNT(*) FROM Utilisateur";
            SqlCommand command = b.nombase(query);

            int nombreUtilisateurs = (int)command.ExecuteScalar();
            lblNombreUtilisateurs.Text = nombreUtilisateurs.ToString();
        }

        private void LoadTaskData()
        {
            // Requête SQL pour compter le nombre d'utilisateurs
            string query = "SELECT COUNT(*) FROM Taskee";
            SqlCommand command = b.nombase(query);

            int nombreUtilisateurs = (int)command.ExecuteScalar();
            lblNombreTaches.Text = nombreUtilisateurs.ToString();
        }

        private void LoadAssignedTaskData()
        {
            string query = "SELECT COUNT(*) FROM TaskAssignment";
            SqlCommand command = b.nombase(query);

            int nombreUtilisateurs = (int)command.ExecuteScalar();
            lblNombreTachesAffectees.Text = nombreUtilisateurs.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=taches.doc");
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