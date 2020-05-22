<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.*"%>
<%@page import="com.codoid.products.fillo.Fillo"%>
<%@page import="com.codoid.products.fillo.Recordset"%>

<%
     Fillo fillo = new Fillo();
           com.codoid.products.fillo.Connection connection = fillo.getConnection("webapps/ROOT/DB.xls");


		DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
		Document doc = docBuilder.parse(new File("webapps/ROOT/userinfo.xml"));
             doc.getDocumentElement().normalize();
             System.out.println("Root element of the doc is " + doc.getDocumentElement().getNodeName());
             NodeList listOfPersons = doc.getElementsByTagName("UserInfo");
             for (int s = 0; s < listOfPersons.getLength(); s++) {
                 Node firstPersonNode = listOfPersons.item(s);
                 if (firstPersonNode.getNodeType() == Node.ELEMENT_NODE) {
                     Element firstPersonElement = (Element) firstPersonNode;
                     NodeList nameList = firstPersonElement.getElementsByTagName("Name");
                     Element nameElement = (Element) nameList.item(0);
                     NodeList textFNList = nameElement.getChildNodes();
                     String name = ((Node) textFNList.item(0)).getNodeValue().trim();
                     NodeList emailList = firstPersonElement.getElementsByTagName("Email");
                     Element emailElement = (Element) emailList.item(0);
                     NodeList textLNList = emailElement.getChildNodes();
                     String email = ((Node) textLNList.item(0)).getNodeValue().trim();
                     
                     NodeList passwordList = firstPersonElement.getElementsByTagName("Subject");
                     Element passwordElement = (Element) passwordList.item(0);
                     NodeList passwordLNList = passwordElement.getChildNodes();
                     String password = ((Node) passwordLNList.item(0)).getNodeValue().trim();
                     
                     NodeList messageList = firstPersonElement.getElementsByTagName("Message");
                     Element messageElement = (Element) messageList.item(0);
                     NodeList messageLNList = messageElement.getChildNodes();
                     String message = ((Node) messageLNList.item(0)).getNodeValue().trim();
                     
                     int i = connection.executeUpdate("insert into Sheet1(name,email,subject,message) values('" + name + "','" + email + "','" + password + "','" + message + "')");
                     response.sendRedirect("hyperbole.html"); 
                 }
                 
             }
             

             connection.close();
         
     
    
%>
