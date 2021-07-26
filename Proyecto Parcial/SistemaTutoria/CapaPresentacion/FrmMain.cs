using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaEntidades;

namespace CapaPresentacion
{
    public partial class FrmMain : Form
    {
        public string Acceso = "";
        public FrmMain()
        {
            InitializeComponent();
        }

        private void CargarDatosUsuario()
        {
            labelUsuario.Text = E_InicioSesion.Usuario;
        }

        private void GestionarAcceso()
        {
            if (Acceso == "Director de Escuela")
            {

            }
            else if (Acceso == "Docente")
            {
                btnEstudiantes.Visible = false;
                btnDocentes.Visible = false;
            }
            else if (Acceso == "Estudiante")
            {
                btnTutoria.Visible = false;
            }
            else
            {
                if (MessageBox.Show("Acceso inválido", "Sistema de Tutoría", MessageBoxButtons.OK) == DialogResult.OK)
                    Application.Exit();
            }
        }

        private void FrmMain_Load(object sender, EventArgs e)
        {
            PantallaOk();
            CargarDatosUsuario();
            GestionarAcceso();
        }
        public void PantallaOk()
        {
            this.Size = Screen.PrimaryScreen.WorkingArea.Size;
            this.Location = Screen.PrimaryScreen.WorkingArea.Location;
        }
        public void selectedBotons(Bunifu.Framework.UI.BunifuFlatButton sender)
        {
           
            btnEstudiantes.Textcolor = Color.WhiteSmoke;
           

            sender.selected = true;

            if (sender.selected)
            {
                sender.Textcolor = Color.FromArgb(98, 195, 140);
            }
        }
        private void btnEstudiantes_Click(object sender,EventArgs e)
        {
            AbrirFormulriosEnWrapper(new FrmEstudiante());
        }
        private void btnDocentes_Click(object sender, EventArgs e)
        {
            AbrirFormulriosEnWrapper(new FrmDocente());
        }
        private Form FormActive = null;
        private void AbrirFormulriosEnWrapper(Form FormHijo)
        {
            if (FormActive != null)
                FormActive.Close();
            FormActive = FormHijo;
            FormHijo.TopLevel = false;
            FormHijo.Dock = DockStyle.Fill;
            Wrapper.Controls.Add(FormHijo);
            Wrapper.Tag = FormHijo;
            FormHijo.BringToFront();
            FormHijo.Show();

        }

        private void Salir_Click(object sender, EventArgs e)
        {
            DialogResult resultado = new DialogResult();
            Form mensaje = new FrmInformation("¿Desea cerrar sesión?");
            resultado = mensaje.ShowDialog();
            if (resultado == DialogResult.OK)
            {
                Application.Exit();
                this.Hide();
            }
        }

        
        private void btnTutoria_Click(object sender, EventArgs e)
        {
            
        }

        
    }
}
