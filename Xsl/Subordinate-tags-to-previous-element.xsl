<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:include href="Subordinate-tags-to-previous-element-rekonstrukce.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 23, 2015</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Přesune vybrané elementy do předchozího prvku. Týká se např. emendace, transliterace, veřejné poznámky.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:param name="debug" select="false()" />
  <xsl:output omit-xml-declaration="no" indent="no" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> Subordinate-tags-to-previous-element </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="body/*/*[following-sibling::*[1]/self::transliterace]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:choose>
        <xsl:when test="following-sibling::*[2]/self::poznamka">
          <xsl:element name="transliterace">
            <xsl:choose>
              <xsl:when test="following-sibling::*[1][*]">
                <xsl:apply-templates select="following-sibling::*[1]/node()" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:copy-of select="following-sibling::*[1]/text()" />
              </xsl:otherwise>
            </xsl:choose>
            <!-- 2018-06-14 -->
            <!--<xsl:copy-of select="following-sibling::*[2]"/>-->
          </xsl:element>
          <!-- 2018-06-14 -->
          <xsl:copy-of select="following-sibling::*[2]" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="following-sibling::*[1]" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/transliterace[not(following-sibling::*[1]/self::transliterace)]" priority="10">
    <!--<xsl:comment> transliterace </xsl:comment>-->
  </xsl:template>
  <xsl:template match="body/*/*[following-sibling::*[1]/self::emendace and following-sibling::*[2]/self::pramen]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[2]" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/*[following-sibling::*[1]/self::emendace and following-sibling::*[2]/self::pramen and following-sibling::*[3]/self::transliterace]" priority="5">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[3]" />
    </xsl:copy>
  </xsl:template>
  <!-- -->
  <xsl:template match="body/*/*[    following-sibling::*[1]/self::emendace and    following-sibling::*[2]/self::pramen and    following-sibling::*[3]/self::transliterace and    following-sibling::*[4]/self::poznamka    ]" priority="10">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[3]" />
    </xsl:copy>
    <xsl:copy-of select="following-sibling::*[4]" />
  </xsl:template>
  <xsl:template match="body/*/*[   following-sibling::*[1]/self::poznamka[@c:change][not(node())] and   following-sibling::*[2]/self::emendace and    following-sibling::*[3]/self::pramen and    following-sibling::*[4]/self::poznamka]" priority="7">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[3]" />
      <xsl:copy-of select="following-sibling::*[4]" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/*[following-sibling::*[1]/self::emendace and    following-sibling::*[2]/self::pramen and    following-sibling::*[3]/self::poznamka]" priority="7">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[3]" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/*[following-sibling::*[1]/self::emendace and    following-sibling::*[2]/self::pramen and    following-sibling::*[3]/self::poznamka and   following-sibling::*[4]/self::transliterace   ]" priority="10">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[4]" />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[3]" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/*[   following-sibling::*[1]/self::hyperlemma and    following-sibling::*[2]/self::transliterace   ]" priority="12">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[2]" />
    </xsl:copy>
    <xsl:copy-of select="following-sibling::*[1]" />
  </xsl:template>
  <xsl:template match="body/*/*[   following-sibling::*[1]/self::lemma and    following-sibling::*[2]/self::hyperlemma and    following-sibling::*[3]/self::transliterace   ]" priority="15">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[3]" />
    </xsl:copy>
    <xsl:copy-of select="following-sibling::*[1]" />
    <xsl:copy-of select="following-sibling::*[2]" />
  </xsl:template>
  <xsl:template match="body/*/*[   following-sibling::*[1]/self::hyperlemma and    following-sibling::*[2]/self::poznamka   ]" priority="12">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[2]" />
    </xsl:copy>
    <!--	<xsl:copy-of select="following-sibling::*[1]"/>-->
  </xsl:template>
  <xsl:template match="body/*/*[   following-sibling::*[1]/self::hyperlemma and    following-sibling::*[2]/self::poznamka and   following-sibling::*[3]/self::transliterace   ]" priority="15">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[3]" />
      <xsl:copy-of select="following-sibling::*[2]" />
    </xsl:copy>
    <xsl:copy-of select="following-sibling::*[1]" />
  </xsl:template>
  <xsl:template match="body/*/*[   following-sibling::*[1]/self::hyperlemma and    following-sibling::*[2]/self::transliterace and   following-sibling::*[3]/self::poznamka   ]" priority="15">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[3]" />
    </xsl:copy>
    <xsl:copy-of select="following-sibling::*[1]" />
  </xsl:template>
  <xsl:template match="body/*/emendace[following-sibling::*[1]/self::pramen]">
    <!--		<xsl:message>x</xsl:message>-->
  </xsl:template>
  <xsl:template match="body/*/pramen[preceding-sibling::*[1]/self::emendace]" priority="10">
    <!--		<xsl:message>x</xsl:message>-->
  </xsl:template>
  <xsl:template match="body/*/hyperlemma[following-sibling::*[1]/self::transliterace]" priority="15">
    <!--		<xsl:message>x</xsl:message>-->
  </xsl:template>
  <xsl:template match="body/*/lemma[following-sibling::*[1]/self::hyperlemma]" priority="15">
    <!--		<xsl:message>x</xsl:message>-->
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="body/*/*[not(self::bible_cislo_verse) and    not(self::iniciala) and    not(self::foliace) and    not(self::relator) and   not(self::poznamka) and    not(self::pramen) and   not(self::hyperlemma) and   not(self::*[@c:change][not(node())])   ]   [following-sibling::*[1]/self::poznamka]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <!-- transliterace musí přijít k textu -->
  <xsl:template match="body/*/*[not(self::bible_cislo_verse) and   not(self::iniciala) and    not(self::foliace) and    not(self::relator) and    not(self::poznamka) and    not(self::pramen) and   not(self::hyperlemma)   ]   [following-sibling::*[1]/self::poznamka and    following-sibling::*[2]/self::transliterace]" priority="5">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/poznamka[preceding-sibling::*[1]/self::pramen][not(preceding-sibling::*[2]/self::emendace)]" priority="15">
    <xsl:copy-of select="." />
  </xsl:template>
  <!-- [not(seg[@c:change])] -->
  <xsl:template match="body/*[not(self::bible_cislo_verse)]/poznamka[not(following-sibling::*[1]/self::poznamka)][not(preceding-sibling::*[1][self::poznamka[@c:change]])]   [not(preceding-sibling::*[1][@c:change][not(node())])]   " priority="10">
    <xsl:if test="$debug">
      <xsl:message>x</xsl:message>
    </xsl:if>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Poznámka na začátku odstavce</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="body/*[not(self::bible_cislo_verse)]/node()[1][self::poznamka]" priority="12">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="body/*[not(self::bible_cislo_verse)][poznamka][count(*) = 1]" priority="12">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="hyperlemma[preceding-sibling::*[1]/self::text]   [following-sibling::*[1]/self::poznamka]   [following-sibling::*[2]/self::transliterace]   ">
    <!--		<xsl:comment> text - hyperlemma - poznamka - transliterace </xsl:comment>-->
  </xsl:template>
  <!--	<xsl:template match="bible_cislo_verse[following-sibling::*[1]/self::poznamka[not(following-sibling::*[1]/self::poznamka)]]" >
		<xsl:copy-of select="."/>
	</xsl:template>
