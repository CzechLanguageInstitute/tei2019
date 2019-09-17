<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xd:doc>
    <xd:desc>
      <xd:p>Zjišťuje typ odstavce na základě jeho pojmenování. Rozlišuje text od editora, verše a text v tabulce.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template name="insert-paragraph-type">
    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="starts-with(name(), 'Edicni_komentar')">editorial</xsl:when>
        <xsl:when test="name() = 'Grantova_podpora'">editorial</xsl:when>
        <xsl:when test="name() = 'Vers'">vers</xsl:when>
        <xsl:when test="self::table">table</xsl:when>
        <xsl:when test="self::Polozka_rejstriku">index</xsl:when>
        <xsl:when test="parent::*/self::cell">table</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="$type != ''">
      <xsl:attribute name="type">
        <xsl:value-of select="$type" />
      </xsl:attribute>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>