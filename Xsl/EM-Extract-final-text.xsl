<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Feb 15, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="tei:teiHeader" />
  <xsl:template match="/">
    <body>
      <text>
        <xsl:apply-templates select="//tei:front/tei:div[@type = 'editorial']" />
        <xsl:apply-templates select="//tei:body" />
      </text>
      <notes>
        <xsl:apply-templates select="//tei:front | //tei:body" mode="notes" />
      </notes>
    </body>
  </xsl:template>
  <xsl:template match="tei:docTitle" />
  <xsl:template match="tei:div[@type = 'editorial']">
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Prázdné elementy (odstavce) se nepřevádějí.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="tei:body/*[not(node())] | tei:div/*[not(node())]" priority="5" />
  <xd:doc>
    <xd:desc>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xsl:template match="tei:p[not(node())][preceding-sibling::*[1]/self::tei:pb]" priority="7">
    <p>
      <xsl:call-template name="insert-paragraph-type">
        <xsl:with-param name="element" select="." />
      </xsl:call-template>
      <xsl:apply-templates select="preceding-sibling::*[1]/self::tei:pb" mode="pb" />
    </p>
  </xsl:template>
  <xsl:template match="tei:p | tei:head | tei:l | tei:list/tei:item | tei:table">
    <p>
      <xsl:call-template name="insert-paragraph-type">
        <xsl:with-param name="element" select="." />
      </xsl:call-template>
      <!-- TODO: vložení čísla stránky jen v určitých případech -->
      <xsl:choose>
        <xsl:when test="       parent::*/parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb[@ed = 'edition'] and       count(preceding-sibling::*) = 0 and       count(parent::*/preceding-sibling::*) = 0              ">
          <xsl:apply-templates select="parent::*/parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb" mode="pb" />
        </xsl:when>
        <!-- AnsNauc -->
        <xsl:when test="count(preceding-sibling::*) = 0       and parent::*/parent::*/parent::*/self::tei:body       and parent::*/parent::*/preceding-sibling::*[2]/self::tei:pb      and parent::*/parent::*/preceding-sibling::*[1]/self::tei:cb">
          <xsl:apply-templates select="parent::*/parent::*/preceding-sibling::*[2]/self::tei:pb" mode="pb" />
          <xsl:apply-templates select="parent::*/parent::*/preceding-sibling::*[1]/self::tei:cb" mode="cb" />
        </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <!-- LekMuz2 -->
        <xsl:when test="       preceding-sibling::*[1]/self::tei:note       and       preceding-sibling::*[2]/self::tei:pb">
          <xsl:apply-templates select="preceding-sibling::*[2]/self::tei:pb" mode="pb" />
        </xsl:when>
        <!-- BrezKron -->
        <xsl:when test="preceding-sibling::*[1]/self::tei:pb and preceding-sibling::*[2]/self::tei:pb">
          <!--					<xsl:apply-templates select="preceding-sibling::*[2]/self::tei:pb" mode="pb" />-->
          <xsl:apply-templates select="preceding-sibling::*[1]/self::tei:pb" mode="pb" />
        </xsl:when>
        <xsl:when test="preceding-sibling::*[1]/self::tei:pb">
          <xsl:apply-templates select="preceding-sibling::*[1]/self::tei:pb" mode="pb" />
        </xsl:when>
        <xsl:when test="count(parent::*/preceding-sibling::*) = 0 and count(parent::*/parent::*/preceding-sibling::*) = 0 and count(preceding-sibling::*) = 0 and parent::*/parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb">
          <xsl:apply-templates select="parent::*/parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb" mode="pb" />
        </xsl:when>
        <xsl:when test="count(parent::*/preceding-sibling::*) = 0 and count(preceding-sibling::*) = 0 and parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb">
          <xsl:apply-templates select="parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb" mode="pb" />
        </xsl:when>
        <xsl:when test="count(preceding-sibling::*) = 0 and parent::*/preceding-sibling::*[1]/self::tei:pb">
          <xsl:apply-templates select="parent::*/preceding-sibling::*[1]/self::tei:pb" mode="pb" />
        </xsl:when>
        <xsl:when test="       count(preceding-sibling::*) = 0 and       parent::*/preceding-sibling::*[1]/self::tei:note and       parent::*/preceding-sibling::*[2]/self::tei:pb">
          <xsl:apply-templates select="parent::*/preceding-sibling::*[2]/self::tei:pb" mode="pb" />
        </xsl:when>
        <xsl:when test="       count(preceding-sibling::*) = 0       and count(parent::*/preceding-sibling::*) = 0       and count(parent::*/parent::*/preceding-sibling::*) = 0       and parent::*/parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb">
          <xsl:apply-templates select="parent::*/parent::*/parent::*/preceding-sibling::*[1]/self::tei:pb" mode="pb" />
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
      <xsl:if test="self::tei:l and @n">
        <xsl:value-of select="concat(@n, ' ')" />
      </xsl:if>
      <xsl:apply-templates />
    </p>
  </xsl:template>
  <xsl:template name="insert-paragraph-type">
    <xsl:param name="element" select="." />
    <xsl:choose>
      <xsl:when test="$element[ancestor::tei:div[@type = 'editorial']]">
        <xsl:attribute name="type">
          <xsl:text>editorial</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$element[parent::tei:div[@type = 'editorial']]">
        <xsl:attribute name="type">
          <xsl:text>editorial</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$element[self::tei:l]">
        <xsl:attribute name="type">
          <xsl:text>vers</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$element[self::tei:table]">
        <xsl:attribute name="type">
          <xsl:text>table</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$element[self::tei:item]">
        <xsl:attribute name="type">
          <xsl:text>index</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="not(string($element))">
        <!-- not exist -->
      </xsl:when>
      <!-- KomKancTisk -->
      <xsl:when test="$element[self::tei:note and following-sibling::tei:div]">
        <xsl:call-template name="insert-paragraph-type">
          <xsl:with-param name="element" select="(following::tei:head | following::tei:p | following::tei:l)[1]"></xsl:with-param>
        </xsl:call-template>
        <!--<xsl:text>vers</xsl:text>-->
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:p[not(.//tei:note)]" mode="notes" />
  <xsl:template match="tei:pb[following-sibling::*[1]/self::tei:p]" priority="15" />
  <xsl:template match="tei:cb" priority="10">
    <xsl:if test="@n = 'b'">
      <xsl:if test="preceding::tei:cb[@n = 'a']">
        <!-- AdamK -->
        <xsl:if test="not(preceding-sibling::node()[1]/self::tei:pb)">
          <xsl:value-of select="preceding::tei:pb[1]/@n" />
          <xsl:if test="@rend = 'space'">
            <xsl:text></xsl:text>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:if>
    <xsl:value-of select="@n" />
    <xsl:if test="@rend = 'space'">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:body/tei:pb | tei:div/tei:pb" priority="12">
    <xsl:if test="     following-sibling::*[1]/self::tei:note and     (following-sibling::*[2][not(node())]     or following-sibling::*[2]/self::tei:div     )     ">
      <p>
        <xsl:apply-templates select="." mode="pb" />
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:body/tei:cb | tei:div/tei:cb" priority="12">
    <xsl:if test="     following-sibling::*[1]/self::tei:note and     (following-sibling::*[2][not(node())]     or following-sibling::*[2]/self::tei:div     )     ">
      <p>
        <xsl:apply-templates select="." mode="pb" />
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:pb" priority="10">
    <xsl:if test="preceding-sibling::*[1] = preceding-sibling::node()[1] and preceding-sibling::*[1]/self::tei:c[@xml:space = 'preserve'] and @rend = 'space'">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="preceding-sibling::*[1] = preceding-sibling::node()[1] and preceding-sibling::*[1]/self::tei:note and @rend = 'space'">
      <xsl:text></xsl:text>
    </xsl:if>
    <!-- BawEzop -->
    <xsl:if test="preceding-sibling::*[1] = preceding-sibling::node()[1] and preceding-sibling::*[1]/self::tei:foreign and @rend = 'space'">
      <xsl:text></xsl:text>
    </xsl:if>
    <!-- BawJetr -->
    <xsl:if test="preceding-sibling::*[1] = preceding-sibling::node()[1] and preceding-sibling::*[1]/self::tei:supplied and @rend = 'space'">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="preceding-sibling::*[1] = preceding-sibling::node()[1] and preceding-sibling::*[1]/self::tei:add and @rend = 'space' and /tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]/. = '[Cesta z Čech do Jeruzaléma a Egypta r. 1491–1492]'">
      <!--	<xsl:comment> note + supplied </xsl:comment>-->
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:value-of select="@n" />
    <xsl:if test="@ed = 'print'">
      <xsl:text>st.</xsl:text>
    </xsl:if>
    <xsl:if test="@ed = 'print' and not(@rend = 'space') and following-sibling::node()[1][self::tei:pb[not(@rend = 'space')]]">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="@ed = 'edition'">
      <xsl:text>ed.</xsl:text>
    </xsl:if>
    <xsl:if test="@rend = 'space'">
      <xsl:if test="not(following-sibling::node()[1]/self::tei:note)">
        <xsl:text></xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="not(@end) and not(@rend = 'space') and following-sibling::node()[1][self::tei:pb[@ed]]">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:cb" mode="cb">
    <xsl:value-of select="@n" />
    <xsl:if test="@rend='space'">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:pb" mode="pb">
    <xsl:if test="@ed and preceding-sibling::node()[1]/self::tei:pb[not(@ed)]">
      <xsl:apply-templates select="preceding-sibling::*[1]" mode="pb" />
    </xsl:if>
    <xsl:if test="preceding-sibling::node()[1]/self::tei:pb[@ed]">
      <xsl:apply-templates select="preceding-sibling::*[1]" mode="pb" />
    </xsl:if>
    <xsl:if test="preceding-sibling::node()[1]/self::tei:note and preceding-sibling::node()[2]/self::tei:pb[@ed]">
      <xsl:apply-templates select="preceding-sibling::*[2]" mode="pb" />
    </xsl:if>
    <xsl:value-of select="@n" />
    <xsl:if test="@ed = 'edition'">
      <xsl:text>ed.</xsl:text>
    </xsl:if>
    <xsl:if test="@ed = 'print'">
      <xsl:text>st.</xsl:text>
    </xsl:if>
    <xsl:if test="@rend = 'space'">
      <xsl:if test="not(following-sibling::node()[1]/self::tei:note)">
        <xsl:text></xsl:text>
      </xsl:if>
      <xsl:if test="following-sibling::node()[1]/self::tei:note and following-sibling::node()[2]/self::tei:pb[@rend = 'space']">
        <xsl:text></xsl:text>
      </xsl:if>
      <xsl:if test="following-sibling::node()[1]/self::tei:note and count(preceding-sibling::node()) = 0">
        <xsl:text></xsl:text>
      </xsl:if>
      <!-- LekMuz2, LekKonT3 -->
      <xsl:if test="      following-sibling::node()[1]/self::tei:note and      (      (name(preceding-sibling::node()[1]) = name(following-sibling::node()[2]))      or      (      preceding-sibling::node()[1]/self::tei:p and following-sibling::node()[2]/self::tei:div      )      )      ">
        <xsl:choose>
          <!-- Dopisy_Zofie_Albinka_z_Helfenburku -->
          <xsl:when test="following-sibling::*[2]/self::tei:p[not(node())]" />
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:if>
    <!-- ZrcSpasK -->
    <xsl:if test="following-sibling::node()[1]/self::tei:note[tei:figure[tei:p]]">
      <xsl:text></xsl:text>
      <xsl:apply-templates select="following-sibling::*[1]/tei:figure/tei:p//node()" />
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:note[tei:figure[tei:p]]" mode="notes" priority="5" />
  <xsl:template match="    tei:body/tei:note[not(tei:choice)][preceding-sibling::*[1]/self::tei:pb] |   tei:div/tei:note[not(tei:choice)][preceding-sibling::*[1]/self::tei:pb]" mode="notes" priority="5">
    <p>
      <xsl:call-template name="insert-paragraph-type">
        <xsl:with-param name="element" select="." />
      </xsl:call-template>
      <xsl:apply-templates mode="notes" />
    </p>
  </xsl:template>
  <xsl:template match="    tei:p[.//tei:note] | tei:head[.//tei:note] |    tei:l[.//tei:note] | tei:list/tei:item[.//tei:note]" mode="notes">
    <p>
      <xsl:call-template name="insert-paragraph-type">
        <xsl:with-param name="element" select="." />
      </xsl:call-template>
      <xsl:apply-templates mode="notes" />
    </p>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xsl:template match="tei:anchor[@type = 'bible']">
    <!-- ZrcSpasK: nahrazuje se střední za krátkou -->
    <xsl:value-of select="translate(@n, '-', '–')" />
    <xsl:choose>
      <xsl:when test="@subtype = 'chapter' and following-sibling::tei:anchor[@type = 'bible' and @subtype = 'verse']">
        <xsl:text>,</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="     not(following-sibling::node()[1]/self::tei:anchor[@type = 'bible']) and     following-sibling::node()/self::text() and     not(following-sibling::node()[1]/self::tei:note[following-sibling::node()[1]/self::tei:c]) and     not(starts-with(following-sibling::node()[1], ' '))     ">
      <xsl:choose>
        <xsl:when test="following-sibling::node()[1]/self::tei:note and starts-with(following-sibling::node()[2], ' ')" />
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:gap">
    <xsl:text>…</xsl:text>
  </xsl:template>
  <xsl:template match="tei:figure[not(node())]">
    <xsl:if test="     preceding-sibling::node()[1]/self::tei:foreign and     /tei:TEI/tei:teiHeader[1]//tei:bibl[@type = 'acronym'][@subtype = 'source']/. = 'VočehMor'">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="     preceding-sibling::node()[1]/self::tei:supplied and     /tei:TEI/tei:teiHeader[1]//tei:bibl[@type = 'acronym'][@subtype = 'source']/. = 'KomKancTisk'">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:text>#</xsl:text>
  </xsl:template>
  <!-- ZrcSpasK -->
  <!--<xsl:template match="tei:figure[not(node())]
		[
		preceding-sibling::*[1]/self::tei:note[tei:figure[tei:p]] or
		preceding-sibling::*[2]/self::tei:note[tei:figure[tei:p]] or
		preceding-sibling::*[4]/self::tei:note[tei:figure[tei:p]]
		]" priority="4">
		<!-\-<xsl:comment> ZrcSpasK </xsl:comment>-\->
	</xsl:template>-->
  <!-- ZrcSpasK -->
  <xd:doc>
    <xd:desc>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xsl:template match="tei:note[tei:figure[tei:p]][not(parent::tei:div)]" priority="2">
    <xsl:if test="starts-with(following-sibling::text()[1], ' ')">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="     preceding-sibling::node()[1]/self::tei:pb[@rend = 'space']     and (substring(preceding-sibling::node()[2], string-length(preceding-sibling::node()[2]), 1) != ' ')">
      <xsl:text></xsl:text>
    </xsl:if>
    <!-- element na konci odstavce, musí předcházet mezera -->
    <xsl:if test="     count(following-sibling::node()) = 1 or     count(following-sibling::text()) = 0">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="tei:figure/tei:p[tei:note[tei:choice]][tei:note[not(tei:choice)]]">
        <xsl:apply-templates select="tei:figure/tei:p[tei:note[tei:choice]][tei:note[not(tei:choice)]]//node()[ not(parent::*[self::tei:reg]) and not(parent::*[self::tei:orig]) and not(parent::*[self::tei:note]) and not(parent::*[self::tei:choice]) ]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="tei:figure/tei:p//node()" />
      </xsl:otherwise>
    </xsl:choose>
    <!--<xsl:text> #</xsl:text>-->
    <xsl:if test="     following-sibling::node() and     not(     following-sibling::node()[1][self::tei:pb[@rend = 'space']]     )">
      <xsl:text></xsl:text>
    </xsl:if>
    <!-- element na začátku odstavce, musí následovat mezera -->
    <xsl:if test="count(preceding-sibling::node()) = 0">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <!-- ZrcSpasK -->
  <xsl:template match="tei:note[tei:anchor[@type = 'bible']]">
    <xsl:if test="not(starts-with(., ' '))">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:apply-templates />
  </xsl:template>
  <!-- ZrcSpasK -->
  <xsl:template match="tei:note[tei:del]">
    <xsl:text></xsl:text>
    <xsl:apply-templates />
  </xsl:template>
  <!--BernNaucB	-->
  <xsl:template match="tei:p/node()[1][self::tei:note][following::node()[1][self::text()]]" priority="5" />
  <!--
		<p xml:id="t-1.body-1.div-2.p-2"><note n="1" xml:id="t-1.body-1.div-2.p-2.note-1">znaménko oddělení smyslového celku</note> Jestliže... </p>
	-->
  <xsl:template match="tei:p/node()[2][self::text()][preceding-sibling::node()[1][self::tei:note]][starts-with(. ,' ')]">
    <xsl:value-of select="substring(., 2)" />
  </xsl:template>
  <xsl:template match="tei:add" priority="3">
    <xsl:if test="     preceding-sibling::node()[1]/self::tei:foreign and     /tei:TEI/tei:teiHeader[1]//tei:bibl[@type = 'acronym'][@subtype = 'source']/. = 'VočehMor'">
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="* | text()" mode="notes">
    <xsl:apply-templates mode="notes" />
  </xsl:template>
  <!-- OlympiusKnizka1571.xml -->
  <xsl:template match="tei:note[@place='margin'][@type='print']">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>
  <xsl:template match="tei:note">
    <xsl:if test="following-sibling::node()[1]/self::tei:supplied and /tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]/. = '[Aseneth]'">
      <!--	<xsl:comment> note + supplied </xsl:comment>-->
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="following-sibling::node()[1]/self::tei:seg and /tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]/. = '[Belial]'">
      <!--	<xsl:comment> note + seg </xsl:comment>-->
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="following-sibling::node()[1]/self::tei:supplied and /tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]/. = '[Belial]'">
      <!--	<xsl:comment> note + supplied </xsl:comment>-->
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="following-sibling::node()[1]/self::tei:supplied and /tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]/. = '[Cestopis tzv. Mandevilla v překladu Vavřince z Březové]'">
      <!--	<xsl:comment> note + supplied </xsl:comment>-->
      <xsl:text></xsl:text>
    </xsl:if>
    <xsl:if test="     preceding-sibling::node()[1]/self::tei:pb[@rend = 'space'] and     following-sibling::node()[1]/self::tei:fw">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:note/text() | tei:note/tei:hi" mode="notes" priority="5">
    <xsl:value-of select="normalize-space()" />
    <xsl:if test="not(position() = last())">
      <xsl:text>|</xsl:text>
    </xsl:if>
  </xsl:template>
  <!-- OlympiusKnizka1571 -->
  <xsl:template match="tei:note[@place='margin'][@type='print']" mode="notes">
    <xsl:if test=".//tei:note">
      <p>
        <xsl:apply-templates mode="notes" />
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:note[@place='margin'][@type='print']/text()" mode="notes" priority="6"></xsl:template>
  <xsl:template match="tei:note" mode="notes">
    <xsl:choose>
      <!-- Dal_doplnek_Zebereruv -->
      <xsl:when test="parent::tei:body | parent::tei:div">
        <p>
          <xsl:choose>
            <xsl:when test="(following::tei:p | following::tei:l)[1]/self::tei:l">
              <xsl:attribute name="type">
                <xsl:text>vers</xsl:text>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
          <xsl:call-template name="insert-paragraph-type">
            <xsl:with-param name="element" select="." />
          </xsl:call-template>
          <xsl:apply-templates mode="notes" />
          <xsl:text>|</xsl:text>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="notes" />
        <xsl:text>|</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:note[tei:choice]" mode="notes">
    <xsl:apply-templates mode="notes" />
    <xsl:text>|</xsl:text>
  </xsl:template>
  <xsl:template match="tei:choice" mode="notes">
    <xsl:apply-templates select="tei:orig | tei:sic" />
    <!--<xsl:apply-templates select="tei:note" mode="notes" />-->
  </xsl:template>
  <xsl:template match="tei:ref" mode="notes">
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xsl:template match="    tei:p/tei:c | tei:l/tei:c |    tei:div/tei:c | tei:head/tei:c" priority="10">
    <xsl:if test="     count(preceding-sibling::node()) &gt; 0 and     following-sibling::node()[1][not(@rend = 'space')]">
      <xsl:apply-templates />
    </xsl:if>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>KnizSrdKon, Noviny_straslive</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="tei:seg/tei:c" priority="10">
    <xsl:if test="     count(preceding-sibling::node()) = 0 and     (parent::*/preceding-sibling::node()[1][self::*][not(@rend = 'space')]     or     (parent::*/preceding-sibling::node()[1]/self::text() and     substring(parent::*/preceding-sibling::node()[1],     string-length(parent::*/preceding-sibling::node()[1])) != ' ')     )     ">
      <xsl:apply-templates />
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:c[@function = 'initial']" priority="15">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:row">
    <xsl:apply-templates />
    <xsl:text>//</xsl:text>
  </xsl:template>
  <xsl:template match="tei:cell">
    <xsl:apply-templates />
    <xsl:text>|</xsl:text>
  </xsl:template>
</xsl:stylesheet>