<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" exclude-result-prefixes="xd" version="1.0">
  <xsl:key name="poznamka" match="//poznamka_pod_carou" use="@id" />
  <xsl:template match="Predmluva">
    <xsl:element name="div">
      <xsl:attribute name="type">
        <xsl:text>preface</xsl:text>
      </xsl:attribute>
      <xsl:element name="p">
        <xsl:copy-of select="@c:*" />
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="Edicni_komentar">
    <xsl:element name="div">
      <xsl:attribute name="type">
        <xsl:text>editorial</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="subtype">
        <xsl:text>comment</xsl:text>
      </xsl:attribute>
      <xsl:element name="p">
        <xsl:copy-of select="@c:*" />
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="Edicni_komentar_Nadpis">
    <!--		<xsl:element name="div">-->
    <!--			<xsl:attribute name="type">
				<xsl:text>editorial</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="subtype">
				<xsl:text>comment</xsl:text>
			</xsl:attribute>
-->
    <xsl:element name="thead">
      <xsl:copy-of select="@c:*" />
      <xsl:attribute name="type">
        <xsl:text>editorial</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="subtype">
        <xsl:text>comment</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
    <!--		</xsl:element>-->
  </xsl:template>
  <xsl:template match="Edicni_komentar_Podnadpis">
    <!--		<xsl:element name="div">-->
    <!--			<xsl:attribute name="type">
				<xsl:text>editorial</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="subtype">
				<xsl:text>comment</xsl:text>
			</xsl:attribute>
-->
    <xsl:element name="head">
      <xsl:copy-of select="@c:*" />
      <xsl:attribute name="type">
        <xsl:text>editorial</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="subtype">
        <xsl:text>comment</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
    <!--		</xsl:element>-->
  </xsl:template>
  <xsl:template match="Edicni_komentar/footnote_reference">
    <xsl:element name="note">
      <xsl:copy-of select="@c:*" />
      <xsl:apply-templates select="key('poznamka', .)" mode="note" />
      <!--<xsl:apply-templates select='../../poznamka_pod_carou[@id="{text()}"]' />-->
    </xsl:element>
  </xsl:template>
  <!-- Kvůli chybě v AltovaXML je potřeba dávat v mixed content xml:space="preserve" i do prázdného elementu -->
  <xsl:template match="torzo" xml:space="default">
    <xsl:element name="seg">
      <xsl:attribute name="space" namespace="http://www.w3.org/XML/1998/namespace">
        <xsl:text>preserve</xsl:text>
      </xsl:attribute>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="type">
        <xsl:text>fragment</xsl:text>
      </xsl:attribute>
      <!--<xsl:attribute name="xml:space"><xsl:text>preserve</xsl:text></xsl:attribute>-->
      <xsl:choose>
        <xsl:when test="starts-with(text(), '…')">
          <xsl:element name="gap" />
          <hi>
            <xsl:value-of select="translate(text(),'…', '')" />
          </hi>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before(text(), '…')" />
          <xsl:element name="gap" />
          <xsl:choose>
            <xsl:when test="substring-after(text(), '…') = ' '">
              <xsl:value-of select="' '" />
            </xsl:when>
            <xsl:otherwise>
              <hi xml:space="preserve">
                <xsl:value-of select="substring-after(text(), '…')" />
              </hi>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="poznamka">
        <xsl:apply-templates select="poznamka" />
      </xsl:if>
    </xsl:element>
  </xsl:template>
  <!--	<xsl:template match="torzo" xml:space="default">
		<xsl:element name="seg">
			<xsl:copy-of select="@*" />
			<xsl:attribute name="type">
				<xsl:text>fragment</xsl:text>
			</xsl:attribute>
			<!-\-<xsl:attribute name="xml:space"><xsl:text>preserve</xsl:text></xsl:attribute>-\->
			<xsl:choose>
				<xsl:when test="starts-with(., '…')">
					<xsl:element name="gap" />
					<hi>
						<xsl:value-of select="translate(.,'…', '')" />
					</hi>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before(., '…')" />
					<xsl:element name="gap" />
					<hi>
						<xsl:value-of select="substring-after(., '…')" />
					</hi>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
