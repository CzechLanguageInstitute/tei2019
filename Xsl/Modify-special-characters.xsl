<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:rep="http://vokabular.ujc.cas.cz/ns/xslt/replace" exclude-result-prefixes="xd tei" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 23, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Upraví transliteraci, tj. převede neobvyklé znaky na kombinaci základního písmene a diakritiky.</xd:p>
      <xd:p>Řešení převzato z http://stackoverflow.com/questions/15947803/replace-multiple-characters-in-a-single-element-using-xslt</xd:p>
    </xd:desc>
  </xd:doc>
  <rep:reps>
    <rep>
      <old></old>
      <!--  -->
      <new>s̈</new>
    </rep>
    <rep>
      <old></old>
      <!--   -->
      <new>e̊</new>
    </rep>
  </rep:reps>
  <xsl:variable name="vReps" select="document('')/*/rep:reps/*" />
  <xsl:output method="xml" indent="no" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> Modify-special-characters </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:sic">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:call-template name="multiReplace" />
    </xsl:copy>
  </xsl:template>
  <xsl:template name="multiReplace">
    <xsl:param name="pText" select="." />
    <xsl:param name="pRep" select="$vReps[1]" />
    <xsl:choose>
      <xsl:when test="not($pRep)">
        <xsl:value-of select="$pText" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="vReplaced">
          <xsl:call-template name="replace">
            <xsl:with-param name="pText" select="$pText" />
            <xsl:with-param name="pOld" select="$pRep/old" />
            <xsl:with-param name="pNew" select="$pRep/new" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="multiReplace">
          <xsl:with-param name="pText" select="$vReplaced" />
          <xsl:with-param name="pRep" select="$pRep/following-sibling::*[1]" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="replace">
    <xsl:param name="pText" />
    <xsl:param name="pOld" />
    <xsl:param name="pNew" />
    <xsl:if test="$pText">
      <xsl:value-of select="substring-before(concat($pText,$pOld), $pOld)" />
      <xsl:if test="contains($pText, $pOld)">
        <xsl:value-of select="$pNew" />
        <xsl:call-template name="replace">
          <xsl:with-param name="pText" select="substring-after($pText, $pOld)" />
          <xsl:with-param name="pOld" select="$pOld" />
          <xsl:with-param name="pNew" select="$pNew" />
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <!--
	<xsl:template match="tei:sic/text()">
		<xsl:value-of select="replace(., '', 's&#x308;')" />
	</xsl:template>
-->
</xsl:stylesheet>