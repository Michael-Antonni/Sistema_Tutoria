using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaNegocios;
using CapaEntidades;

namespace CapaPresentacion
{
    public partial class FrmEstudiante : Form
    {
        N_Estudiante oEstudiante = new N_Estudiante();
        public FrmEstudiante()
        {
            InitializeComponent();
            MostrarTablaEstudiante();
            OcultarMoverAncharColumnas();
        }
        public void OcultarMoverAncharColumnas()
        {
            TablaDocente.Columns[0].DisplayIndex = 8;//0
            TablaDocente.Columns[1].DisplayIndex = 8;//1

        }
        public void MostrarTablaEstudiante()
        {
            N_Estudiante oEstudiante = new N_Estudiante();
            TablaDocente.DataSource = oEstudiante.ListingStudents();
        }
        public void BuscarEstudiante(string search)
        {
            N_Estudiante oEstudiante = new N_Estudiante();////////////////////////////OJO///////////-_-
            TablaDocente.DataSource = oEstudiante.SearchingStudents(search);

        }
        public void textBuscar_TextChanged(object sender,EventArgs e)
        {
            BuscarEstudiante(textBuscar.Text);
        }
        private void btnNuevoEstudiante_Click(object sender, EventArgs e)
        {
            FrmMantEstudiante frm = new FrmMantEstudiante();
            frm.ShowDialog();
            frm.Update = false;
            MostrarTablaEstudiante();
          //  ShowTotal();
        }
        private void TablaEstudiante_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (TablaDocente.Rows[e.RowIndex].Cells["eliminar"].Selected)
            {
                Form message = new FrmInformation("¿ESTAS SEGURO DE ELIMINAR EL ESTUDIANTE?");
                DialogResult result = message.ShowDialog();

                if (result == DialogResult.OK)
                {
                    string delete = TablaDocente.Rows[e.RowIndex].Cells["CodEstudiante"].Value.ToString();
                    oEstudiante.DeletingStudents(delete);
                    FrmSuccess.confirmacionForm("ELIMINADO");
                    MostrarTablaEstudiante();
                   // ShowTotal();
                }
            }
            else if (TablaDocente.Rows[e.RowIndex].Cells["editar"].Selected)
            {
                FrmMantEstudiante frm = new FrmMantEstudiante();
                frm.Update = true;
                frm.txtCodEstudiante.Text = TablaDocente.Rows[e.RowIndex].Cells["CodEstudiante"].Value.ToString();
                frm.txtPaterno.Text = TablaDocente.Rows[e.RowIndex].Cells["APaterno"].Value.ToString();
                frm.txtMaterno.Text = TablaDocente.Rows[e.RowIndex].Cells["AMaterno"].Value.ToString();
                frm.txtNombres.Text= TablaDocente.Rows[e.RowIndex].Cells["Nombres"].Value.ToString();
                frm.txtSituacion.Text = TablaDocente.Rows[e.RowIndex].Cells["Situacion"].Value.ToString();
                frm.txtTutor.Text = TablaDocente.Rows[e.RowIndex].Cells["CodTutor"].Value.ToString();
                frm.txtEscuela .Text = TablaDocente.Rows[e.RowIndex].Cells["CodEscuela"].Value.ToString();
               
                frm.ShowDialog();
                MostrarTablaEstudiante();
                //ShowTotal();
            }
        }
        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void flowLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {

        }
    }
}
