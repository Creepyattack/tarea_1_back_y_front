<%-- 
    Document   : index
    Created on : 22 oct. 2022, 11:02:01
    Author     : ppbet
--%>
<%@page import = "apis.api_empleado" %>
<%@page import= "java.util.HashMap" %>
<%@page import = "apis.Puesto" %>
<%@page import = "javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="#">Tabla Empleados</a>
</nav>
<br>
                <form action="sr_empleado" method="post" class="form-group" >
                <label for="lbl_id"><b>ID:</b></label>
                <input type="text" name="txt_id" id="txt_id" class="form-control" value = "0" readonly>
                <br>
                <label for="lbl_nombre"><b>Nombre:</b></label>
                <input type="text" name="txt_nombre" id="txt_nombre" class="form-control" placeholder="Ejemplo: Nombre1 Nombre2" required >
                <br>
                <label for="lbl_apellidos"><b>Apellido:</b></label>
                <input type="text" name="txt_apellido" id="txt_apellido" class="form-control" placeholder="Ejemplo: Apellido1 Apellido2" required >
                <br>
                <label for="lbl_direccion"><b>Direccion:</b></label>
                <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Ejemplo: No. Casa Calle Zona Ciudad" required >
                <br>
                <label for="lbl_telefono"><b>Telefono:</b></label>
                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ejemplo: 5555555555" required >
                <br>
                <label for="lbl_puesto"><b>Puesto:</b></label>
                <select name="drop_puesto" id="drop_puesto" class="form-control">
                   <%
                       Puesto puesto = new Puesto();
                       HashMap<String,String> drop = puesto.drop_puesto();
                       for(String i: drop.keySet()){
                           out.println("<option value='"+ i + "' >" + drop.get(i) + "</option>");
                        }
                    %>
                </select>
                <br>
                <label for="lbl_dpi"><b>Dpi:</b></label>
                <input type="number" name="txt_dpi" id="txt_dpi" class="form-control" placeholder="Ejemplo: 4564561" required >
                <br>
                <label for="lbl_fn"><b>Fecha de Nacimiento:</b></label>
                <input type="date" name="txt_fn" id="txt_fn" class="form-control"  >
                <br>
                <label for="lbl_fi"><b>Fecha de Ingreso:</b></label>
                <input type="datetime-local" name="txt_fi" id="txt_fi" class="form-control"  >
                <br>
                <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Agregar</button>
                 <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                 <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger" onclick="javascript:if(!confirm('Desea Eliminar?'))return false">Eliminar</button>
                </form>
    <table class="table">
    <thead class="thead-dark">
      <tr>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Direccion</th>
        <th>Telefono</th>
        <th>IdPuesto</th>
        <th>Dpi</th>
        <th>Fecha de Nacimiento</th>
        <th>Fecha de Ingreso</th>
      </tr>
    </thead>
    <tbody id="tbl_empleados">
       <%
        api_empleado api_c = new api_empleado();
        DefaultTableModel tabla = new DefaultTableModel();
        tabla = api_c.leer();
        for (int t=0;t<tabla.getRowCount();t++){
            out.println("<tr data-id ="+ tabla.getValueAt(t,0)+ " >");
            out.println("<td>"+ tabla.getValueAt(t,1)+"</td>");
            out.println("<td>"+ tabla.getValueAt(t,2)+"</td>");
            out.println("<td>"+ tabla.getValueAt(t,3)+"</td>");
            out.println("<td>"+ tabla.getValueAt(t,4)+"</td>");
            out.println("<td>"+ tabla.getValueAt(t,5)+"</td>");
            out.println("<td>"+ tabla.getValueAt(t,6)+"</td>");
            out.println("<td>"+ tabla.getValueAt(t,7)+"</td>");
            out.println("<td>"+ tabla.getValueAt(t,8)+"</td>");
            out.println("</tr>");
           }
       %>
    </tbody>
  </table>
    
    
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        <script type="text/javascript">
            $('#tbl_empleados').on('click','tr td',function(evt){
               var target,id,nombre,apellido,direccion,telefono,id_p,dpi,nacimiento,ingreso;
               target = $(event.target);
               id = target.parent().data('id');
               nombre = target.parent("tr").find("td").eq(0).html(); 
               apellido = target.parent("tr").find("td").eq(1).html();
               direccion = target.parent("tr").find("td").eq(2).html(); 
               telefono = target.parent("tr").find("td").eq(3).html();
               id_p = target.parent("tr").find("td").eq(4).html(); 
               dpi = target.parent("tr").find("td").eq(5).html();
               nacimiento = target.parent("tr").find("td").eq(6).html();
               ingreso = target.parent("tr").find("td").eq(7).html();
               
               $("#txt_id").val(id);
               $("#txt_nombre").val(nombre);
               $("#txt_apellido").val(apellido);
               $("#txt_direccion").val(direccion);
               $("#txt_telefono").val(telefono);
               $("#drop_puesto").val(id_p);
               $("#txt_dpi").val(dpi);
               $("#txt_fn").val(nacimiento);
               $("#txt_fi").val(ingreso);
            });
            </script>
    </body>
</html>
