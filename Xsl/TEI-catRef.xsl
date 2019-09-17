<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:ev="http://www.daliboris.cz/schemata/prepisy.xsd" exclude-result-prefixes="xd ev" version="1.0">
  <xsl:template name="catRef">
    <xsl:variable name="category">
      <xsl:choose>
        <xsl:when test="ev:TypPrepisu/. = 'edice' and ev:Zpracovani/ev:CasoveZarazeni/. = 'DoRoku1500'">
          <xsl:text> #taxonomy-historical_text-old_czech</xsl:text>
        </xsl:when>
        <xsl:when test="ev:TypPrepisu/. = 'edice' and ev:Zpracovani/ev:CasoveZarazeni/. = 'DoRoku1800'">
          <xsl:text> #taxonomy-historical_text-medieval_czech</xsl:text>
        </xsl:when>
        <xsl:when test="ev:TypPrepisu/. = 'odborná literatura'">
          <xsl:text> #taxonomy-scholary_text</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="output">
      <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'StaroceskyKorpus')">
        <xsl:text> #output-text_bank-old_czech</xsl:text>
      </xsl:if>
      <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'StredoceskyKorpus')">
        <xsl:text> #output-text_bank-middle_czech</xsl:text>
      </xsl:if>
      <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'EdicniModul')">
        <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'StaroceskyKorpus')">
          <xsl:text> #output-editions-old_czech</xsl:text>
        </xsl:if>
        <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'StredoceskyKorpus')">
          <xsl:text> #output-editions-middle_czech</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'Slovnik')">
        <xsl:text> #output-dictionary</xsl:text>
      </xsl:if>
      <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'Mluvnice')">
        <xsl:text> #output-digitized-grammar</xsl:text>
      </xsl:if>
      <xsl:if test="contains(ev:Zpracovani/ev:ZpusobVyuziti, 'OdbornaLiteratura')">
        <xsl:text> #output-scholary_literature</xsl:text>
      </xsl:if>
    </xsl:variable>
    <xsl:if test="string-length($category) &gt; 0 or string-length($output) &gt; 0">
      <xsl:element name="catRef">
        <xsl:attribute name="target">
          <xsl:value-of select="normalize-space($category)" />
          <xsl:if test="string-length($output) &gt; 0">
            <xsl:value-of select="concat(' ', normalize-space($output))" />
          </xsl:if>
        </xsl:attribute>
      </xsl:element>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>