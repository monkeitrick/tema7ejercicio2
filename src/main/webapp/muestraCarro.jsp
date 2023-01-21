<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<h1>Tu Carro</h1>
<ul>
<%
			for (int i=0;i<arrProductos.size();i++) {
				String valor=arrProductos.get(i);
				if(session.getAttribute(valor)!=null){
					out.println("<li>"+valor+": "+session.getAttribute(valor)+"unidades"+"</li>");
				}
			}
%>
</ul>