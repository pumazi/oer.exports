<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:cnx="http://cnx.rice.edu/cnxml"
  xmlns:cnxorg="http://cnx.rice.edu/system-info"
  xmlns:md="http://cnx.rice.edu/mdml"
  xmlns:col="http://cnx.rice.edu/collxml"
  xmlns:cnxml="http://cnx.rice.edu/cnxml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:q="http://cnx.rice.edu/qml/1.0"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:bib="http://bibtexml.sf.net/"
  xmlns:cc="http://web.resource.org/cc/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

<xsl:output method="text" encoding="ASCII"/>


<xsl:template match="md:repository">
<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="/">
    <xsl:apply-templates select="//md:repository"/>
</xsl:template>
</xsl:stylesheet>
