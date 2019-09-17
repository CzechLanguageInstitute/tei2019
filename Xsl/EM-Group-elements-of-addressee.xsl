<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs xd" version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> May 26, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xd:doc scope="component">
    <xd:desc>Výchozí prvek šablony</xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> EM-Group-elements-of-addressee </xsl:comment>
    <xsl:apply-templates select="comment()" />
    <xsl:apply-templates select="body" />
  </xsl:template>
  <!--<xsl:template match="body">
		<body>
			<xsl:choose>
				<xsl:when test="*[@type='editorial' and @subtype='comment']">
					<xsl:for-each-group select="*" group-adjacent="
						if(self::*[@type='editorial' ]) then
						(if (self::*[@subtype='comment']) then 0 else 1)
						else 
						(if(self::*[not(@type='editorial')]) then 3 else position())">
						<xsl:apply-templates select="." />
					</xsl:for-each-group>
				</xsl:when>
				<xsl:when test="*[@type='editorial' and @subtype='grant']">
					<xsl:for-each-group select="*" group-adjacent="if(self::*[@type='editorial' and @subtype='grant']) then 2 else position()">
						<xsl:apply-templates select="." />
					</xsl:for-each-group>
				</xsl:when>
				<xsl:when test="*[not(@type='editorial')]">
					<xsl:for-each-group select="*" group-adjacent="if(self::*[not(@type='editorial')]) then 3 else position()">
						<xsl:apply-templates select="." />
					</xsl:for-each-group>
				</xsl:when>
			</xsl:choose>
		</body>
	</xsl:template>
	-->
  <xsl:template match="body/div">
    <div>
      <xsl:copy-of select="@*" />
      <xsl:choose>
        <xsl:when test="div[@type='addressee']">
          <xsl:for-each-group select="*" group-adjacent="if(self::*[@type='addressee' ]) then 0 else position()">
            <xsl:apply-templates select="." />
          </xsl:for-each-group>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="*" />
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
  <xsl:template match="*[@type='addressee']">
    <!--		<xsl:comment> <xsl:value-of select="current-grouping-key()"></xsl:value-of> </xsl:comment>-->
    <div type="addressee">
      <xsl:apply-templates select="current-group()" mode="editorial-group" />
    </div>
  </xsl:template>
  <xsl:template match="div[@type='addressee']" mode="editorial-group" priority="15">
    <xsl:apply-templates />
  </xsl:template>
</xsl:stylesheet>