-->
  <xsl:template match="poznamka_pod_carou" mode="note">
    <xsl:choose>
      <xsl:when test="count(footnote_text) = 1">
        <xsl:apply-templates select="footnote_text[1]/*" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="footnote_text">
    <xsl:element name="p">
      <xsl:copy-of select="@c:*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="footnote_text/footnote_reference" />
  <xsl:template match="Incipit">
    <!--	<xsl:element name="div">
			<xsl:attribute name="type">
				<xsl:text>incipit</xsl:text>
			</xsl:attribute>
			<xsl:element name="p">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>-->
    <xsl:element name="head">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="type">
        <xsl:text>incipit</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Explicit">
    <!--		<xsl:element name="div">
			<xsl:attribute name="type">
				<xsl:text>explicit</xsl:text>
			</xsl:attribute>
			<xsl:element name="p">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
-->
    <xsl:element name="head">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="type">
        <xsl:text>explicit</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Grantova_podpora">
    <xsl:element name="div">
      <xsl:attribute name="type">
        <xsl:text>editorial</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="subtype">
        <xsl:text>grant</xsl:text>
      </xsl:attribute>
      <xsl:element name="p">
        <xsl:copy-of select="@*" />
        <xsl:attribute name="rend">
          <xsl:text>grant</xsl:text>
        </xsl:attribute>
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="iniciala">
    <xsl:element name="c">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="function">
        <xsl:text>initial</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="bible_zkratka_knihy">
    <xsl:element name="anchor">
      <xsl:copy-of select="@c:*" />
      <xsl:attribute name="type">
        <xsl:text>bible</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="subtype">
        <xsl:text>book</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="xml:id">
        <xsl:text>b.</xsl:text>
        <xsl:number format="001" level="any" />
        <!--<xsl:value-of select="generate-id()"/>-->
        <xsl:text>.</xsl:text>
        <xsl:value-of select="normalize-space(translate(., ' ', ''))" />
      </xsl:attribute>
      <xsl:attribute name="n">
        <xsl:value-of select="normalize-space(.)" />
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="bible_cislo_kapitoly">
    <xsl:element name="anchor">
      <xsl:copy-of select="@c:*" />
      <xsl:attribute name="type">
        <xsl:text>bible</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="subtype">
        <xsl:text>chapter</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="xml:id">
        <xsl:text>c.</xsl:text>
        <xsl:value-of select="generate-id()" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="normalize-space(translate(., ',', ''))" />
      </xsl:attribute>
      <xsl:attribute name="n">
        <xsl:value-of select="normalize-space(translate(., ',', ''))" />
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="bible_cislo_verse">
    <xsl:element name="anchor">
      <xsl:copy-of select="@c:*" />
      <xsl:attribute name="type">
        <xsl:text>bible</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="subtype">
        <xsl:text>verse</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="xml:id">
        <xsl:text>v.</xsl:text>
        <xsl:value-of select="generate-id()" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="normalize-space(translate(., '–', '-'))" />
      </xsl:attribute>
      <xsl:attribute name="n">
        <xsl:value-of select="normalize-space(translate(., '–', '-'))" />
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="textovy_orientator">
    <xsl:element name="add">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="place">
        <xsl:text>margin</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:text>orientating</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="cizi_jazyk_doplneny_text">
    <xsl:element name="foreign">
      <xsl:element name="supplied">
        <xsl:copy-of select="@*" />
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="cizi_jazyk_horni_index">
    <xsl:element name="foreign">
      <xsl:element name="hi">
        <xsl:copy-of select="@*" />
        <xsl:attribute name="rend">
          <xsl:text>sup</xsl:text>
        </xsl:attribute>
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="Polozka_rejstriku">
    <item>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </item>
  </xsl:template>
  <xsl:template match="kurziva">
    <xsl:element name="hi">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="rend">
        <xsl:text>italic</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="tucne">
    <xsl:element name="hi">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="rend">
        <xsl:text>bold</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="popisek_k_obrazku">
    <xsl:element name="note">
      <xsl:element name="figure">
        <xsl:element name="p">
          <xsl:copy-of select="@*" />
          <xsl:apply-templates />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="skrt">
    <xsl:element name="del">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="horni_index">
    <xsl:element name="hi">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="rend">
        <xsl:text>superscript</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="hypertextovy_odkaz">
    <xsl:element name="ref">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="target">
        <xsl:value-of select="normalize-space(.)" />
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Případy, kdy vstupní dokument obsahuje wordovské hypertextové odkazy.</xd:p>
      <xd:p>Přidáno 2017-02-24</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="hypertextovy_odkaz[@target]" priority="10">
    <xsl:element name="ref">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Impresum">
    <!--<xsl:element name="docImprint">
			<xsl:copy-of select="@*" />
			<xsl:apply-templates />
		</xsl:element>-->
    <xsl:element name="div">
      <!--<xsl:element name="p">-->
      <xsl:copy-of select="@*" />
      <xsl:attribute name="type">
        <xsl:text>impresum</xsl:text>
      </xsl:attribute>
      <p>
        <xsl:apply-templates />
      </p>
    </xsl:element>
  </xsl:template>
  <xsl:template match="Marginalni_nadpis">
    <xsl:element name="head1">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="type">
        <xsl:text>marginal</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="Adresat">
    <xsl:element name="div">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="type">
        <xsl:text>addressee</xsl:text>
      </xsl:attribute>
      <xsl:element name="p">
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="Marginalni_poznamka">
    <xsl:element name="note">
      <xsl:copy-of select="@*" />
      <xsl:attribute name="place">
        <xsl:text>margin</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:text>print</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Ignorované elementy</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="zkratka">
    <xsl:element name="abbr">
      <xsl:copy-of select="@c:*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace_rozepsani_zkratky">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace/rozepsani_zkratky">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:element name="expan">
        <xsl:apply-templates select="." mode="export" />
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace_horni_index">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace_cizi_jazyk">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace_zkratka">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace_zkratka_horni_index">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace_preskrtnute">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace_cizi_jazyk_horni_index">
    <xsl:if test="$exportovatTransliteraci = 'true()'">
      <xsl:apply-templates select="." mode="export" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="transliterace" mode="export">
    <xsl:element name="note">
      <xsl:element name="orig">
        <xsl:copy-of select="@c:*" />
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_rozepsani_zkratky" mode="export">
    <xsl:element name="note">
      <xsl:element name="orig">
        <xsl:copy-of select="@c:*" />
        <xsl:element name="ex">
          <xsl:apply-templates />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_horni_index" mode="export">
    <xsl:element name="note">
      <xsl:element name="orig">
        <xsl:element name="hi">
          <xsl:copy-of select="@c:*" />
          <xsl:attribute name="rend">
            <xsl:text>superscript</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_cizi_jazyk" mode="export">
    <xsl:element name="note">
      <xsl:element name="foreign">
        <xsl:element name="orig">
          <xsl:copy-of select="@c:*" />
          <xsl:apply-templates />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_zkratka" mode="export">
    <xsl:element name="note">
      <xsl:element name="orig">
        <xsl:copy-of select="@c:*" />
        <xsl:element name="abbr">
          <xsl:apply-templates />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_zkratka_horni_index" mode="export">
    <xsl:element name="note">
      <xsl:element name="orig">
        <xsl:copy-of select="@c:*" />
        <xsl:element name="abbr">
          <xsl:element name="hi">
            <xsl:attribute name="rend">
              <xsl:text>superscript</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates />
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_preskrtnute" mode="export">
    <xsl:element name="note">
      <xsl:element name="orig">
        <xsl:copy-of select="@c:*" />
        <xsl:element name="del">
          <xsl:apply-templates />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_cizi_jazyk_horni_index" mode="export">
    <xsl:element name="note">
      <xsl:element name="foreign">
        <xsl:element name="orig">
          <xsl:copy-of select="@c:*" />
          <xsl:element name="hi">
            <xsl:attribute name="rend">
              <xsl:text>superscript</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates />
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="prolozene">
    <xsl:element name="hi">
      <xsl:copy-of select="@c:*" />
      <xsl:attribute name="rend">
        <xsl:text>interleaved</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="ruznocteni_autor" />
  <xsl:template match="ruznocteni[following-sibling::*[1][self::ruznocteni_autor]]">
    <note>
      <app>
        <xsl:apply-templates select="." mode="note" />
        <xsl:apply-templates select="following-sibling::*[1]" mode="note" />
      </app>
    </note>
  </xsl:template>
  <xsl:template match="ruznocteni" mode="note">
    <rdg>
      <xsl:copy-of select="@c:*" />
      <xsl:apply-templates />
    </rdg>
  </xsl:template>
  <xsl:template match="ruznocteni_autor" mode="note">
    <wit>
      <xsl:copy-of select="@c:*" />
      <xsl:apply-templates />
    </wit>
  </xsl:template>
  <!-- přidáno 2018-06-16 -->
  <xsl:template match="nahrazeni">
    <xsl:element name="add">
      <xsl:attribute name="type">
        <xsl:text>replacement</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>