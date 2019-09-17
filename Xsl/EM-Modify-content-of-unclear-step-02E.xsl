<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" exclude-result-prefixes="xd vwf" version="2.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:import href="Text-functions.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Mar 25, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="mezera" select="' '" />
  <xsl:variable name="interpunkcePlusMezera" select="concat('.,;?!)', $mezera)" />
  <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="no" />
  <xsl:template match="/">
    <xsl:comment> EM-Modify-content-of-unclear-step-02E </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match="   text [preceding-sibling::node()[1][self::fw]] [preceding-sibling::node()[2][self::sic]] [preceding-sibling::node()[3][self::pb]] [preceding-sibling::node()[4][self::unclear[not(@position)]]]   ">
    <xsl:variable name="substring-before">
      <xsl:choose>
        <xsl:when test="vwf:substring-before-first-from-many(node()[1], $interpunkcePlusMezera) = ''">
          <xsl:value-of select="node()[1]" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="vwf:substring-before-first-from-many(node()[1], $interpunkcePlusMezera)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="substring-after">
      <xsl:value-of select="substring-after(node()[1], $substring-before)" />
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:element name="{preceding-sibling::node()[self::unclear][1]/name()}">
        <xsl:copy-of select="preceding-sibling::node()[self::unclear][1]/@*" />
        <xsl:attribute name="position">
          <xsl:text>initial</xsl:text>
        </xsl:attribute>
        <xsl:copy-of select="preceding-sibling::node()[self::unclear][1]/node()" />
      </xsl:element>
      <xsl:copy-of select="preceding-sibling::node()[self::pb][1]" />
      <xsl:copy-of select="preceding-sibling::node()[self::sic][1]" />
      <xsl:copy-of select="preceding-sibling::node()[self::fw][1]" />
      <xsl:element name="unclear">
        <xsl:attribute name="position">
          <xsl:text>final</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="$substring-before" />
      </xsl:element>
      <xsl:choose>
        <xsl:when test="$substring-after = ' '">
          <hi xml:space="preserve">
            <xsl:value-of select="$substring-after" />
          </hi>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$substring-after" />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="node()[position() &gt; 1]" />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <text>
          <supplied>jakž </supplied>
          <unclear>
            <supplied>m</supplied>
          </unclear>
          <text>ohúce hřiech jeho </text>
          <supplied>tajiti. </supplied>
        </text>
      </xd:pre>
    </xd:desc>
    <xd:desc>
      <xd:p>Elementy <xd:b>text</xd:b>, které nezačínají interpunkcí a před nimiž předchází element <xd:b>unclear</xd:b>, který nemá atribut <xd:i>@position</xd:i>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="text [preceding-sibling::node()[1][self::fw]] [preceding-sibling::node()[2][self::pb]] [preceding-sibling::node()[3][self::unclear[not(@position)]]] | text [preceding-sibling::node()[1][self::pb]] [preceding-sibling::node()[2][self::unclear[not(@position)]]] ">
    <xsl:variable name="substring-before">
      <xsl:choose>
        <xsl:when test="vwf:substring-before-first-from-many(node()[1], $interpunkcePlusMezera) = ''">
          <xsl:value-of select="node()[1]" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="vwf:substring-before-first-from-many(node()[1], $interpunkcePlusMezera)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="substring-after">
      <xsl:value-of select="substring-after(node()[1], $substring-before)" />
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:element name="{preceding-sibling::node()[self::unclear][1]/name()}">
        <xsl:copy-of select="preceding-sibling::node()[self::unclear][1]/@*" />
        <xsl:attribute name="position">
          <xsl:text>initial</xsl:text>
        </xsl:attribute>
        <xsl:copy-of select="preceding-sibling::node()[self::unclear][1]/node()" />
      </xsl:element>
      <xsl:copy-of select="preceding-sibling::node()[self::pb][1]" />
      <xsl:copy-of select="preceding-sibling::node()[1][self::fw]" />
      <xsl:element name="unclear">
        <xsl:attribute name="position">
          <xsl:text>final</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="$substring-before" />
      </xsl:element>
      <xsl:choose>
        <xsl:when test="$substring-after = ' '">
          <hi xml:space="preserve">
            <xsl:value-of select="$substring-after" />
          </hi>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$substring-after" />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="node()[position() &gt; 1]" />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <l xml:id="ID0E2JCI.2332">
          <supplied>světa u tebe <note>Doplněno podle tisku uloženého v Národní knihovně ČR pod signaturou 54 K 023269. </note></supplied>
          <unclear>
            <supplied>ni</supplied>
          </unclear>
          <pb n="303" />
          <fw>D III</fw>
          <text>čímž <note>Rekonstruováno podle tisku uloženého v Národní knihovně ČR pod signaturou 54 K 023269. </note>jest;</text>
        </l>
      </xd:pre>
    </xd:desc>
    <xd:desc>Elementy<xd:b>unclear</xd:b>, které nemají atribut <xd:i>@position</xd:i> a za nimiž se nachází element <xd:b>text</xd:b>, který nezačíná interpunkcí. Tyto elementy se vypouštějí, neboť jsou zpracovány jinu šablonou.</xd:desc>
  </xd:doc>
  <xsl:template match="  unclear[not(@position)]  [following-sibling::node()[1][self::pb]] [following-sibling::node()[2][self::text]] | unclear[not(@position)]  [following-sibling::node()[1][self::pb]] [following-sibling::node()[2][self::fw]] [following-sibling::node()[3][self::text]] | unclear[not(@position)]  [following-sibling::node()[1][self::pb]] [following-sibling::node()[2][self::sic]] [following-sibling::node()[3][self::fw]] [following-sibling::node()[4][self::text]]  ">
    <!-- element se vyouští -->
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre></xd:pre>
      <unclear>
        <supplied>vše</supplied>
      </unclear>
      <text>
        <unclear position="initial">lik</unclear>
        <unclear position="final">
          <supplied>ou</supplied>
        </unclear>
      </text>
      <unclear>
        <supplied>ukři</supplied>
      </unclear>
      <text>
        <unclear position="initial">žova</unclear>
        <unclear position="final">
          <supplied>ný </supplied>
        </unclear>
      </text>
    </xd:desc>
    <xd:desc></xd:desc>
  </xd:doc>
  <xsl:template match="text [preceding-sibling::node()[1][self::unclear[not(@position)]]] [node()[1][self::unclear[@position='initial']]] [node()[2][self::unclear[@position='final']]] ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:element name="{preceding-sibling::node()[self::unclear[not(@position)]][1]/name()}">
        <xsl:copy-of select="preceding-sibling::node()[self::unclear[not(@position)]][1]/@*" />
        <xsl:attribute name="position">
          <xsl:text>initial</xsl:text>
        </xsl:attribute>
        <xsl:copy-of select="preceding-sibling::node()[self::unclear[not(@position)]][1]/node()" />
      </xsl:element>
      <xsl:element name="{node()[self::unclear[@position='initial']][1]/name()}">
        <xsl:copy-of select="node()[self::unclear[@position='initial']][1]/@*" />
        <xsl:attribute name="position">
          <xsl:text>middle</xsl:text>
        </xsl:attribute>
        <xsl:copy-of select="node()[self::unclear[@position='initial']][1]/node()" />
      </xsl:element>
      <xsl:apply-templates select="node()[position() &gt; 1]" />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match=" pb  [preceding-sibling::node()[1][self::unclear[not(@position)]]] [following-sibling::node()[1][self::text]] | pb  [preceding-sibling::node()[1][self::unclear[not(@position)]]] [following-sibling::node()[1][self::fw]] [following-sibling::node()[2][self::text]] | pb  [preceding-sibling::node()[1][self::unclear[not(@position)]]] [following-sibling::node()[1][self::sic]] [following-sibling::node()[2][self::fw]] [following-sibling::node()[3][self::text]]   ">
    <!--		element se vypouští -->
  </xsl:template>
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match="   fw  [preceding-sibling::node()[2][self::unclear[not(@position)]]] [preceding-sibling::node()[1][self::pb]] [following-sibling::node()[1][self::text]] | fw  [preceding-sibling::node()[3][self::unclear[not(@position)]]] [preceding-sibling::node()[2][self::pb]] [following-sibling::node()[1][self::text]]   ">
    <!--		element se vypouští -->
  </xsl:template>
  <xsl:template match=" sic  [preceding-sibling::node()[2][self::unclear[not(@position)]]] [preceding-sibling::node()[1][self::pb]] [following-sibling::node()[1][self::fw]] [following-sibling::node()[2][self::text]]    ">
    <!--		element se vypouští -->
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <unclear>
          <supplied>vše</supplied>
        </unclear>
        <text>
          <unclear position="initial">lik</unclear>
          <unclear position="final">
            <supplied>ou</supplied>
          </unclear>
        </text>
      </xd:pre>
    </xd:desc>
    <xd:desc />
  </xd:doc>
  <xsl:template match=" unclear[not(@position)] [  following-sibling::node()[1][self::text]  [node()[1][self::unclear[@position='initial']]]  [node()[2][self::unclear[@position='final']]] ] ">
    <!-- element se vyouští -->
  </xsl:template>
</xsl:stylesheet>