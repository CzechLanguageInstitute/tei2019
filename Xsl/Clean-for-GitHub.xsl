<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	exclude-result-prefixes="xd tei"
	version="1.0">
	<xsl:import href="Copy-xml-nodes.xsl"/>
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Sep 12, 2019</xd:p>
			<xd:p><xd:b>Author:</xd:b> Boris</xd:p>
			<xd:p></xd:p>
		</xd:desc>
	</xd:doc>
	
	
	<xsl:template match="comment()" />
	
	<xsl:template match="tei:div[@type='editorial'][not(node())]" />
	
</xsl:stylesheet>