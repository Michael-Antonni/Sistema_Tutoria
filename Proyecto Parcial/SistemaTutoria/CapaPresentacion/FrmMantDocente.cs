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
    public partial class FrmMantDocente : Form
    {
        public bool Update = false;
        E_Docente entities = new E_Docente();
        N_Docente business = new N_Docente();

        public FrmMantDocente()
        {

            InitializeComponent();
        }
        private void pictureBox1_Click(object sender, EventArgs e)
        {
            Close();
        }
        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Update == false)
            {
                try
                {

                    entities.Nombres = txtNombres.Text;
                    entities.ApellidosM = txtMaterno.Text;
                    entities.ApellidosP = txtPaterno.Text;
                    entities.TituloAcademico = txtTitulo.Text;
                    entities.CodEscuela = txtEscuela.Text;
                    entities.Categoria = txtCategoria.Text;

                    business.CreatingDocente(entities);
                    FrmSuccess.confirmacionForm("DOCENTE GUARDADO");
                    Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("No se pudo guardar la categoria" + ex);
                }
            }
            if (Update == true)
            {
                try
                {
                    entities.Nombres = txtNombres.Text;
                    entities.IdDocente = int.Parse(txtId.Text);
                    entities.ApellidosM = txtMaterno.Text;
                    entities.ApellidosP = txtPaterno.Text;
                    entities.TituloAcademico = txtTitulo.Text;
                    entities.CodEscuela = txtEscuela.Text;
                    entities.Categoria = txtCategoria.Text;

                    business.UpdatingDocente(entities);
                    
                    FrmSuccess.confirmacionForm("DOCENTE EDITADO");
                    Close();

                    Update = false;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("No se pudo editar la categoria" + ex);
                }
            }
        }
        

        private void textCategoria_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
