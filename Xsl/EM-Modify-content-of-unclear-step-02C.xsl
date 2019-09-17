<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" exclude-result-prefixes="xd vwf" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <!--	<xsl:import href="Textove_funkce.xsl"/>
-->
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Mar 25, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <!--	<xsl:variable name="mezera" select="' '"/>
	<xsl:variable name="interpunkcePlusMezera" select="concat('.,;?!)', $mezera)"/>
-->
  <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="no" />
  <xsl:template match="/">
    <xsl:comment> EM-Modify-content-of-unclear-step-02C </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <text>všem <unclear position="initial">d</unclear><unclear><supplied>ob</supplied></unclear><unclear position="final">ře</unclear> a prorocky budúcí</text>
      </xd:pre>
    </xd:desc>
    <xd:desc>
      <xd:p>Elementy <xd:b>unclear</xd:b>, které nemají atribut <xd:i>@position</xd:i> a které stojí mezi dvěma počátečním a koncovým elementem <xd:b>unclear</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="//unclear  [not(@position)]  [not(contains(., ' '))]  [  following-sibling::node()[1]  [self::unclear[@position='final']]  ]  [  preceding-sibling::node()[1]  [self::unclear[@position='initial']]  ] ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="position">
        <xsl:text>middle</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <text>
          <unclear>
            <supplied>T</supplied>
          </unclear>
          <unclear position="final">aké</unclear> kdož kolivěk</text>
      </xd:pre>
    </xd:desc>
    <xd:desc>
      <xd:p>Elementy <xd:b>unclear</xd:b>, které nemají atribut <xd:i>@position</xd:i> a které stojí před koncovým elementem <xd:b>unclear</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="//unclear  [not(@position)]  [not(contains(., ' '))]  [  following-sibling::node()[1]  [self::unclear[@position='final']]  ]  [  not(  preceding-sibling::node()[1]  [self::unclear]  )  ] ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="position">
        <xsl:text>initial</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <text>jako kerý <unclear position="initial">j</unclear><unclear><supplied>iný</supplied></unclear>. Protož </text>
      </xd:pre>
    </xd:desc>
    <xd:desc>
      <xd:p>Elementy <xd:b>unclear</xd:b>, které nemají atribut <xd:i>@position</xd:i> a které stojí před počátečním elementem <xd:b>unclear</xd:b>, aniž následuje koncový element <xd:b>unclear</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="   //unclear  [not(@position)]  [  preceding-sibling::node()[1][self::unclear[@position='initial']]  ]  [  not(  following-sibling::node()[1][self::unclear[@position='final']]  )  ]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="position">
        <xsl:text>final</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <text>j<unclear><supplied>Velik</supplied></unclear><unclear position="middle">o</unclear><unclear position="final"><supplied>st</supplied></unclear><text xml:space="preserve"> </text></text>
      </xd:pre>
    </xd:desc>
    <xd:desc>
      <xd:p>Elementy <xd:b>unclear</xd:b>, které nemají atribut <xd:i>@position</xd:i> a které stojí před středovým a koncovým elementem <xd:b>unclear</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="   //unclear [not(@position)] [following-sibling::node()[1][self::unclear[@position='middle']]] [following-sibling::node()[2][self::unclear[@position='final']]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="position">
        <xsl:text>initial</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>