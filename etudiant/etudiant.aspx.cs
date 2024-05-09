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

namespace gestiontaches.etudiant
{
    public partial class etudiant : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["NomUtilisateur"] != null)
                {
                    string nomUtilisateur = Request.QueryString["NomUtilisateur"];
                    BindGridView(nomUtilisateur);
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        private void BindGridView(string nomUtilisateur)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = @"
                SELECT TA.*, T.Priority
                FROM TaskAssignment TA
                JOIN Taskee T ON TA.TaskID = T.TaskID
                WHERE TA.UserName = @NomUtilisateur AND T.Status = 'en cours' 
                ORDER BY CASE T.Priority WHEN 'Haute' THEN 1 WHEN 'Normale' THEN 2 ELSE 3 END";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    adapter.SelectCommand.Parameters.AddWithValue("@NomUtilisateur", nomUtilisateur);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }



        private void UpdateTaskStatus(int taskId, string status)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "UPDATE Taskee SET Status = @Status WHERE TaskId = @TaskId";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@TaskId", taskId);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        private void DeleteTaskAssignment(int taskAssignmentId)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "DELETE FROM TaskAssignment WHERE TaskAssignmentID = @TaskAssignmentID";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TaskAssignmentID", taskAssignmentId);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
        protected void chk_CheckedChanged(object sender, EventArgs e)
        {
            // Récupérer la ligne parente du contrôle CheckBox
            GridViewRow row = (GridViewRow)((CheckBox)sender).NamingContainer;
            string nomUtilisateur = Request.QueryString["NomUtilisateur"];
            // Récupérer l'index de la ligne
            int rowIndex = row.RowIndex;

            // Récupérer les contrôles CheckBox dans la ligne sélectionnée
            CheckBox cb = (CheckBox)row.FindControl("chk");
            CheckBox cbe = (CheckBox)row.FindControl("chke");

            // Vérifier si la case à cocher cb est cochée
            if (cb.Checked)
            {
                // Récupérer l'identifiant de l'affectation de tâche
                int taskAssignmentId;
                if (int.TryParse(GridView1.Rows[rowIndex].Cells[1].Text, out taskAssignmentId))
                {
                    // Supprimer l'affectation de tâche correspondante
                    DeleteTaskAssignment(taskAssignmentId);
                }
            }
            // Sinon, vérifier si la case à cocher cbe est cochée
            else if (cbe.Checked)
            {
                // Récupérer l'identifiant de la tâche
                int taskId;
                if (int.TryParse(GridView1.Rows[rowIndex].Cells[2].Text, out taskId))
                {
                    // Mettre à jour le statut de la tâche
                    UpdateTaskStatus(taskId, "en fait par " + nomUtilisateur);
                }
            }

            // Recharger les données dans le GridView

            BindGridView(nomUtilisateur);
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string nomUtilisateur = Request.QueryString["NomUtilisateur"];

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=GridViewExport.doc");
            Response.ContentType = "application/vnd.ms-word";
            using (StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(stringWriter);
                GridView1.AllowPaging = false;
                this.BindGridView(nomUtilisateur);
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
