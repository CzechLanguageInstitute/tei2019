<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="EM-Extract-input-text-Insert-paragraph-type.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Feb 15, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Extrahuje text z dokumentu po konverzi z DOCX na základní XML. Text slouží pro srovnání s vygenerovaným výstupem.</xd:p>
      <xd:p>Elementy interní povahy se z textu vynechávají.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:key name="poznamka" match="poznamka_pod_carou" use="@id" />
  <xd:doc>
    <xd:desc>
      <xd:p>Výchozí element pro konverzi textu. Rozděluje text na hlavní text a poznámky.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <body>
      <text>
        <xsl:apply-templates />
      </text>
      <notes>
        <xsl:apply-templates mode="notes" />
      </notes>
    </body>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>První tabulka v dokumentu obsahuje metadata. Ve finálním výstupu se neobjeví, proto se vynechává.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="table[1]" priority="5" />
  <xd:doc>
    <xd:desc>
      <xd:p>Každý element na druhé úrovni (tj. odstavec) se převede na samostatný element.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="body/*">
    <p>
      <xsl:call-template name="insert-paragraph-type" />
      <xsl:apply-templates />
    </p>
  </xsl:template>
  <xsl:template match="body/*[poznamka][count(node()) = 1]" priority="5">
    <!--		<xsl:comment> odstavec pouze s poznámkou </xsl:comment>-->
  </xsl:template>
  <!-- SlovKlem -->
  <xsl:template match="body/*[count(*[starts-with(name(), 'poznamka')]) = count(node())]" priority="8">
    <!--		<xsl:comment> odstavec pouze s poznámkou </xsl:comment>-->
  </xsl:template>
  <xsl:template match="body/*    [delimitator_ekvivalentu]    [count(*[contains(name(), 'poznamka')]) &gt; 0]   [count(*[contains(name(), 'poznamka')])  + 1 = count(node())]" priority="5">
    <!--		<xsl:comment> odstavec pouze s poznámkou </xsl:comment>-->
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Prázdné elementy (odstavce) se nepřevádějí.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="body/*[not(node())]" priority="5" />
  <xd:doc>
    <xd:desc>
      <xd:p>Interní poznámky se nepřevádějí.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="*[starts-with(name(), 'interni')]" />
  <xd:doc>
    <xd:desc>
      <xd:p>Poznámky v rámci hlavního textu se nepřevádějí. Převádějí se v samostatném oddílu pro poznámky.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="*[starts-with(name(), 'poznamka')]" priority="5" />
  <xd:doc>
    <xd:desc>
      <xd:p>Obsah některých elementů se přesouvá z hlavního textu do poznámek pod čarou.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="emendace | pramen | pramen_preskrtnute |    pramen_horni_index | transliterace | transliterace_horni_index |    transliterace_cizi_jazyk | transliterace_cizi_jazyk_horni_index |   transliterace_rozepsani_zkratky | delimitator_ekvivalentu |    ruznocteni | transliterace_zkratka | transliterace_zkratka_horni_index" />
  <xsl:template match="Anotace | Komercni_titul | Volny_radek " priority="10" />
  <xd:doc>
    <xd:desc>
      <xd:p>Některé elementy jsou pouze pomocné a do výstupu se nedostanou.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="hyperlemma | lemma | footnote_reference" />
  <xsl:template match="relator">
    <xsl:if test=". = '} '">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <!-- KomKancTisk -->
  <xsl:template match="foliace[contains(normalize-space(.), '/x')]" priority="3">
    <!-- do TEI se převede na poznámku: Pokračování textu na straně 406 -->
  </xsl:template>
  <xsl:template match="foliace[contains(normalize-space(.), '/x')]" priority="3" mode="notes">
    <xsl:value-of select="concat('Pokračování textu na straně ', substring-before(., '/'), '|')" />
  </xsl:template>
  <!-- AnsNauc -->
  <xsl:template match="foliace[normalize-space(.) ='b']" priority="2">
    <xsl:variable name="mezera" select="substring-after(., 'b')" />
    <xsl:if test="contains(normalize-space(preceding::foliace[1]), '/a')">
      <xsl:value-of select="concat(substring-before(preceding::foliace[1], '/a'), $mezera)" />
    </xsl:if>
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:template match="foliace">
    <xsl:choose>
      <xsl:when test="normalize-space(.) ='b'">
        <xsl:apply-templates />
      </xsl:when>
      <xsl:when test="contains(., '/') and normalize-space(.) = .">
        <xsl:value-of select="translate(., '/', '')" />
      </xsl:when>
      <xsl:when test="contains(., '/')">
        <xsl:value-of select="translate(., '/', ' ')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Prvky, které obsahují poznámku, se převádějí v rámci samostatného oddílu.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="body/*[poznamka] | body/*[*[starts-with(name(), 'transliterace')]] | body/*[pramen] |   body/*[foliace[contains(normalize-space(.), '/x')]]" mode="notes">
    <p>
      <xsl:call-template name="insert-paragraph-type" />
      <xsl:apply-templates mode="notes" />
    </p>
  </xsl:template>
  <xsl:template match="body/*[footnote_reference]" mode="notes" priority="10">
    <p>
      <xsl:call-template name="insert-paragraph-type" />
      <xsl:for-each select="footnote_reference">
        <xsl:apply-templates select="key('poznamka', .)/footnote_text" mode="notes" />
        <xsl:text>|</xsl:text>
      </xsl:for-each>
    </p>
  </xsl:template>
  <xsl:template match="text()">
    <xsl:choose>
      <!-- LekZen aj. -->
      <xsl:when test=". = '#' and parent::*/following-sibling::node()[1]/self::poznamka and count(parent::*/following-sibling::node()) &gt; 1 and    translate(substring(parent::*/following-sibling::node()[2]/text()[1], 1, 1), '.,?:!', '') = ''    ">
        <!-- značka před poznámkou a interpukncí -->
        <xsl:value-of select="." />
      </xsl:when>
      <xsl:when test=". = '#' and parent::*/following-sibling::node()[1]/self::poznamka and count(parent::*/following-sibling::node()) &gt; 1">
        <xsl:value-of select="." />
        <xsl:text></xsl:text>
      </xsl:when>
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     count(parent::*/following-sibling::node()[     (     contains(name(), 'poznamka') or      contains(name(), 'lemma') or      contains(name(), 'transliterace') or     contains(name(), 'emendace') or     contains(name(), 'pramen') or     contains(name(), 'delimitator_ekvivalentu')     )     ]     ) = count(parent::*/following-sibling::node())">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     (parent::*/following-sibling::node()[1]/self::poznamka or parent::*/following-sibling::node()[1]/self::poznamka_kurziva)     and count(parent::*/following-sibling::node()[1]/following-sibling::node()) = 0     ">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     parent::*/following-sibling::node()[1]/self::interni_poznamka     and count(parent::*/following-sibling::node()[1]/following-sibling::node()) = 0     ">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     parent::*/following-sibling::node()[1]/self::emendace and     parent::*/following-sibling::node()[2]/self::pramen and     count(parent::*/following-sibling::node()[2]/following-sibling::node()) = 0     ">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     parent::*/following-sibling::node()[1]/self::emendace and     parent::*/following-sibling::node()[2]/self::pramen and     parent::*/following-sibling::node()[3]/self::interni_poznamka and     count(parent::*/following-sibling::node()[3]/following-sibling::node()) = 0     ">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     parent::*/following-sibling::node()[1]/self::poznamka and     parent::*/following-sibling::node()[2]/self::interni_poznamka and     count(parent::*/following-sibling::node()[2]/following-sibling::node()) = 0     ">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <!-- KlarGlosA -->
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     parent::*/following-sibling::node()[1]/self::transliterace and     (     starts-with(parent::*/following-sibling::node()[2], ',')     or     starts-with(parent::*/following-sibling::node()[2], '.')     or     starts-with(parent::*/following-sibling::node()[2], ';')     )     ">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <!-- KlarGlosA -->
      <xsl:when test="substring(., string-length(.), 1) = ' ' and     parent::*/following-sibling::node()[1]/self::ruznocteni_autor and     (     starts-with(parent::*/following-sibling::node()[2], ',')     or     starts-with(parent::*/following-sibling::node()[2], '.')     or     starts-with(parent::*/following-sibling::node()[2], ';')     )     ">
        <xsl:value-of select="substring(., 1, string-length(.) -1)" />
      </xsl:when>
      <!-- Artik1544 -->
      <xsl:when test="preceding::node()[1]/parent::*[self::transliterace]     and     substring(., 1, 1) != ' '     and     substring(preceding::node()[2], string-length(preceding::node()[2]), 1) = ' '     ">
        <xsl:value-of select="." />
      </xsl:when>
      <!-- OlympiusKnizka1571 -->
      <xsl:when test="preceding::node()[1]/parent::*[self::transliterace]     and     substring(., 1, 1) != ' '     and     substring(preceding::node()[1], string-length(preceding::node()[1]), 1) = ' '     ">
        <xsl:value-of select="concat(' ', .)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Proroci</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="text[preceding-sibling::*[1]/self::bible_cislo_verse][. = '']">
    <xsl:text></xsl:text>
  </xsl:template>
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match="* | text()" mode="notes">
    <xsl:apply-templates mode="notes" />
  </xsl:template>
  <xsl:template match="table[1]" mode="notes" />
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match="*[starts-with(name(), 'poznamka')] | transliterace | transliterace_horni_index    | transliterace_zkratka | transliterace_zkratka_horni_index |    transliterace_cizi_jazyk | transliterace_cizi_jazyk_horni_index |    transliterace_rozepsani_zkratky |    pramen | pramen_preskrtnute | pramen_horni_index" mode="notes">
    <xsl:if test="normalize-space(.) != ''">
      <xsl:value-of select="concat(normalize-space(.), '|')" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="poznamka_pod_carou" priority="5" mode="notes">
    <!--<p><xsl:apply-templates mode="notes" /></p>-->
  </xsl:template>
  <xsl:template match="Hyperlink" mode="notes">
    <xsl:text>|</xsl:text>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="Edicni_komentar/Hyperlink | Grantova_podpora/Hyperlink" mode="notes" priority="5" />
  <xsl:template match="footnote_text/text" mode="notes">
    <xsl:choose>
      <xsl:when test="position() = 2 and starts-with(., ' ')">
        <!-- element sice začíná mezerou, ale mezera se dostane i do výstupního XML -->
        <xsl:value-of select="normalize-space(.)" />
        <xsl:if test="following-sibling::*[1]">
          <xsl:text></xsl:text>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="footnote_text/kurziva" mode="notes">
    <xsl:text>|</xsl:text>
    <xsl:apply-templates />
    <xsl:text>|</xsl:text>
  </xsl:template>
  <xsl:template match="footnote_text/footnote_reference" mode="notes" />
  <xsl:template match="row">
    <xsl:apply-templates />
    <xsl:text>//</xsl:text>
  </xsl:template>
  <xsl:template match="cell">
    <xsl:apply-templates />
    <xsl:text>|</xsl:text>
  </xsl:template>
  <xsl:template match="bible_cislo_kapitoly">
    <xsl:apply-templates />
    <xsl:if test="not(following-sibling::node()[1]/self::bible_cislo_verse) and    not(following-sibling::node()[1][starts-with(., ' ')])">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="bible_zkratka_knihy">
    <xsl:value-of select="normalize-space(.)" />
  </xsl:template>
</xsl:stylesheet>