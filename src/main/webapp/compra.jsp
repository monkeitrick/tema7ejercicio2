<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<form action="compra.jsp" method="post">
			<table>
				<tr>
				    <th>Producto</th>
				    <th>Pedir</th>
			  	</tr>
			<%
				ArrayList<String> arrProductos= new ArrayList<String>();
				arrProductos=(ArrayList<String>)session.getAttribute("listado");
				for (int i=0;i<arrProductos.size();i++) {
			    	out.println("<tr>");
			    		String valor=arrProductos.get(i);
			    		String valorBoton=request.getParameter("botonProducto");
			    		out.println("<td>"+valor+"</td>");
			    		out.println("<td><button type='submit' value='"+valor+"' name='botonProducto'>Adquirir Unidad</button></td>");
			    		//System.out.println(session.getAttribute(arrProductos.get(i))+"1 "+i);
		    			if(session.getAttribute(valor)!=null){
		    				int reserva=(int)session.getAttribute(arrProductos.get(i));
		    				//System.out.println(request.getParameter(arrProductos.get(i)));
		    				//System.out.println(request.getParameter("botonProducto"));
		    				if(valorBoton.equals(valor)){	
			    				reserva=reserva+1;
				    		}
				    		//System.out.println(reserva+1);
				    		out.println("<td>"+reserva+" unidades</td>");
				    		session.setAttribute(valor, reserva);
				    		//System.out.println(reserva);
			    		}
		    			else{
		    				//System.out.println(request.getParameter(arrProductos.get(i))+"2");
		    				// lo he probado con valorBoton.equals(valor) pero no va
		    				if(valorBoton!=null){
		    					out.println("<td>1 unidades</td>");
		    					session.setAttribute(valor, 1);
				    		}
		    			}
		    			
			    	out.println("</tr>");		    	
			  	}
			%>
			</table>
			<%
			out.println("<h1>Tu Carro</h1>");
			out.println("<ul>");
			for (int i=0;i<arrProductos.size();i++) {
				String valor=arrProductos.get(i);
				if(session.getAttribute(valor)!=null){
					out.println("<li>"+valor+": "+session.getAttribute(valor)+"unidades"+"</li>");
				}
			}
			out.println("</ul>");
			%>
			<%@ include file="muestraCarro.jsp" %>
		</form>
	</body>
</html>