-->
  <xsl:template match="transliterace[preceding-sibling::*[1]/self::relator]" priority="15">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="relator[following-sibling::*[1]/self::transliterace]" priority="15">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="poznamka[(preceding-sibling::*[1]/self::bible_cislo_verse or preceding-sibling::*[1]/self::iniciala or preceding-sibling::*[1]/self::foliace or preceding-sibling::*[1]/self::relator or preceding-sibling::*[1]/self::prmaen) and not(following-sibling::*[1]/self::poznamka)]" priority="15">
    <xsl:copy-of select="." />
  </xsl:template>
  <!-- KomKancTisk -->
  <xsl:template match="body/*/zive_zahlavi[following-sibling::*[1]/self::pramen]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:if test="following-sibling::*[2]/self::zive_zahlavi">
        <xsl:apply-templates select="following-sibling::*[2]/node()" />
      </xsl:if>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/pramen[preceding-sibling::*[1]/self::zive_zahlavi]">
    <xsl:if test="$debug">
      <xsl:message>x</xsl:message>
    </xsl:if>
  </xsl:template>
  <xsl:template match="body/*/zive_zahlavi[preceding-sibling::*[1]/self::pramen][preceding-sibling::*[2]/self::zive_zahlavi]">
    <xsl:if test="$debug">
      <xsl:message>x</xsl:message>
    </xsl:if>
  </xsl:template>
  <xsl:template match="body/*/*[not(self::bible_cislo_verse) and    not(self::iniciala) and    not(self::foliace) and    not(self::relator) and    not(self::pramen) and   not(self::hyperlemma)]   [following-sibling::*[1][self::*[@c:change][not(node())]]]   [following-sibling::*[2][self::poznamka[not(@c:change)]]]   [following-sibling::*[3][self::poznamka[not(@c:change)]]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[2]" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/*/*   [following-sibling::*[1]/self::emendace[@c:*][not(node())]]    [following-sibling::*[2]/self::poznamka]   [following-sibling::*[3]/self::emendace]    [following-sibling::*[4]/self::pramen]   [following-sibling::*[5]/self::lemma]   [following-sibling::*[6]/self::hyperlemma]   " priority="10">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[3]" />
      <xsl:copy-of select="following-sibling::*[4]" />
      <xsl:copy-of select="following-sibling::*[5]" />
      <xsl:copy-of select="following-sibling::*[6]" />
      <xsl:copy-of select="following-sibling::*[2]" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>