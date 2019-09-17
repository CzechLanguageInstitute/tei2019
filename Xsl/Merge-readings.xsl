<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Substring-after-last.xsl" />
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> May 31, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Sloučí informace o různočtení do poznámky</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:strip-space elements="*" />
  <xd:doc>
    <xd:desc>
      <xd:p>//note[app[rdg and wit]][preceding-sibling::*[1][anchor[@type='end']]]</xd:p>
      <xd:pre>
        <anchor type="start" xml:id="ra.ID0EPG.3" />
        <text>vždy hledá zdraví</text>
        <anchor type="end" rend="space" xml:id="ra.ID0ERG.5" />
        <note>
          <app>
            <rdg>hledá vždy zdravie </rdg>
            <wit>PísPoslSoudA </wit>
          </app>
        </note>
      </xd:pre>
      <xd:pre>
        <anchor type="start" xml:id="ra.ID0EHBAC.3" />
        <text>se súdu</text>
        <anchor type="end" rend="space" xml:id="ra.ID0EJBAC.5" />
        <note>
          <app>
            <rdg>súdu se </rdg>
            <wit>PísPoslSoudA </wit>
          </app>
        </note>
      </xd:pre>
      <xd:p>//note[app[rdg and wit]][not(preceding-sibling::*[1][self::anchor[@type='end']])]</xd:p>
      <xd:pre>
        <text>mrtví i všichni </text>
        <note>
          <app>
            <rdg>všickni </rdg>
            <wit>PísPoslSoudA </wit>
          </app>
        </note>
      </xd:pre>
      <xd:pre>
        <l n="25">
          <text>Když čas přijde </text>
          <note>
            <app>
              <rdg>příde </rdg>
              <wit>PísPoslSoudA </wit>
            </app>
          </note>
          <text>dni súdnému,</text>
        </l>
      </xd:pre>
      <xd:pre>
        <l n="24">
          <text>když </text>
          <note>
            <app>
              <rdg>kdyžť </rdg>
              <wit>PísPoslSoudA </wit>
            </app>
          </note>
          <text>buoh káže z mrtvých státi</text>
          <note>
            <app>
              <rdg>vstáti</rdg>
              <wit>PísPoslSoudA</wit>
            </app>
          </note>
          <text>.</text>
        </l>
      </xd:pre>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" />
  <xsl:template match="/">
    <xsl:comment> Merge-readings </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="anchor[@type='end'][following-sibling::*[1][self::note[app[rdg and wit]]]]" />
  <xsl:template match="anchor[@type='start'][    following-sibling::*[2]    [self::anchor[@type='end']    [following-sibling::*[1][self::note[app[rdg and wit]]]]    ]    ]" />
  <xsl:template match="note[app[rdg and wit]][preceding-sibling::*[1][self::anchor[@type='end']]]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <app>
        <lem>
          <xsl:apply-templates select="preceding-sibling::anchor[@type='start'][1]/following-sibling::*[1]/node()" />
        </lem>
        <xsl:apply-templates select="app/rdg" />
        <xsl:apply-templates select="app/wit" />
      </app>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="note[app[rdg and wit]][not(preceding-sibling::*[1][self::anchor[@type='end']])]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <app>
        <lem>
          <xsl:apply-templates select="preceding-sibling::*[1]" mode="lem" />
        </lem>
        <xsl:apply-templates select="app/rdg" />
        <xsl:apply-templates select="app/wit" />
      </app>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*" mode="lem">
    <xsl:variable name="text" select="normalize-space(.)" />
    <xsl:choose>
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
  </xsl:template>
  <xsl:template match="app[rdg and wit]/rdg | app[rdg and wit]/wit">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <!--<xsl:choose>
				<xsl:when test="count(node()) = 1">
					<xsl:value-of select="normalize-space(.)"/>
				</xsl:when>
				<xsl:otherwise><xsl:apply-templates /></xsl:otherwise>
			</xsl:choose>-->
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>