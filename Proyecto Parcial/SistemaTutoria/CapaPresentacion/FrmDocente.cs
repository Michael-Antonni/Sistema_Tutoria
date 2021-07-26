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
    public partial class FrmDocente : Form
    {
        N_Docente oDocente = new N_Docente();
        public FrmDocente()
        {
            InitializeComponent();
            MostrarTablaDocente();
            OcultarMoverAncharColumnas();
        }

        public void OcultarMoverAncharColumnas()
        {
            TablaDocente.Columns[0].DisplayIndex = 8;
            TablaDocente.Columns[1].DisplayIndex = 8;

        }
        public void MostrarTablaDocente()
        {
            N_Docente oDocente = new N_Docente();
            TablaDocente.DataSource = oDocente.ListingDocente();
        }
        public void BuscarDocente(string search)
        {
            N_Docente oDocente = new N_Docente();
            TablaDocente.DataSource = oDocente.SearchingDocente(search);

        }

        private void btnNuevoEstudiante_Click(object sender, EventArgs e)
        {
            FrmMantDocente frm = new FrmMantDocente();
            frm.ShowDialog();
            frm.Update = false;
            MostrarTablaDocente();
            //  ShowTotal();
        }

        private void TablaDocente_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            if (TablaDocente.Rows[e.RowIndex].Cells["eliminar"].Selected)
            {
                Form message = new FrmInformation("¿ESTAS SEGURO DE ELIMINAR EL DOCENTE?");
                DialogResult result = message.ShowDialog();

                if (result == DialogResult.OK)
                {
                    int delete = Convert.ToInt32(TablaDocente.Rows[e.RowIndex].Cells["CodDocente"].Value.ToString());
                    oDocente.DeletingDocente(delete);
                    FrmSuccess.confirmacionForm("ELIMINADO");
                    MostrarTablaDocente();
                    // ShowTotal();
                }
            }
            else if (TablaDocente.Rows[e.RowIndex].Cells["editar"].Selected)
            {
                FrmMantDocente frm = new FrmMantDocente();
                frm.Update = true;
                frm.txtId.Text = TablaDocente.Rows[e.RowIndex].Cells["IdDocente"].Value.ToString();
                // frm.textCodigo.Text = TablaDocente.Rows[e.RowIndex].Cells["CodEstudiante"].Value.ToString();
                frm.txtPaterno.Text = TablaDocente.Rows[e.RowIndex].Cells["APaterno"].Value.ToString();
                frm.txtMaterno.Text = TablaDocente.Rows[e.RowIndex].Cells["AMaterno"].Value.ToString();
                frm.txtNombres.Text = TablaDocente.Rows[e.RowIndex].Cells["Nombres"].Value.ToString();
                frm.txtTitulo.Text = TablaDocente.Rows[e.RowIndex].Cells["TituloAcademico"].Value.ToString();
                frm.txtEscuela.Text = TablaDocente.Rows[e.RowIndex].Cells["CodEscuela"].Value.ToString();
                frm.txtCategoria.Text = TablaDocente.Rows[e.RowIndex].Cells["Categoria"].Value.ToString();

                frm.ShowDialog();
                MostrarTablaDocente();
                //ShowTotal();
            }
        }

        private void textBuscar_TextChanged_1(object sender, EventArgs e)
        {
            BuscarDocente(textBuscar.Text);
        }
    }
}
