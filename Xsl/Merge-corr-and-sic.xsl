<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Substring-after-last.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 3, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <!--	<xsl:output method="xml" indent="yes"/>-->
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> Merge-corr-and-sic </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="corr[@c:change][not(node())]" priority="2">
    <xsl:element name="note">
      <xsl:copy-of select="@*" />
      <xsl:element name="choice"></xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="corr">
    <xsl:element name="note">
      <xsl:copy-of select="@c:*" />
      <xsl:element name="choice">
        <xsl:copy-of select="." />
        <!-- kopie corr -->
        <xsl:if test="name(following-sibling::*[1]) != 'sic'">
          <xsl:message>
            <xsl:text>Za prvkem &lt;corr&gt; měl následovat prvek &lt;sic&gt;, ale místo toho následuje prvek &lt;</xsl:text>
            <xsl:value-of select="name(following-sibling::*[1])" />
            <xsl:text>&gt;</xsl:text>
          </xsl:message>
          <chyba>
            <prvek>
              <xsl:value-of select="name(.)" />
            </prvek>
            <popis>Měl by následovat prvek &lt;corr&gt;, místo toho následuje: <xsl:value-of select="name(following-sibling::*[1])" />&gt;</popis>
          </chyba>
        </xsl:if>
        <xsl:copy-of select="following-sibling::*[1]" />
        <!-- kopie sic -->
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="sic">
    <xsl:choose>
      <xsl:when test="preceding-sibling::*[1]/self::pb">
        <xsl:variable name="text">
          <xsl:value-of select="preceding-sibling::*[1]/@n" />
        </xsl:variable>
        <xsl:element name="note">
          <xsl:element name="choice">
            <xsl:element name="corr">
              <xsl:value-of select="$text" />
              <xsl:if test="preceding-sibling::*[1]/@rend='space'">
                <xsl:text></xsl:text>
              </xsl:if>
            </xsl:element>
            <xsl:element name="{name()}">
              <xsl:apply-templates />
              <xsl:if test="preceding-sibling::*[1]/@rend='space'">
                <xsl:text></xsl:text>
              </xsl:if>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="preceding-sibling::node()[normalize-space(.)!=''][1]/self::text and preceding-sibling::node()[normalize-space(.)!=''][1]/node()[last()]/self::unclear">
        <xsl:variable name="text">
          <xsl:value-of select="normalize-space(preceding-sibling::node()[normalize-space(.)!=''][1]/node()[last()]/self::unclear)" />
        </xsl:variable>
        <xsl:element name="note">
          <xsl:element name="choice">
            <xsl:element name="corr">
              <xsl:value-of select="$text" />
              <xsl:if test="preceding-sibling::*[1]/@rend='space'">
                <xsl:text></xsl:text>
              </xsl:if>
            </xsl:element>
            <xsl:element name="{name()}">
              <xsl:apply-templates />
              <xsl:if test="preceding-sibling::*[1]/@rend='space'">
                <xsl:text></xsl:text>
              </xsl:if>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="preceding-sibling::node()[normalize-space(.)!=''][1]/self::text and     preceding-sibling::node()[normalize-space(.)!=''][1]/node()[last()][self::hi[@xml:space='preserve'][.= ' ']] and     preceding-sibling::node()[normalize-space(.)!=''][1]/node()[last() - 1][self::unclear]">
        <xsl:variable name="text">
          <xsl:value-of select="normalize-space(preceding-sibling::node()[normalize-space(.)!=''][1]/node()[last() - 1]/self::unclear)" />
        </xsl:variable>
        <xsl:element name="note">
          <xsl:element name="choice">
            <xsl:element name="corr">
              <xsl:value-of select="$text" />
              <xsl:if test="preceding-sibling::*[1]/@rend='space'">
                <xsl:text></xsl:text>
              </xsl:if>
            </xsl:element>
            <xsl:element name="{name()}">
              <xsl:apply-templates />
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="   preceding-sibling::node()[normalize-space(.)!=''][1][self::text[not(contains(., ' '))]] and   preceding-sibling::*[2][self::fw] and   preceding-sibling::*[3][self::sic] and   preceding-sibling::*[4][self::pb] and   preceding-sibling::*[5][self::text[contains(., ' ')]]   ">
        <xsl:variable name="text">
          <xsl:value-of select="concat(preceding-sibling::*[5], preceding-sibling::*[1])" />
        </xsl:variable>
        <xsl:element name="note">
          <xsl:element name="choice">
            <xsl:element name="corr">
              <xsl:call-template name="substring-after-last">
                <xsl:with-param name="string" select="$text" />
                <xsl:with-param name="delimiter" select="' '" />
              </xsl:call-template>
            </xsl:element>
            <xsl:element name="{name()}">
              <xsl:apply-templates />
              <xsl:if test="preceding-sibling::*[1]/@rend='space'">
                <xsl:text></xsl:text>
              </xsl:if>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="name(preceding-sibling::*[1]) != 'corr'">
        <xsl:variable name="text">
          <xsl:choose>
            <xsl:when test="preceding::text()[normalize-space(.)!=''][1][not(contains(., ' '))]         and preceding::*[2][self::pb[not(@rend='space')]]       and preceding::*[2][self::pb[not(@rend='space')]]/preceding::text()[normalize-space(.)!=''][1]">
              <xsl:value-of select=" concat(preceding::*[2][self::pb[not(@rend='space')]]/preceding::text()[normalize-space(.)!=''][1], normalize-space(preceding::text()[normalize-space(.)!=''][1]))" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="normalize-space(preceding::text()[normalize-space(.)!=''][1])" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:element name="note">
          <xsl:element name="choice">
            <xsl:element name="corr">
              <xsl:choose>
                <xsl:when test="preceding-sibling::*[1]/self::anchor[@type='end']">
                  <xsl:value-of select="$text" />
                </xsl:when>
                <xsl:when test="contains($text, ' ')">
                  <xsl:call-template name="substring-after-last">
                    <xsl:with-param name="string" select="$text" />
                    <xsl:with-param name="delimiter" select="' '" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$text" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:element>
            <xsl:copy-of select="." />
          </xsl:element>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>