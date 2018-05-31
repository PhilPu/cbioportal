<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/xml; charset=UTF-8" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.mskcc.cbio.portal.util.GlobalProperties" %>

<%

String protocol = (request.isSecure()) ? "https" : "http";
String studyId = request.getParameter("studyId");
pageContext.setAttribute("studyId", request.getParameter("studyId"));
pageContext.setAttribute("serverRoot", protocol + "://" + request.getServerName());

%>

<c:import var="patientJson" url="${serverRoot}/api/studies/${studyId}/patients"/>

<%

String json = (String)pageContext.getAttribute("patientJson");
Object obj = new JSONParser().parse(json);
JSONArray ja = (JSONArray) obj;   
pageContext.setAttribute("patientList", ja);

%>

<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <c:forEach items="${patientList}" var="patient">
        <url>
            <loc><%=protocol%>://<%=request.getServerName()%>/patient?studyId=${studyId}&amp;caseId=<c:out value="${patient.get('patientId')}"/></loc> 
          </url>
    </c:forEach>
</sitemapindex>