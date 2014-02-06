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
				<xsl:for-each select="oo:values/oo:text">
					<xsl:call-template name="textTemplate">
          				<xsl:with-param name="item" select="."/>
          				<xsl:with-param name="preamble"><xsl:value-of select="$indent"/></xsl:with-param>
          				<xsl:with-param name="postamble">:</xsl:with-param>
        			</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<!-- Line without children, make this a list item -->
				<xsl:for-each select="oo:values/oo:text">
					<xsl:call-template name="textTemplate">
          				<xsl:with-param name="item" select="."/>
          				<xsl:with-param name="preamble"><xsl:value-of select="$indent"/>- </xsl:with-param>
          				<xsl:with-param name="postamble"></xsl:with-param>
        			</xsl:call-template>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Note -->
		<xsl:for-each select="oo:note/oo:text">
			<xsl:call-template name="textTemplate">
          		<xsl:with-param name="item" select="."/>
          		<xsl:with-param name="preamble"><xsl:value-of select="$indent"/><xsl:value-of select="$tab"/></xsl:with-param>
          		<xsl:with-param name="postamble"></xsl:with-param>
        	</xsl:call-template>		
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

  	<xsl:template name="textTemplate">
  		<xsl:param name="text" select="1"/>
  		<xsl:param name="preamble" select="2"/>
  		<xsl:param name="postamble" select="3"/>
  		<xsl:for-each select="oo:p">
<xsl:value-of select="$preamble"/>
  			<xsl:for-each select="oo:run">
<xsl:value-of select="oo:lit"/>
<xsl:value-of select="oo:lit/oo:cell/@href"/>
			</xsl:for-each>
<xsl:value-of select="$postamble"/><xsl:value-of select="$newline"/>
  		</xsl:for-each>
  	</xsl:template>
</xsl:stylesheet>