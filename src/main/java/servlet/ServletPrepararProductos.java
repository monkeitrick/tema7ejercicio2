package servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  




public class ServletPrepararProductos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String nombre="productos.txt";
	public HashMap<String, ArrayList<String>> listarProductos(){
		String linea;
		ArrayList<String> categoria100 =new ArrayList<String>();
		ArrayList<String> categoria200 =new ArrayList<String>();
		ArrayList<String> categoria300 =new ArrayList<String>();
		FileReader f;
		HashMap<String, ArrayList<String>> mapa=new HashMap<String, ArrayList<String>>();
		try {
			f = new FileReader(nombre);
			BufferedReader b = new BufferedReader(f);
			while((linea = b.readLine())!=null) { 
				String[] partes=linea.split(";");
				if(partes[0].equals("100")) {
					categoria100.add(partes[1]);
				}
				else if (partes[0].equals("200")) {
					categoria200.add(partes[1]);
				}
				else{
					categoria300.add(partes[1]);
				}
			}
			mapa.put("100", categoria100);
			mapa.put("200", categoria200);
			mapa.put("300", categoria300);
		} 
		catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
		return mapa;
	}
	
	
	public ArrayList<String> listarXProducto(String categoria){
		HashMap<String, ArrayList<String>> mapa=new HashMap<String, ArrayList<String>>();
		mapa=listarProductos();
		ArrayList<String> arrProductos= new ArrayList<String>();
		if(!categoria.equals("null")) {
			arrProductos=mapa.get(categoria);
		}
		else {
			for (String clave:mapa.keySet()) {
				ArrayList<String> valor = mapa.get(clave);
				arrProductos.addAll(valor);
			}
		}
		return arrProductos;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<String> listado= new ArrayList<String>();
		if(request.getParameter("categ")!=null) {
			listado=listarXProducto(request.getParameter("categ"));
		}
		else {
			listado=listarXProducto("null");
		}
		request.getSession().setAttribute("listado", listado);
		response.sendRedirect("compra.jsp");
	}
	
	
}
