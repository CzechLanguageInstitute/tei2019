<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="vwf" exclude-result-prefixes="xd vwf xs" version="2.0">
  <xsl:function name="vwf:last-position-of-many" as="xs:integer">
    <xsl:param name="text" />
    <xsl:param name="delimitator" />
    <xsl:variable name="znak">
      <xsl:call-template name="najitPosledniVyskytujiciSeZnak">
        <xsl:with-param name="text" select="$text" />
        <xsl:with-param name="interpunkce" select="$delimitator" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($znak) = 0">
        <xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string-length($text) - string-length(vwf:substring-after-last($text, $znak))" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:function name="vwf:first-position-of-many" as="xs:integer">
    <xsl:param name="text" />
    <xsl:param name="delimitator" />
    <xsl:variable name="znak">
      <xsl:call-template name="najitPrvniVyskytujiciSeZnak">
        <xsl:with-param name="text" select="$text" />
        <xsl:with-param name="interpunkce" select="$delimitator" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$znak = ''">
        <xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string-length(substring-before($text, $znak)) + string-length($znak)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xd:doc>
    <xd:desc>
      <xd:p>Najde první znak ze seznamu znaků, který se vysytuje v rámci textu. Pokud znak v textu neexistuje, vrátí prázdný řetězec.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template name="najitPrvniVyskytujiciSeZnak">
    <xsl:param name="text" />
    <xsl:param name="interpunkce" />
    <xsl:param name="zacatek" select="1" />
    <xsl:choose>
      <xsl:when test="string-length($text) &lt; $zacatek">
        <xsl:value-of select="''" />
      </xsl:when>
      <xsl:when test="translate(substring($text, $zacatek, 1), $interpunkce, '') = ''">
        <xsl:value-of select="substring($text, $zacatek, 1)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="najitPrvniVyskytujiciSeZnak">
          <xsl:with-param name="text" select="$text" />
          <xsl:with-param name="interpunkce" select="$interpunkce" />
          <xsl:with-param name="zacatek" select="$zacatek + 1" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Najde první znak ze seznamu znaků, který se vysytuje v rámci textu. Pokud znak v textu neexistuje, vrátí prázdný řetězec.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template name="najitPosledniVyskytujiciSeZnak">
    <xsl:param name="text" />
    <xsl:param name="interpunkce" />
    <xsl:param name="zacatek" select="string-length($text)" />
    <xsl:choose>
      <xsl:when test="$zacatek &lt; 0">
        <xsl:value-of select="''" />
      </xsl:when>
      <xsl:when test="translate(substring($text, $zacatek, 1), $interpunkce, '') = ''">
        <xsl:value-of select="substring($text, $zacatek, 1)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="najitPosledniVyskytujiciSeZnak">
          <xsl:with-param name="text" select="$text" />
          <xsl:with-param name="interpunkce" select="$interpunkce" />
          <xsl:with-param name="zacatek" select="$zacatek - 1" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--############################################################-->
  <!--## Template to determine Substring before last occurence  ##-->
  <!--## of a specific delemiter                                ##-->
  <!--## http://www.heber.it/?p=1278                            ##-->
  <!--############################################################-->
  <xsl:template name="substring-before-last">
    <!--passed template parameter -->
    <xsl:param name="string" />
    <xsl:param name="delimiter" />
    <xsl:choose>
      <xsl:when test="contains($string, $delimiter)">
        <!-- get everything in front of the first delimiter -->
        <xsl:value-of select="substring-before($string,$delimiter)" />
        <xsl:choose>
          <xsl:when test="contains(substring-after($string,$delimiter),$delimiter)">
            <xsl:value-of select="$delimiter" />
          </xsl:when>
        </xsl:choose>
        <xsl:call-template name="substring-before-last">
          <!-- store anything left in another variable -->
          <xsl:with-param name="string" select="substring-after($string,$delimiter)" />
          <xsl:with-param name="delimiter" select="$delimiter" />
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="substring-after-last">
    <xsl:param name="string" />
    <xsl:param name="delimiter" />
    <xsl:choose>
      <xsl:when test="contains($string, $delimiter)">
        <xsl:call-template name="substring-after-last">
          <xsl:with-param name="string" select="substring-after($string, $delimiter)" />
          <xsl:with-param name="delimiter" select="$delimiter" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Vloží text za hledaným řetězcem včetně hledaného řetězce.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template name="substring-after-including">
    <xsl:param name="text" />
    <xsl:param name="znak" />
    <xsl:choose>
      <xsl:when test="substring-after($text, $znak) = ''">
        <xsl:value-of select="''" />
      </xsl:when>
      <xsl:when test="starts-with($text, $znak)">
        <xsl:value-of select="$text" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring($text,  string-length($znak) + string-length(substring-before($text, $znak)))" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Vloží text za hledaným řetězcem včetně hledaného řetězce.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template name="substring-before-including">
    <xsl:param name="text" />
    <xsl:param name="znak" />
    <xsl:choose>
      <xsl:when test="substring-before($text, $znak) = ''">
        <xsl:value-of select="''" />
      </xsl:when>
      <!--			<xsl:when test="substring($text, string-length($text) - string-length($znak) +1) = $znak">
				<xsl:value-of select="$text"/>
			</xsl:when>-->
      <xsl:otherwise>
        <xsl:value-of select="concat(substring-before($text, $znak), $znak)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:function name="vwf:starts-with-one-from-many" as="xs:boolean">
    <xsl:param name="text" />
    <xsl:param name="characters" as="xs:string" />
    <xsl:choose>
      <xsl:when test="translate(substring($text, 1, 1), $characters,  '') = ''">
        <xsl:value-of select="true()" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="false()" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:function name="vwf:ends-with-one-of-character" as="xs:boolean">
    <xsl:param name="text" as="xs:string" />
    <xsl:param name="characters" as="xs:string" />
    <xsl:choose>
      <xsl:when test="translate(substring($text, string-length($text)), $characters,  '') = ''">
        <xsl:value-of select="true()" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="false()" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <!-- Převzato z http://users.atw.hu/xsltcookbook2/xsltckbk2-chp-2-sect-4.html -->
  <xsl:function name="vwf:substring-before-last">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:sequence select="if ($substr)     then     if (contains($input, $substr)) then     string-join(tokenize($input, $substr)    [position( ) ne last( )],$substr)     else ''    else $input" />
  </xsl:function>
  <xsl:function name="vwf:substring-after-last-from-many">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:variable name="znak">
      <xsl:call-template name="najitPosledniVyskytujiciSeZnak">
        <xsl:with-param name="text" select="$input" />
        <xsl:with-param name="interpunkce" select="$substr" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($znak) = 0">
        <xsl:value-of select="''" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="vwf:substring-after-last($input, $znak)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:function name="vwf:substring-after-first-from-many">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:variable name="znak">
      <xsl:call-template name="najitPrvniVyskytujiciSeZnak">
        <xsl:with-param name="text" select="$input" />
        <xsl:with-param name="interpunkce" select="$substr" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($znak) = 0">
        <xsl:value-of select="''" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="vwf:substring-after-first($input, $znak)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:function name="vwf:substring-after-first">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:variable name="delka" select="string-length(substring-before($input, $substr)) + 2" />
    <xsl:choose>
      <xsl:when test="$delka &gt; 0">
        <xsl:value-of select="substring($input, $delka)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="''" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:function name="vwf:substring-after-last">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:sequence select="if ($substr)     then    if (contains($input, $substr))    then tokenize($input, $substr)[last( )]     else ''     else $input" />
  </xsl:function>
  <xsl:function name="vwf:substring-before-last">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:param name="mask-regex" as="xs:boolean" />
    <xsl:variable name="matchstr" select="if ($mask-regex)     then replace($substr,'([.+?*^$])','\$1')    else $substr" />
    <xsl:sequence select="vwf:substring-before-last($input,$matchstr)" />
  </xsl:function>
  <xsl:function name="vwf:substring-before-last-from-many-including" as="xs:string">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:variable name="znak">
      <xsl:call-template name="najitPosledniVyskytujiciSeZnak">
        <xsl:with-param name="text" select="$input" />
        <xsl:with-param name="interpunkce" select="$substr" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="delka">
      <xsl:value-of select="string-length(vwf:substring-before-last($input,$znak)) + 1" />
    </xsl:variable>
    <xsl:value-of select="substring($input, 1, $delka)" />
  </xsl:function>
  <xsl:function name="vwf:substring-before-first-from-many-including" as="xs:string">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:variable name="znak">
      <xsl:call-template name="najitPrvniVyskytujiciSeZnak">
        <xsl:with-param name="text" select="$input" />
        <xsl:with-param name="interpunkce" select="$substr" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="delka">
      <xsl:value-of select="string-length(substring-before($input,$znak)) + 1" />
    </xsl:variable>
    <xsl:value-of select="substring($input, 1, $delka)" />
  </xsl:function>
  <xsl:function name="vwf:substring-before-first-from-many" as="xs:string">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:variable name="znak">
      <xsl:call-template name="najitPrvniVyskytujiciSeZnak">
        <xsl:with-param name="text" select="$input" />
        <xsl:with-param name="interpunkce" select="$substr" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="delka">
      <xsl:value-of select="string-length(substring-before($input,$znak))" />
    </xsl:variable>
    <xsl:value-of select="substring($input, 1, $delka)" />
  </xsl:function>
  <xsl:function name="vwf:substring-after-last">
    <xsl:param name="input" as="xs:string" />
    <xsl:param name="substr" as="xs:string" />
    <xsl:param name="mask-regex" as="xs:boolean" />
    <xsl:variable name="matchstr" select="if ($mask-regex)     then replace($substr,'([.+?*^$])','\$1')    else $substr" />
    <xsl:sequence select="vwf:substring-after-last($input,$matchstr)" />
  </xsl:function>
  <xsl:function name="vwf:ends-with" as="xs:boolean">
    <xsl:param name="input" />
    <xsl:param name="substr" />
    <xsl:choose>
      <xsl:when test="string-length($input) &lt; string-length($substr)">
        <xsl:value-of select="false()" />
      </xsl:when>
      <xsl:when test="string-length($input) eq string-length($substr)">
        <xsl:value-of select="$input = $substr" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring( $input, string-length($input) - string-length($substr) + 1 ) = $substr" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:template name="vlozit-text-pred-interpunkci">
    <xsl:param name="text" />
    <xsl:param name="hledanyZnak" select="''" />
    <xsl:variable name="znak">
      <xsl:choose>
        <xsl:when test="$hledanyZnak != ''">
          <xsl:value-of select="$hledanyZnak" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="najitPrvniVyskytujiciSeZnak">
            <xsl:with-param name="text" select="$text" />
            <xsl:with-param name="interpunkce" select="$interpunkcePlusMezera" />
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$znak = ''" />
      <xsl:otherwise>
        <!--<xsl:value-of select="substring-before(substring($text, string-length(substring-before($text, $znak)) + 1), $mezera)" />-->
        <xsl:value-of select="substring-before(substring($text, string-length(substring-before($text, $znak)) + 1), $znak)" />
      </xsl:otherwise>
    </xsl:choose>
    <!--		<xsl:value-of select="$mezera" />-->
  </xsl:template>
  <xsl:template name="vlozit-text-za-interpunkci-vcetne">
    <xsl:param name="text" />
    <xsl:param name="hledanyZnak" select="''" />
    <xsl:variable name="znak">
      <xsl:choose>
        <xsl:when test="$hledanyZnak != ''">
          <xsl:value-of select="$hledanyZnak" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="najitPrvniVyskytujiciSeZnak">
            <xsl:with-param name="text" select="$text" />
            <xsl:with-param name="interpunkce" select="$interpunkcePlusMezera" />
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$znak = ''" />
      <xsl:otherwise>
        <!--<xsl:value-of select="substring-before(substring($text, string-length(substring-before($text, $znak)) + 1), $mezera)" />-->
        <xsl:value-of select="substring($text, string-length(substring-before($text, $znak)) + 1)" />
      </xsl:otherwise>
    </xsl:choose>
    <!--		<xsl:value-of select="$mezera" />-->
  </xsl:template>
</xsl:stylesheet>