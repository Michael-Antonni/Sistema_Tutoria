using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CRUD_02
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private Form activeForm = null;
        private void openChildForm(Form ChildForm)
        {
            if (activeForm != null) { activeForm.Close(); }
            activeForm = ChildForm;
            ChildForm.TopLevel = false;
            ChildForm.FormBorderStyle = FormBorderStyle.None;
            ChildForm.Dock = DockStyle.Fill;
            panelChildForm.Controls.Add(ChildForm);
            panelChildForm.Tag = ChildForm;
            ChildForm.BringToFront();
            ChildForm.Show();

        }

        private void btnDocente_Click(object sender, EventArgs e)
        {
            openChildForm(new FormDocente());
        }

        private void btnTutor_Click(object sender, EventArgs e)
        {
            openChildForm(new FormTutor());
        }

        private void btnAlumno_Click(object sender, EventArgs e)
        {
            openChildForm(new FormAlumno());
        }
    }
}
