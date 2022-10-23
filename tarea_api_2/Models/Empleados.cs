using System.ComponentModel.DataAnnotations;

namespace tarea_api_2.Models{

    public class Empleados{
        [Key]
        public int idEmpleado{get; set;}
        public string Nombre{get; set;}
        public string Apellido{get; set;}
        public string Direccion{get; set;}
        public string Telefono{get; set;}
        public int idPuesto{get; set;}
        public string DPI{get; set;}
        public string FechaNacimiento{get; set;}
        public string FechaIngresoRegistro{get; set;}
    }
}