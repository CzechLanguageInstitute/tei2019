<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 4, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Převod starých vordovských stylů na jejich nové ekvivalenty.</xd:p>
      <xd:p>Slouží k snadnému aktualizaci wordovské šablony, popř. zachování starších dokumentů, aniž by bylo nutné měnit následné transformační šablony.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> Rename-old-word-styles </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="Hyperlink">
    <xsl:element name="hypertextovy_odkaz">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_marginalni_soucasny">
    <xsl:element name="pripisek_marginalni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_interlinearni_soucasny">
    <xsl:element name="pripisek_interlinearni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Bible_Incipit">
    <xsl:element name="Incipit">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Bible_Explicit">
    <xsl:element name="Explicit">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="bible_iniciala">
    <xsl:element name="iniciala">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Bible_Nadpis_kapitoly">
    <xsl:element name="Nadpis">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Signet">
    <xsl:element name="Impresum">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="*[not(*) and text()]" priority="-5">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:if test="' ' = substring(., string-length(.) - 1)">
        <xsl:attribute name="xml:space">
          <xsl:text>preserve</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*[* and text()]" priority="-5">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:if test="' ' = substring(.//text()[last()], string-length(.) - 1)">
        <xsl:attribute name="xml:space">
          <xsl:text>preserve</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="Popisek_obrazku">
    <xsl:element name="Titulek_obrazku">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- Word 2016 zavedl styl Podnadpis, takže náš styl přejmenovává -->
  <xsl:template match="Podnadpis1">
    <xsl:element name="Podnadpis">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Subtitle">
    <xsl:element name="Podnadpis">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!--<xsl:template match="poznamka_pod_carou">
		<xsl:element name="poznamka">
			<xsl:apply-templates />
		</xsl:element>
	</xsl:template>-->
</xsl:stylesheet>