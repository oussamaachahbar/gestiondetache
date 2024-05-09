using System;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace gestiontaches
{
    public partial class affectation_tache : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdowns();
            }
            BindGridView();
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnAffecterTache_Click(object sender, EventArgs e)
        {
            string taskID = ddlTache.SelectedValue;
            string userID = ddlUtilisateur.SelectedValue;
            if (IsAssignmentExists(taskID, userID))
            {
                Response.Write("<script>alert('Cette tâche est déjà affectée à cet utilisateur.');</script>");
                return;
            }
            // Obtention des informations sur la tâche sélectionnée à partir de la table Taskee
            string title = GetTaskTitle(taskID);
            DateTime dateDebut;
            DateTime.TryParse(GetTaskStartDate(taskID), out dateDebut);
            DateTime dateFin;
            DateTime.TryParse(GetTaskEndDate(taskID), out dateFin);

            // Obtention du nom complet de l'utilisateur sélectionné à partir de la table Utilisateur
            string userName = GetUserName(userID);

            // Insertion des données dans la table TaskAssignement
            InsertIntoTaskAssignement(taskID, userID, title, userName, dateDebut, dateFin);

            // Optionnel : afficher un message de succès ou de confirmation à l'utilisateur
            Response.Write("<script>alert('La tâche a été affectée avec succès !');</script>");
            BindGridView();
        }
        // Méthode pour vérifier si une entrée existe déjà dans la table TaskAssignment pour la combinaison tâche-utilisateur
        private bool IsAssignmentExists(string taskID, string userID)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT COUNT(*) FROM TaskAssignment WHERE TaskID = @TaskID AND UserID = @UserID";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TaskID", taskID);
                    command.Parameters.AddWithValue("@UserID", userID);
                    connection.Open();
                    int count = Convert.ToInt32(command.ExecuteScalar());
                    return count > 0;
                }
            }
        }

        // Méthode pour lier les listes déroulantes avec les données nécessaires
        private void BindDropdowns()
        {
            // Lier la liste déroulante des tâches avec les données de la table Taskee
            ddlTache.DataSource = GetTasks();
            ddlTache.DataTextField = "Title";
            ddlTache.DataValueField = "TaskID";
            ddlTache.DataBind();

            // Lier la liste déroulante des utilisateurs avec les données de la table Utilisateur
            ddlUtilisateur.DataSource = GetUsers();
            ddlUtilisateur.DataTextField = "UserName";
            ddlUtilisateur.DataValueField = "UserID";
            ddlUtilisateur.DataBind();
        }

        // Méthode pour obtenir les tâches à partir de la table Taskee
        private DataTable GetTasks()
        {
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            string query = "SELECT TaskID, Title FROM Taskee WHERE Status = 'en cours'";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        return dataTable;
                    }
                }
            }
        }



        // Méthode pour obtenir les utilisateurs à partir de la table Utilisateur
        private DataTable GetUsers()
        {
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            string query = "SELECT UserID, CONCAT(Nom, ' ', Prenom) AS UserName FROM Utilisateur WHERE Role = 'etudiant'";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        return dataTable;
                    }
                }
            }
        }

        // Méthode pour obtenir le titre de la tâche à partir de son ID
        // Méthode pour obtenir le titre de la tâche à partir de son ID
        private string GetTaskTitle(string taskID)
        {
            string title = "";
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT Title FROM Taskee WHERE TaskID = @TaskID AND Status = 'en cours'";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TaskID", taskID);
                    connection.Open();
                    title = Convert.ToString(command.ExecuteScalar());
                }
            }

            return title;
        }



        // Méthode pour obtenir la date de début de la tâche à partir de son ID
        private string GetTaskStartDate(string taskID)
        {
            string startDate = "";
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT DateDebut FROM Taskee WHERE TaskID = @TaskID";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TaskID", taskID);
                    connection.Open();
                    startDate = Convert.ToString(command.ExecuteScalar());
                }
            }

            return startDate;
        }


        // Méthode pour obtenir la date de fin de la tâche à partir de son ID
        private string GetTaskEndDate(string taskID)
        {
            string endDate = "";
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT DateFin FROM Taskee WHERE TaskID = @TaskID";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TaskID", taskID);
                    connection.Open();
                    endDate = Convert.ToString(command.ExecuteScalar());
                }
            }

            return endDate;
        }
        // Implémentation pour obtenir la date de fin de la tâche à partir de son ID


        // Méthode pour obtenir le nom complet de l'utilisateur à partir de son ID
        private string GetUserName(string userID)
        {
            string userName = "";
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT CONCAT(Nom, ' ', Prenom) AS UserName FROM Utilisateur WHERE UserID = @UserID";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", userID);
                    connection.Open();
                    userName = Convert.ToString(command.ExecuteScalar());
                }
            }

            return userName;
        }


        // Méthode pour insérer les données dans la table TaskAssignement
        private void InsertIntoTaskAssignement(string taskID, string userID, string title, string userName, DateTime dateDebut, DateTime dateFin)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "INSERT INTO TaskAssignment (TaskID, UserID, TaskName, UserName, StartDate, EndDate) VALUES (@TaskID, @UserID, @Title, @UserName, @DateDebut, @DateFin)";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TaskID", taskID);
                    command.Parameters.AddWithValue("@UserID", userID);
                    command.Parameters.AddWithValue("@Title", title);
                    command.Parameters.AddWithValue("@UserName", userName);
                    command.Parameters.AddWithValue("@DateDebut", dateDebut);
                    command.Parameters.AddWithValue("@DateFin", dateFin);

                    command.ExecuteNonQuery();
                }
            }
        }
        private void BindGridView()
        {
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL avec jointure et condition WHERE
            string query = @"
        SELECT TA.TaskAssignmentID, TA.TaskName, TA.UserName, TA.StartDate, TA.EndDate
        FROM TaskAssignment TA
        JOIN Taskee T ON TA.TaskID = T.TaskID
        WHERE T.Status = 'en cours'";
            string quer = @"
        SELECT TaskID, Title, DateDebut, DateFin
        FROM Taskee
        WHERE Status LIKE 'terminée par%'";
            string quere = @"
        SELECT TaskID, Title, DateDebut, DateFin
        FROM Taskee
        WHERE Status LIKE 'en fait par%'";

            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(strConn))
            {
                // Création d'un DataTable pour stocker les données récupérées pour la GridView1
                DataTable dataTable1 = new DataTable();
                // Création d'un DataTable pour stocker les données récupérées pour la GridView2
                DataTable dataTable2 = new DataTable();
                DataTable dataTable3 = new DataTable();

                // Utilisation de SqlDataAdapter pour récupérer les données de la base de données et remplir les DataTable
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    adapter.Fill(dataTable1);
                }

                using (SqlDataAdapter adapter = new SqlDataAdapter(quer, connection))
                {
                    adapter.Fill(dataTable2);
                }
                using (SqlDataAdapter adapter = new SqlDataAdapter(quere, connection))
                {
                    adapter.Fill(dataTable3);
                }
                // Liaison des DataTable aux GridView respectifs pour afficher les données
                GridView1.DataSource = dataTable1;
                GridView1.DataBind();

                GridView2.DataSource = dataTable2;
                GridView2.DataBind();
                GridView3.DataSource = dataTable3;
                GridView3.DataBind();
            }
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowIndex = GridView1.SelectedIndex;

            if (rowIndex >= 0 && rowIndex < GridView1.Rows.Count)
            {

            }
        }

        protected void chk_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox cb = sender as CheckBox;
            GridViewRow row = cb.NamingContainer as GridViewRow;

            if (cb.Checked)
            {
                ddlTache.SelectedValue = row.Cells[1].Text;
                ddlUtilisateur.SelectedValue = row.Cells[2].Text;
            }
            else
            {
                ddlTache.SelectedIndex = -1;
                ddlUtilisateur.SelectedIndex = -1;
            }
        }




        protected void GridView1_SelectedIndexChanged2(object sender, EventArgs e)
        {
            string id = GridView1.SelectedRow.Cells[1].Text;

            string taskName = GridView1.SelectedRow.Cells[2].Text;
            string userName = GridView1.SelectedRow.Cells[3].Text;
            string startDate = GridView1.SelectedRow.Cells[4].Text;
            string endDate = GridView1.SelectedRow.Cells[5].Text;


        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = GridView1.Rows[e.RowIndex].Cells[1].Text;

            try
            {
                string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
                string query = "DELETE FROM TaskAssignment WHERE TaskAssignmentID = @id";

                using (SqlConnection connection = new SqlConnection(strConn))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('La tâche a été supprimée avec succès.');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('La tâche n'a pas été trouvée ou n'a pas pu être supprimée.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Une erreur s'est produite lors de la suppression de la tâche : " + ex.Message + "');</script>");
            }

            BindGridView(); // Réactualiser le GridView après la suppression



        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnGenerateWord_Click(object sender, EventArgs e)
        {

        }
    }
}