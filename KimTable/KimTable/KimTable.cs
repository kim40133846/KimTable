using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using KimTable.Common;

namespace KimTable
{
    public partial class KimTable : Form
    {
        public KimTable()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            WorkTable wt = new WorkTable();
            this.Visible = false;

            if (boxUser.Text == "Kevin") wt.ShowDialog();
            else { System.Windows.Forms.MessageBox.Show("ERROR, el usuario ingresado no existe.","No se pudo iniciar sesion"); }

            this.Visible = true;
        }
    }
}
