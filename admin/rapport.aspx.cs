using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace gestiontaches
{
    public partial class rapport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }


            BindGridView(); 
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
            string que = "SELECT * FROM Utilisateur";
            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(strConn))
            {
                // Création d'un DataTable pour stocker les données récupérées pour la GridView1
                DataTable dataTable1 = new DataTable();
                // Création d'un DataTable pour stocker les données récupérées pour la GridView2
                DataTable dataTable2 = new DataTable();
                DataTable dataTable3 = new DataTable();
                DataTable dataTable4 = new DataTable();
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
                using (SqlDataAdapter adapter = new SqlDataAdapter(que, connection))
                {
                    adapter.Fill(dataTable4);
                }
                // Liaison des DataTable aux GridView respectifs pour afficher les données
                GridView1.DataSource = dataTable1;
                GridView1.DataBind();

                GridView2.DataSource = dataTable2;
                GridView2.DataBind();
                GridView3.DataSource = dataTable3;
                GridView3.DataBind();
                GridView4.DataSource = dataTable4;
                GridView4.DataBind();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=AffectationTache.doc");
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

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=TacheTerminer.doc");
            Response.ContentType = "application/vnd.ms-word";
            using (StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(stringWriter);
                GridView2.AllowPaging = false;
                this.BindGridView();
                GridView2.HeaderRow.BackColor = Color.White;
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
                GridView2.RenderControl(hw);
                Response.Output.Write(stringWriter.ToString());
                Response.Flush();
                Response.End();
            }
        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=Utilisateur.doc");
            Response.ContentType = "application/vnd.ms-word";
            using (StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(stringWriter);
                GridView4.AllowPaging = false;
                this.BindGridView();
                GridView4.CssClass = "custom-table"; // Ajoutez une classe CSS à votre GridView

                GridView4.HeaderRow.BackColor = Color.White;
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
                GridView4.RenderControl(hw);
                Response.Output.Write(stringWriter.ToString());
                Response.Flush();
                Response.End();
            }
        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=TacheEnTrainDeFaire.doc");
            Response.ContentType = "application/vnd.ms-word";
            using (StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(stringWriter);
                GridView3.AllowPaging = false;
                this.BindGridView();
                GridView3.HeaderRow.BackColor = Color.White;
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
                GridView3.RenderControl(hw);
                Response.Output.Write(stringWriter.ToString());
                Response.Flush();
                Response.End();
            }
        }
    }
}