/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.36
 * Generated at: 2017-11-21 16:51:14 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class main_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1510990128605L));
    _jspx_dependants.put("jar:file:/C:/Users/DongKyun/Documents/GitHub/KHFinalProject/FinalWorkspace/FitnessGround/src/main/webapp/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_c_005fimport_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("    </style>\r\n");
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_c_005fimport_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <div id=\"page-wrapper\">\r\n");
      out.write("        <!-- Header -->\r\n");
      out.write("        <div id=\"header\">\r\n");
      out.write("            <!-- Inner -->\r\n");
      out.write("            ");
      if (_jspx_meth_c_005fimport_005f2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("            <!-- Nav -->\r\n");
      out.write("            ");
      if (_jspx_meth_c_005fimport_005f3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("        </div>\r\n");
      out.write("        <!-- Banner -->\r\n");
      out.write("        <section id=\"banner\">\r\n");
      out.write("            <header>\r\n");
      out.write("                <h2>Hi. You're looking at <strong>Helios</strong>.</h2>\r\n");
      out.write("                <p>\r\n");
      out.write("                    A (free) responsive site template by <a href=\"http://html5up.net\">HTML5 UP</a>. Built on <strong>skel</strong> and released under the <a href=\"http://html5up.net/license\">CCA</a> license.\r\n");
      out.write("                </p>\r\n");
      out.write("            </header>\r\n");
      out.write("        </section>\r\n");
      out.write("\r\n");
      out.write("        <!-- Carousel -->\r\n");
      out.write("        <section class=\"carousel\">\r\n");
      out.write("            <div class=\"reel\">\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic01.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Pulvinar sagittis congue</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic02.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Fermentum sagittis proin</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic03.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Sed quis rhoncus placerat</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic04.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Ultrices urna sit lobortis</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic05.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Varius magnis sollicitudin</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic01.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Pulvinar sagittis congue</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic02.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Fermentum sagittis proin</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic03.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Sed quis rhoncus placerat</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic04.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Ultrices urna sit lobortis</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("                <article>\r\n");
      out.write("                    <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic05.jpg\" alt=\"\" /></a>\r\n");
      out.write("                    <header>\r\n");
      out.write("                        <h3><a href=\"#\">Varius magnis sollicitudin</a></h3>\r\n");
      out.write("                    </header>\r\n");
      out.write("                    <p>Commodo id natoque malesuada sollicitudin elit suscipit magna.</p>\r\n");
      out.write("                </article>\r\n");
      out.write("\r\n");
      out.write("            </div>\r\n");
      out.write("        </section>\r\n");
      out.write("\r\n");
      out.write("        <!-- Main -->\r\n");
      out.write("        <div class=\"wrapper style2\">\r\n");
      out.write("\r\n");
      out.write("            <article id=\"main\" class=\"container special\">\r\n");
      out.write("                <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic06.jpg\" alt=\"\" /></a>\r\n");
      out.write("                <header>\r\n");
      out.write("                    <h2><a href=\"#\">Sed massa imperdiet magnis</a></h2>\r\n");
      out.write("                    <p>\r\n");
      out.write("                        Sociis aenean eu aenean mollis mollis facilisis primis ornare penatibus aenean. Cursus ac enim pulvinar curabitur morbi convallis. Lectus malesuada sed fermentum dolore amet.\r\n");
      out.write("                    </p>\r\n");
      out.write("                </header>\r\n");
      out.write("                <p>\r\n");
      out.write("                    Commodo id natoque malesuada sollicitudin elit suscipit. Curae suspendisse mauris posuere accumsan massa posuere lacus convallis tellus interdum. Amet nullam fringilla nibh nulla convallis ut venenatis purus sit arcu sociis. Nunc fermentum adipiscing tempor cursus nascetur adipiscing adipiscing. Primis aliquam mus lacinia lobortis phasellus suscipit. Fermentum lobortis non tristique ante proin sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus cubilia ultrices tempor sagittis. Nisl fermentum consequat integer interdum integer purus sapien. Nibh eleifend nulla nascetur pharetra commodo mi augue interdum tellus. Ornare cursus augue feugiat sodales velit lorem. Semper elementum ullamcorper lacinia natoque aenean scelerisque.\r\n");
      out.write("                </p>\r\n");
      out.write("                <footer>\r\n");
      out.write("                    <a href=\"#\" class=\"button\">Continue Reading</a>\r\n");
      out.write("                </footer>\r\n");
      out.write("            </article>\r\n");
      out.write("\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!-- Features -->\r\n");
      out.write("        <div class=\"wrapper style1\">\r\n");
      out.write("\r\n");
      out.write("            <section id=\"features\" class=\"container special\">\r\n");
      out.write("                <header>\r\n");
      out.write("                    <h2>Morbi ullamcorper et varius leo lacus</h2>\r\n");
      out.write("                    <p>Ipsum volutpat consectetur orci metus consequat imperdiet duis integer semper magna.</p>\r\n");
      out.write("                </header>\r\n");
      out.write("                <div class=\"row\">\r\n");
      out.write("                    <article class=\"4u 12u(mobile) special\">\r\n");
      out.write("                        <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic07.jpg\" alt=\"\" /></a>\r\n");
      out.write("                        <header>\r\n");
      out.write("                            <h3><a href=\"#\">Gravida aliquam penatibus</a></h3>\r\n");
      out.write("                        </header>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            Amet nullam fringilla nibh nulla convallis tique ante proin sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus cubilia ultrices tempor sagittis. Nisl fermentum consequat integer interdum.\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </article>\r\n");
      out.write("                    <article class=\"4u 12u(mobile) special\">\r\n");
      out.write("                        <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic08.jpg\" alt=\"\" /></a>\r\n");
      out.write("                        <header>\r\n");
      out.write("                            <h3><a href=\"#\">Sed quis rhoncus placerat</a></h3>\r\n");
      out.write("                        </header>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            Amet nullam fringilla nibh nulla convallis tique ante proin sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus cubilia ultrices tempor sagittis. Nisl fermentum consequat integer interdum.\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </article>\r\n");
      out.write("                    <article class=\"4u 12u(mobile) special\">\r\n");
      out.write("                        <a href=\"#\" class=\"image featured\"><img src=\"/fitnessground/resources/images/pic09.jpg\" alt=\"\" /></a>\r\n");
      out.write("                        <header>\r\n");
      out.write("                            <h3><a href=\"#\">Magna laoreet et aliquam</a></h3>\r\n");
      out.write("                        </header>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            Amet nullam fringilla nibh nulla convallis tique ante proin sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus cubilia ultrices tempor sagittis. Nisl fermentum consequat integer interdum.\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </article>\r\n");
      out.write("                </div>\r\n");
      out.write("            </section>\r\n");
      out.write("\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!-- Footer -->\r\n");
      out.write("        <div id=\"footer\">\r\n");
      out.write("            <div class=\"container\">\r\n");
      out.write("                <div class=\"row\">\r\n");
      out.write("\r\n");
      out.write("                    <!-- Tweets -->\r\n");
      out.write("                    <section class=\"4u 12u(mobile)\">\r\n");
      out.write("                        <header>\r\n");
      out.write("                            <h2 class=\"icon fa-twitter circled\"><span class=\"label\">Tweets</span></h2>\r\n");
      out.write("                        </header>\r\n");
      out.write("                        <ul class=\"divided\">\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"tweet\">\r\n");
      out.write("                                    Amet nullam fringilla nibh nulla convallis tique ante sociis accumsan.\r\n");
      out.write("                                    <span class=\"timestamp\">5 minutes ago</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"tweet\">\r\n");
      out.write("                                    Hendrerit rutrum quisque.\r\n");
      out.write("                                    <span class=\"timestamp\">30 minutes ago</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"tweet\">\r\n");
      out.write("                                    Curabitur donec nulla massa laoreet nibh. Lorem praesent montes.\r\n");
      out.write("                                    <span class=\"timestamp\">3 hours ago</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"tweet\">\r\n");
      out.write("                                    Lacus natoque cras rhoncus curae dignissim ultricies. Convallis orci aliquet.\r\n");
      out.write("                                    <span class=\"timestamp\">5 hours ago</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                        </ul>\r\n");
      out.write("                    </section>\r\n");
      out.write("\r\n");
      out.write("                    <!-- Posts -->\r\n");
      out.write("                    <section class=\"4u 12u(mobile)\">\r\n");
      out.write("                        <header>\r\n");
      out.write("                            <h2 class=\"icon fa-file circled\"><span class=\"label\">Posts</span></h2>\r\n");
      out.write("                        </header>\r\n");
      out.write("                        <ul class=\"divided\">\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"post stub\">\r\n");
      out.write("                                    <header>\r\n");
      out.write("                                        <h3><a href=\"#\">Nisl fermentum integer</a></h3>\r\n");
      out.write("                                    </header>\r\n");
      out.write("                                    <span class=\"timestamp\">3 hours ago</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"post stub\">\r\n");
      out.write("                                    <header>\r\n");
      out.write("                                        <h3><a href=\"#\">Phasellus portitor lorem</a></h3>\r\n");
      out.write("                                    </header>\r\n");
      out.write("                                    <span class=\"timestamp\">6 hours ago</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"post stub\">\r\n");
      out.write("                                    <header>\r\n");
      out.write("                                        <h3><a href=\"#\">Magna tempus consequat</a></h3>\r\n");
      out.write("                                    </header>\r\n");
      out.write("                                    <span class=\"timestamp\">Yesterday</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                            <li>\r\n");
      out.write("                                <article class=\"post stub\">\r\n");
      out.write("                                    <header>\r\n");
      out.write("                                        <h3><a href=\"#\">Feugiat lorem ipsum</a></h3>\r\n");
      out.write("                                    </header>\r\n");
      out.write("                                    <span class=\"timestamp\">2 days ago</span>\r\n");
      out.write("                                </article>\r\n");
      out.write("                            </li>\r\n");
      out.write("                        </ul>\r\n");
      out.write("                    </section>\r\n");
      out.write("\r\n");
      out.write("                    <!-- Photos -->\r\n");
      out.write("                    <section class=\"4u 12u(mobile)\">\r\n");
      out.write("                        <header>\r\n");
      out.write("                            <h2 class=\"icon fa-camera circled\"><span class=\"label\">Photos</span></h2>\r\n");
      out.write("                        </header>\r\n");
      out.write("                        <div class=\"row 25%\">\r\n");
      out.write("                            <div class=\"6u\">\r\n");
      out.write("                                <a href=\"#\" class=\"image fit\"><img src=\"/fitnessground/resources/images/pic10.jpg\" alt=\"\" /></a>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"6u$\">\r\n");
      out.write("                                <a href=\"#\" class=\"image fit\"><img src=\"/fitnessground/resources/images/pic11.jpg\" alt=\"\" /></a>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"6u\">\r\n");
      out.write("                                <a href=\"#\" class=\"image fit\"><img src=\"/fitnessground/resources/images/pic12.jpg\" alt=\"\" /></a>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"6u$\">\r\n");
      out.write("                                <a href=\"#\" class=\"image fit\"><img src=\"/fitnessground/resources/images/pic13.jpg\" alt=\"\" /></a>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"6u\">\r\n");
      out.write("                                <a href=\"#\" class=\"image fit\"><img src=\"/fitnessground/resources/images/pic14.jpg\" alt=\"\" /></a>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"6u$\">\r\n");
      out.write("                                <a href=\"#\" class=\"image fit\"><img src=\"/fitnessground/resources/images/pic15.jpg\" alt=\"\" /></a>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </section>\r\n");
      out.write("\r\n");
      out.write("                </div>\r\n");
      out.write("                <hr />\r\n");
      out.write("                <div class=\"row\">\r\n");
      out.write("                    <div class=\"12u\">\r\n");
      out.write("\r\n");
      out.write("                        <!-- Contact -->\r\n");
      out.write("                        <section class=\"contact\">\r\n");
      out.write("                            <header>\r\n");
      out.write("                                <h3>Nisl turpis nascetur interdum?</h3>\r\n");
      out.write("                            </header>\r\n");
      out.write("                            <p>Urna nisl non quis interdum mus ornare ridiculus egestas ridiculus lobortis vivamus tempor aliquet.</p>\r\n");
      out.write("                            <ul class=\"icons\">\r\n");
      out.write("                                <li><a href=\"#\" class=\"icon fa-twitter\"><span class=\"label\">Twitter</span></a></li>\r\n");
      out.write("                                <li><a href=\"#\" class=\"icon fa-facebook\"><span class=\"label\">Facebook</span></a></li>\r\n");
      out.write("                                <li><a href=\"#\" class=\"icon fa-instagram\"><span class=\"label\">Instagram</span></a></li>\r\n");
      out.write("                                <li><a href=\"#\" class=\"icon fa-pinterest\"><span class=\"label\">Pinterest</span></a></li>\r\n");
      out.write("                                <li><a href=\"#\" class=\"icon fa-dribbble\"><span class=\"label\">Dribbble</span></a></li>\r\n");
      out.write("                                <li><a href=\"#\" class=\"icon fa-linkedin\"><span class=\"label\">Linkedin</span></a></li>\r\n");
      out.write("                            </ul>\r\n");
      out.write("                        </section>\r\n");
      out.write("\r\n");
      out.write("                        <!-- Copyright -->\r\n");
      out.write("                        <div class=\"copyright\">\r\n");
      out.write("                            <ul class=\"menu\">\r\n");
      out.write("                                <li>&copy; Untitled. All rights reserved.</li>\r\n");
      out.write("                                <li>Design: <a href=\"http://html5up.net\">HTML5 UP</a></li>\r\n");
      out.write("                            </ul>\r\n");
      out.write("                        </div>\r\n");
      out.write("\r\n");
      out.write("                    </div>\r\n");
      out.write("\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_c_005fimport_005f4(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_c_005fimport_005f5(_jspx_page_context))
        return;
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_c_005fimport_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f0 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    _jspx_th_c_005fimport_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fimport_005f0.setParent(null);
    // /WEB-INF/views/main.jsp(4,4) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fimport_005f0.setUrl("./include/common/head.jsp");
    int[] _jspx_push_body_count_c_005fimport_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fimport_005f0 = _jspx_th_c_005fimport_005f0.doStartTag();
      if (_jspx_th_c_005fimport_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fimport_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fimport_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fimport_005f0.doFinally();
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.reuse(_jspx_th_c_005fimport_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f1 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    _jspx_th_c_005fimport_005f1.setPageContext(_jspx_page_context);
    _jspx_th_c_005fimport_005f1.setParent(null);
    // /WEB-INF/views/main.jsp(10,4) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fimport_005f1.setUrl("./include/common/headend.jsp");
    int[] _jspx_push_body_count_c_005fimport_005f1 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fimport_005f1 = _jspx_th_c_005fimport_005f1.doStartTag();
      if (_jspx_th_c_005fimport_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fimport_005f1[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fimport_005f1.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fimport_005f1.doFinally();
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.reuse(_jspx_th_c_005fimport_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f2(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f2 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    _jspx_th_c_005fimport_005f2.setPageContext(_jspx_page_context);
    _jspx_th_c_005fimport_005f2.setParent(null);
    // /WEB-INF/views/main.jsp(16,12) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fimport_005f2.setUrl("./include/main/maininner.jsp");
    int[] _jspx_push_body_count_c_005fimport_005f2 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fimport_005f2 = _jspx_th_c_005fimport_005f2.doStartTag();
      if (_jspx_th_c_005fimport_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fimport_005f2[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fimport_005f2.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fimport_005f2.doFinally();
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.reuse(_jspx_th_c_005fimport_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f3(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f3 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    _jspx_th_c_005fimport_005f3.setPageContext(_jspx_page_context);
    _jspx_th_c_005fimport_005f3.setParent(null);
    // /WEB-INF/views/main.jsp(19,12) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fimport_005f3.setUrl("./include/main/nav.jsp");
    int[] _jspx_push_body_count_c_005fimport_005f3 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fimport_005f3 = _jspx_th_c_005fimport_005f3.doStartTag();
      if (_jspx_th_c_005fimport_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fimport_005f3[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fimport_005f3.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fimport_005f3.doFinally();
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.reuse(_jspx_th_c_005fimport_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f4(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f4 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    _jspx_th_c_005fimport_005f4.setPageContext(_jspx_page_context);
    _jspx_th_c_005fimport_005f4.setParent(null);
    // /WEB-INF/views/main.jsp(322,4) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fimport_005f4.setUrl("./include/main/footer.jsp");
    int[] _jspx_push_body_count_c_005fimport_005f4 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fimport_005f4 = _jspx_th_c_005fimport_005f4.doStartTag();
      if (_jspx_th_c_005fimport_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fimport_005f4[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fimport_005f4.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fimport_005f4.doFinally();
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.reuse(_jspx_th_c_005fimport_005f4);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fimport_005f5(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f5 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    _jspx_th_c_005fimport_005f5.setPageContext(_jspx_page_context);
    _jspx_th_c_005fimport_005f5.setParent(null);
    // /WEB-INF/views/main.jsp(324,4) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fimport_005f5.setUrl("./include/common/end.jsp");
    int[] _jspx_push_body_count_c_005fimport_005f5 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fimport_005f5 = _jspx_th_c_005fimport_005f5.doStartTag();
      if (_jspx_th_c_005fimport_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fimport_005f5[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fimport_005f5.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fimport_005f5.doFinally();
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.reuse(_jspx_th_c_005fimport_005f5);
    }
    return false;
  }
}
