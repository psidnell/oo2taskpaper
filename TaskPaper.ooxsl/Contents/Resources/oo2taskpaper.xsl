<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:oo="http://www.omnigroup.com/namespace/OmniOutliner/v3"
	xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="oo"
	version="1.0">
	
	<xsl:output method='text' encoding='utf-8'/>
	
	<xsl:strip-space elements="*" />

	<xsl:variable name="newline"><xsl:text>
</xsl:text></xsl:variable>

	<xsl:variable name="tab"><xsl:text>	</xsl:text></xsl:variable>

	<xsl:template match="/">
		<xsl:for-each select="oo:outline/oo:root/oo:item">
			<xsl:call-template name="itemTemplate">
          		<xsl:with-param name="item" select="."/>
          		<xsl:with-param name="indent"></xsl:with-param>
        	</xsl:call-template>
    	</xsl:for-each>
	</xsl:template>

	<xsl:template name="itemTemplate">
		<xsl:param name="item" select="1"/>
		<xsl:param name="indent" select="2"/>
		<xsl:choose>
			<xsl:when test="oo:children">
				<!-- Line with children, make this a project -->
<xsl:value-of select="$indent"/><xsl:value-of select="oo:values/oo:text/oo:p/oo:run/oo:lit"/>:<xsl:value-of select="$newline"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Line without children, make this a list item -->
<xsl:value-of select="$indent"/>- <xsl:value-of select="oo:values/oo:text/oo:p/oo:run/oo:lit"/><xsl:value-of select="$newline"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Note -->
		<xsl:for-each select="oo:note/oo:text/oo:p">
<xsl:value-of select="$indent"/><xsl:value-of select="$tab"/><xsl:value-of select="oo:run/oo:lit"/><xsl:value-of select="$newline"/>
		</xsl:for-each>	
		<!-- Think of the children -->
		<xsl:for-each select="oo:children/oo:item">
			<xsl:call-template name="itemTemplate">
          		<xsl:with-param name="item" select="."/>
          		<!-- Increase the indent -->
          		<xsl:with-param name="indent"><xsl:value-of select="$tab"/><xsl:value-of select="$indent"/></xsl:with-param>
        	</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
  
</xsl:stylesheet>