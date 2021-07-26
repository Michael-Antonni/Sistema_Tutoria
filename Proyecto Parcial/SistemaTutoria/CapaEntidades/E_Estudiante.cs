using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Estudiante
    {
        private string _CodEstudiante;
        private string _ApellidosP;
        private string _ApellidosM;
        private string _Nombres;
        private string _Situacion;
        private string _CodTutor;
        private string _CodEscuela;
        private string search;
        public string CodEstudiante { get => _CodEstudiante; set => _CodEstudiante = value; }
        public string Nombres { get => _Nombres; set => _Nombres = value; }
        public string ApellidosM { get => _ApellidosM; set => _ApellidosM = value; }
        public string ApellidosP { get => _ApellidosP; set => _ApellidosP = value; }
        public string Situacion { get => _Situacion; set => _Situacion = value; }
        public string CodTutor { get => _CodTutor; set => _CodTutor = value; }
        public string CodEscuela { get => _CodEscuela; set => _CodEscuela = value; }
        public string Search { get => search; set => search = value; }
    }
}
