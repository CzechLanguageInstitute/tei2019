<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" exclude-result-prefixes="xd" version="1.0">
  <xsl:variable name="lomitko" select="'/'" />
  <xsl:template match="foliace | paginace">
    <xsl:call-template name="zpracujFoliaci">
      <xsl:with-param name="konciMezerou" select="substring(., string-length(.), 1) = ' '" />
      <xsl:with-param name="cislo" select="normalize-space(.)" />
      <xsl:with-param name="change" select="@c:change" />
      <xsl:with-param name="type" select="@c:type" />
      <xsl:with-param name="subtype" select="@c:subtype" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="zpracujFoliaci">
    <xsl:param name="konciMezerou" />
    <xsl:param name="cislo" />
    <xsl:param name="change" />
    <xsl:param name="type" />
    <xsl:param name="subtype" />
    <xsl:variable name="obsahujeBisEtc">
      <xsl:choose>
        <xsl:when test="contains($cislo, ' bis ')      or contains($cislo, ' duodecies ')      or contains($cislo, ' octies ')      or contains($cislo, ' quater ')      or contains($cislo, ' quaterdecies ')      or contains($cislo, ' quinquies ')      or contains($cislo, ' septies ')      or contains($cislo, ' sexies ')      or contains($cislo, ' ter ')      or contains($cislo, ' terdecies ')      or contains($cislo, ' undecies ')">
          <xsl:value-of select="'true'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="''" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="contains($cislo, $lomitko)">
        <xsl:call-template name="zpracujFoliaci">
          <xsl:with-param name="cislo" select="substring-before($cislo, $lomitko)" />
          <xsl:with-param name="konciMezerou" select="$konciMezerou" />
          <xsl:with-param name="change" select="$change" />
          <xsl:with-param name="type" select="$type" />
          <xsl:with-param name="subtype" select="$subtype" />
        </xsl:call-template>
        <xsl:call-template name="zpracujFoliaci">
          <xsl:with-param name="cislo" select="substring-after($cislo, $lomitko)" />
          <xsl:with-param name="konciMezerou" select="$konciMezerou" />
          <xsl:with-param name="change" select="$change" />
          <xsl:with-param name="type" select="$type" />
          <xsl:with-param name="subtype" select="$subtype" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$cislo = 'b' or $cislo = 'a'">
        <xsl:call-template name="vlozCislo">
          <xsl:with-param name="cislo" select="$cislo" />
          <xsl:with-param name="prvek" select="'cb'" />
          <xsl:with-param name="mezera" select="$konciMezerou" />
          <xsl:with-param name="change" select="$change" />
          <xsl:with-param name="type" select="$type" />
          <xsl:with-param name="subtype" select="$subtype" />
        </xsl:call-template>
      </xsl:when>
      <!-- DODĚLAT i ostatní případy, kdy může obsahovat 'st.' a 'ed.' -->
      <xsl:when test="not(contains($cislo, 'ed.')) and not(contains($cislo, 'st.')) and boolean($obsahujeBisEtc) ">
        <xsl:call-template name="vlozCislo">
          <!-- folio -->
          <xsl:with-param name="prvek" select="'pb'" />
          <xsl:with-param name="cislo" select="$cislo" />
          <xsl:with-param name="mezera" select="$konciMezerou" />
          <xsl:with-param name="change" select="$change" />
          <xsl:with-param name="type" select="$type" />
          <xsl:with-param name="subtype" select="$subtype" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($cislo, ' ')">
        <xsl:call-template name="zpracujFoliaci">
          <xsl:with-param name="konciMezerou" select="$konciMezerou" />
          <xsl:with-param name="cislo" select="substring-before($cislo, ' ')" />
          <xsl:with-param name="change" select="$change" />
          <xsl:with-param name="type" select="$type" />
          <xsl:with-param name="subtype" select="$subtype" />
        </xsl:call-template>
        <xsl:call-template name="zpracujFoliaci">
          <xsl:with-param name="konciMezerou" select="$konciMezerou" />
          <xsl:with-param name="cislo" select="substring-after($cislo, ' ')" />
          <xsl:with-param name="change" select="$change" />
          <xsl:with-param name="type" select="$type" />
          <xsl:with-param name="subtype" select="$subtype" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains($cislo, 'ed.')">
            <xsl:call-template name="vlozCislo">
              <xsl:with-param name="prvek" select="'pb'" />
              <xsl:with-param name="cislo" select="substring-before($cislo, 'ed.')" />
              <xsl:with-param name="typ" select="'edition'" />
              <xsl:with-param name="mezera" select="$konciMezerou" />
              <xsl:with-param name="change" select="$change" />
              <xsl:with-param name="type" select="$type" />
              <xsl:with-param name="subtype" select="$subtype" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="contains($cislo, 'st.')">
            <xsl:call-template name="vlozCislo">
              <xsl:with-param name="prvek" select="'pb'" />
              <xsl:with-param name="cislo" select="substring-before($cislo, 'st.')" />
              <xsl:with-param name="typ" select="'print'" />
              <xsl:with-param name="mezera" select="$konciMezerou" />
              <xsl:with-param name="change" select="$change" />
              <xsl:with-param name="type" select="$type" />
              <xsl:with-param name="subtype" select="$subtype" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="vlozCislo">
              <!-- folio -->
              <xsl:with-param name="prvek" select="'pb'" />
              <xsl:with-param name="cislo" select="$cislo" />
              <xsl:with-param name="mezera" select="$konciMezerou" />
              <xsl:with-param name="change" select="$change" />
              <xsl:with-param name="type" select="$type" />
              <xsl:with-param name="subtype" select="$subtype" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="vlozCislo">
    <xsl:param name="prvek" />
    <xsl:param name="cislo" />
    <xsl:param name="typ" />
    <xsl:param name="mezera" />
    <xsl:param name="change" />
    <xsl:param name="type" />
    <xsl:param name="subtype" />
    <xsl:element name="{$prvek}">
      <xsl:attribute name="n">
        <xsl:value-of select="$cislo" />
      </xsl:attribute>
      <xsl:if test="$typ">
        <xsl:attribute name="ed">
          <xsl:value-of select="$typ" />
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$change">
        <xsl:attribute name="change" namespace="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/">
          <xsl:value-of select="$change" />
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$type">
        <xsl:attribute name="type" namespace="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/">
          <xsl:value-of select="$type" />
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$subtype">
        <xsl:attribute name="subtype" namespace="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/">
          <xsl:value-of select="$subtype" />
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$mezera">
        <xsl:attribute name="rend">
          <xsl:text>space</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
    <xsl:if test="$mezera">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>