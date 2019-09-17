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
  <xsl:preserve-space elements="unclear text" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xd:doc scope="component">
    <xd:desc>Výchozí prvek šablony</xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> Group-elements-to-div </xsl:comment>
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
  <xsl:template match="body">
    <body>
      <xsl:choose>
        <xsl:when test="*[@type='editorial' and @subtype='comment']">
          <xsl:for-each-group select="*" group-adjacent="       if(self::*[@type='editorial' ]) then       (if (self::*[@subtype='comment']) then 0 else 1)       else        (if(self::*[not(@type='editorial')]) then 3 else 4)">
            <xsl:apply-templates select="." />
          </xsl:for-each-group>
        </xsl:when>
        <xsl:when test="*[@type='editorial' and @subtype='grant']">
          <xsl:for-each-group select="*" group-adjacent="if(self::*[@type='editorial' and @subtype='grant']) then 2 else 5">
            <xsl:apply-templates select="." />
          </xsl:for-each-group>
        </xsl:when>
        <xsl:when test="*[not(@type='editorial')]">
          <xsl:for-each-group select="*" group-adjacent="if(self::*[not(@type='editorial')]) then 3 else 6">
            <xsl:apply-templates select="." />
          </xsl:for-each-group>
        </xsl:when>
      </xsl:choose>
    </body>
  </xsl:template>
  <xsl:template match="*[@type='editorial' and @subtype='comment']">
    <!--		<xsl:comment> <xsl:value-of select="current-grouping-key()"></xsl:value-of> </xsl:comment>-->
    <div type="editorial" subtype="comment">
      <xsl:apply-templates select="current-group()" mode="editorial-group"></xsl:apply-templates>
    </div>
  </xsl:template>
  <xsl:template match="div[@type='editorial' and @subtype='comment']" mode="editorial-group" priority="15">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="*[@type='editorial' and @subtype='comment']" mode="editorial-group">
    <!--		<xsl:comment> <xsl:value-of select="current-grouping-key()"></xsl:value-of> </xsl:comment>-->
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*[not(@type='editorial')]" mode="not-editorial-group">
    <!--		<xsl:comment> <xsl:value-of select="current-grouping-key()"></xsl:value-of> </xsl:comment>-->
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*[not(@type='editorial')]">
    <div>
      <xsl:apply-templates select="current-group()" mode="not-editorial-group"></xsl:apply-templates>
    </div>
  </xsl:template>
</xsl:stylesheet>