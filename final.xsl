<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
  <xsl:output name="personal-info-format" method="xhtml" indent="yes"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 STRICT//EN"/>
  <xsl:output name="personal-info-format02" method="xhtml" indent="yes"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 STRICT//EN"/>
  <xsl:output method="html" indent="yes" name="html"/>
  <xsl:variable name="count">1</xsl:variable>
  <xsl:template match="/">
    <xsl:result-document href="myinfo.html" format="personal-info-format">
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
          <title>My Contacts</title>
          <style type="text/css">
            table {border: 1px solid black;}
            td {border: 1px solid black;}
            tr.Personal {background-color: yellow;}
            tr.Work {background-color: blue;}
            tr.Family {background-color: green;}
          </style>
        </head>
        <body style="background-color:lightgray;">
          <table>
            <tbody>
              <tr>
                <xsl:for-each-group select="/Contacts/Contact[1]/child::*" group-by="name()">
                  <th>
                    <xsl:value-of select="name()"/>
                  </th>
                  <!-- creates the table's headers -->
                </xsl:for-each-group>
                <th>Group</th>
              </tr>
              <xsl:apply-templates select="//Contact"/>
            </tbody>
          </table>
        </body>
      </html>
    </xsl:result-document>
    <!-- end result-document personal-info-format -->
    <xsl:result-document href="myinfo02.html" format="personal-info-format02">
      <html>
        <head>
          <title>My Contacts by Type</title>
          <style type="text/css">
            table {border: 1px solid black;}
            td {border:1px solid black;}
            h3 {text-align:center;}
            tr.Personal {background-color:yellow;}
            tr.Work {background-color:blue;}
            tr.Family {background-color:green;}
          </style>
        </head>
        <body>
          <xsl:for-each-group select="//Contact" group-by="@Group">
            <h3>
              <xsl:value-of select="./@Group"/>
            </h3>
            <!-- generates the titles of the tables -->
            <table>
              <tbody>
                <tr>
                  <xsl:for-each select="//Contact[1]/child::*">
                    <th>
                      <xsl:value-of select="name()"/>
                    </th>
                  </xsl:for-each>
                  <!-- end for-each for each table's headers -->
                  <th>Group</th>
                </tr>
                <xsl:for-each select="current-group()">
                  <tr class="{current()/@Group}"><!-- sets the class to the value of the Group attribute for CSS purposes -->
                    <xsl:for-each select="./child::*">
                      <td>
                        <xsl:choose>
                          <xsl:when test="contains(name(),'Phones')">
                            <xsl:for-each select="Phone">
                              <xsl:value-of select="concat(./@Type,': ',.)"/>
                              <br/>
                            </xsl:for-each>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="."/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </xsl:for-each>
                    <td>
                      <xsl:value-of select="./@Group"/>
                    </td>
                  </tr>
                </xsl:for-each>
                <!-- end for-each table filler -->
              </tbody>
            </table>
            <br/>
          </xsl:for-each-group>
          <!-- end for-each-group info02 outer loop -->
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>
  <xsl:template match="Contact">
    <tr class="{current()/@Group}"><!-- sets the class to the value of the Group attribute for CSS purposes -->
      <xsl:for-each select="./child::*">
        <td>
          <xsl:choose>
            <xsl:when test="contains(name(),'Phones')">
              <xsl:for-each select="Phone">
                <xsl:value-of select="concat(./@Type,': ',.)"/>
                <br/>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </xsl:for-each>
      <td>
        <xsl:value-of select="./@Group"/>
      </td>
    </tr>
  </xsl:template>
  <!-- end template for each contact -->


</xsl:stylesheet>