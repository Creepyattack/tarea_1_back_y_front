/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apis;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import javax.swing.table.DefaultTableModel;
/**
 *
 * @author ppbet
 */
public class api_empleado extends Persona{
    private int idPuesto;
    private String Dpi, Fecha_ingreso;
    private Conexion cn;
    public api_empleado(){
        
    }
    public api_empleado(int idPuesto, String Dpi, String Fecha_ingreso, int id, String nombre, String apellido, String direccion, String telefono, String fecha_nacimiento) {
        super(id, nombre, apellido, direccion, telefono, fecha_nacimiento);
        this.idPuesto = idPuesto;
        this.Dpi = Dpi;
        this.Fecha_ingreso = Fecha_ingreso;
    }

    public int getIdPuesto() {
        return idPuesto;
    }

    public void setIdPuesto(int idPuesto) {
        this.idPuesto = idPuesto;
    }

    public String getDpi() {
        return Dpi;
    }

    public void setDpi(String Dpi) {
        this.Dpi = Dpi;
    }

    public String getFecha_ingreso() {
        return Fecha_ingreso;
    }

    public void setFecha_ingreso(String Fecha_ingreso) {
        this.Fecha_ingreso = Fecha_ingreso;
    }
    
    private String get(){
        String salida="";
        try{
            URL url = new URL("https://localhost:5001/api/Empleados");
            HttpURLConnection c_api = (HttpURLConnection) url.openConnection();
            c_api.setRequestMethod("GET");
            c_api.setRequestProperty("Accept", "application/json");
            if(c_api.getResponseCode()==200){
                InputStreamReader entrada = new InputStreamReader(c_api.getInputStream());
                BufferedReader lectura = new BufferedReader(entrada);
                salida = lectura.readLine();
            }else{
                salida = "";
                System.out.println("No se puede conectar a la api: " + c_api.getResponseCode());
            }
            
            c_api.disconnect();
        }catch(IOException ex){
            System.out.println("Error api:" + ex.getMessage());
        }
        return salida;
    }
    
    
     public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            String encabezado[] = {"id","Nombre","Apellido","Direccion","Telefono","idPuesto","Dpi","Nacimiento","Ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[9];
            JSONArray arreglo = new JSONArray(get());
            for(int indice = 0; indice < arreglo.length();indice++){
               JSONObject atributo = arreglo.getJSONObject(indice);
               datos[0] = String.valueOf(atributo.getInt("idEmpleado"));
               datos[1] = atributo.getString("nombre");
               datos[2] = atributo.getString("apellido");
               datos[3] = atributo.getString("direccion");
               datos[4] = atributo.getString("telefono");
               datos[5] = String.valueOf(atributo.getInt("idPuesto"));
               datos[6] = atributo.getString("dpi");
               datos[7] = atributo.getString("fechaNacimiento");
               datos[8] = atributo.getString("fechaIngresoRegistro");
               tabla.addRow(datos);
               
            }
        }catch(JSONException ex){
            System.out.println("Error en la tabla:" + ex.getMessage());
        }
        return tabla;
    }
     
    @Override
    public int agregar(){
        int retorno = 0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query="INSERT INTO empleados(Nombre,Apellido,Direccion,Telefono,idPuesto,DPI,FechaNacimiento,FechaIngresoRegistro) VALUES(?,?,?,?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, this.getNombre());
            parametro.setString(2, this.getApellido());
            parametro.setString(3, this.getDireccion());
            parametro.setString(4, this.getTelefono());
            parametro.setInt(5, this.getIdPuesto());
            parametro.setString(6, this.getDpi());
            parametro.setString(7, this.getFecha_nacimiento());
            parametro.setString(8, this.getFecha_ingreso());

            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
            retorno = 0;
        }
         return retorno;
    } 
    
    @Override
    public int modificar(){
        int retorno = 0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query="UPDATE empleados SET Nombre=?,Apellido=?,Direccion=?,Telefono=?,idPuesto=?,DPI=?,FechaNacimiento=?,FechaIngresoRegistro=? WHERE idEmpleado=?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
             parametro.setString(1, this.getNombre());
            parametro.setString(2, this.getApellido());
            parametro.setString(3, this.getDireccion());
            parametro.setString(4, this.getTelefono());
            parametro.setInt(5, this.getIdPuesto());
            parametro.setString(6, this.getDpi());
            parametro.setString(7, this.getFecha_nacimiento());
            parametro.setString(8, this.getFecha_ingreso());
            parametro.setInt(9, this.getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
            retorno = 0;
        }
         return retorno;
    }
    
    @Override
    public int eliminar(){
      int retorno = 0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query="DELETE FROM empleados WHERE idEmpleado=?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
            retorno = 0;
        }
         return retorno;
    }
}
