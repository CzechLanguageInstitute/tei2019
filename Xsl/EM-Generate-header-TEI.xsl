<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:ev="http://www.daliboris.cz/schemata/prepisy.xsd" exclude-result-prefixes="xd ev" version="1.0">
  <xsl:import href="TEI-classDecl.xsl" />
  <xsl:import href="TEI-catRef.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 2, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Vytvoří hlavičku TEI na základě dat z evidenčního XML textů</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:param name="soubor" />
  <xsl:param name="rok" select="'2015'" />
  <xsl:output indent="yes" method="xml" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-Generate-header-TEI </xsl:comment>
    <xsl:apply-templates select="/ev:Prepisy/ev:Prepis[ev:Soubor/ev:Nazev = $soubor]" />
  </xsl:template>
  <xsl:template match="/ev:Prepisy">
    <xsl:apply-templates select="ev:Prepis[ev:Soubor/ev:Nazev = $soubor]" />
  </xsl:template>
  <xsl:template match="ev:Prepis">
    <teiHeader>
      <fileDesc>
        <xsl:attribute name="n">
          <xsl:value-of select="ev:Zpracovani/ev:GUID" />
        </xsl:attribute>
        <titleStmt>
          <title>
            <xsl:value-of select="ev:Hlavicka/ev:Titul" />
          </title>
          <xsl:apply-templates select="ev:Hlavicka/ev:Autor" mode="titleStmt" />
        </titleStmt>
        <editionStmt>
          <edition>elektronická edice</edition>
          <xsl:apply-templates select="ev:Hlavicka/ev:EditoriPrepisu" />
          <respStmt>
            <resp>kódování TEI</resp>
            <name>Lehečka, Boris</name>
          </respStmt>
        </editionStmt>
        <publicationStmt>
          <publisher>oddělení vývoje jazyka Ústavu pro jazyk český AV ČR, v. v. i.<email>vyvoj@ujc.cas.cz</email></publisher>
          <pubPlace>Praha</pubPlace>
          <!-- TODO: načítat datum publikace programově -->
          <date>
            <xsl:call-template name="get-publication-years" />
          </date>
          <!--<publisher>Manuscriptorium.com</publisher>-->
          <xsl:call-template name="insert-availability">
            <xsl:with-param name="licence" select="ev:Zpracovani/ev:Licence" />
          </xsl:call-template>
        </publicationStmt>
        <sourceDesc>
          <xsl:call-template name="listBibl" />
          <msDesc xml:lang="cs">
            <xsl:call-template name="identifikaceRukopisu" />
            <msContents>
              <msItem>
                <title>
                  <xsl:value-of select="ev:Hlavicka/ev:Titul" />
                </title>
                <xsl:if test="ev:Hlavicka/ev:Tiskar">
                  <docImprint>
                    <publisher>
                      <xsl:value-of select="ev:Hlavicka/ev:Tiskar" />
                    </publisher>
                    <pubPlace>
                      <xsl:value-of select="ev:Hlavicka/ev:MistoTisku" />
                    </pubPlace>
                    <date>
                      <xsl:value-of select="ev:Hlavicka/ev:DataceText" />
                    </date>
                  </docImprint>
                </xsl:if>
              </msItem>
            </msContents>
            <history>
              <!--
								
								xw.WriteStartElement("origDate");
								if (dt.Rok != 0 && (dt.NePoRoce == dt.NePredRokem) ) {
								xw.WriteAttributeString("when", dt.Rok.ToString());
								}
								else {
								if (!glsUpresneni.Contains(dt.Upresneni)) {
								xw.WriteAttributeString("notBefore", dt.NePredRokem.ToString());
								xw.WriteAttributeString("notAfter", dt.NePoRoce.ToString());
								}
								}
								xw.WriteString(dt.SlovniPopis);
								xw.WriteEndElement();//</origDate>
							-->
              <origin>
                <origDate notBefore="{ev:Hlava/ev:Pamatka/ev:Pramen/ev:Datace/ev:NePredRokem}" notAfter="{ev:Hlava/ev:Pamatka/ev:Pramen/ev:Datace/ev:NePoRoce}">
                  <xsl:value-of select="ev:Hlavicka/ev:DataceText" />
                </origDate>
              </origin>
            </history>
          </msDesc>
        </sourceDesc>
      </fileDesc>
      <xsl:call-template name="encodingDesc" />
      <!--<revisionDesc>
				<change when="{substring-before(ev:Zpracovani/ev:Exporty/ev:Export[ev:ZpusobVyuziti = 'Manuscriptorium'][last()]/ev:CasExportu, 'T')}"/>
			</revisionDesc>-->
    </teiHeader>
  </xsl:template>
  <xsl:template name="insert-availability">
    <xsl:param name="licence" />
    <xsl:choose>
      <xsl:when test="$licence = 'CC-BY-SA-4.0'">
        <availability status="restricted">
          <licence xml:lang="cs-CZ" target="http://creativecommons.org/licenses/by-sa/4.0/deed.cs">Toto dílo podléhá licenci Creative Commons Uveďte původ-Zachovejte licenci 4.0 Mezinárodní Licence.</licence>
          <licence xml:lang="en-US" target="http://creativecommons.org/licenses/by-sa/4.0/deed.en">This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.</licence>
        </availability>
      </xsl:when>
      <xsl:when test="$licence = 'CC-BY-NC-SA-4.0'">
        <availability status="restricted">
          <licence xml:lang="cs-CZ" target="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.cs">Toto dílo podléhá licenci Creative Commons Uveďte původ-Neužívejte dílo komerčně-Zachovejte licenci 4.0 Mezinárodní Licence.</licence>
          <licence xml:lang="en-US" target="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.</licence>
        </availability>
      </xsl:when>
      <xsl:otherwise>
        <availability status="restricted">
          <p>Tato edice je autorské dílo chráněné ve smyslu zákona č. 121/2000 Sb., o právu autorském, a je určena pouze k nekomerčním účelům.</p>
        </availability>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="get-publication-years">
    <xsl:variable name="minYear">
      <xsl:for-each select="ev:Zpracovani/ev:PrvniExporty/ev:Export/ev:CasExportu">
        <xsl:sort data-type="text" />
        <xsl:if test="position() = 1">
          <xsl:value-of select="substring-before(., '-')" />
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($minYear) &gt; 0">
        <xsl:value-of select="$minYear" />
        <xsl:if test="$minYear != $rok">
          <xsl:text>–</xsl:text>
          <xsl:value-of select="$rok" />
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$rok" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="encodingDesc">
    <encodingDesc>
      <xsl:call-template name="classificationDeclarations" />
    </encodingDesc>
    <profileDesc>
      <textClass>
        <xsl:call-template name="catRef" />
        <xsl:call-template name="keywords" />
      </textClass>
    </profileDesc>
  </xsl:template>
  <xsl:template name="keywords">
    <xsl:if test="ev:Zpracovani/ev:LiterarniDruh/text() | ev:Zpracovani/ev:LiterarniZanr/text()    | ev:Hlava/ev:Pamatka/ev:Zkratka/text() | ev:Hlava/ev:Pamatka/ev:Pramen/ev:Zkratka/text()">
      <keywords scheme="http://vokabular.ujc.cas.cz/scheme/classification/secondary">
        <xsl:apply-templates select="ev:Zpracovani/ev:LiterarniDruh | ev:Zpracovani/ev:LiterarniZanr" mode="term" />
      </keywords>
    </xsl:if>
  </xsl:template>
  <xsl:template match="ev:LiterarniDruh" mode="term">
    <term type="literary-form">
      <xsl:apply-templates />
    </term>
  </xsl:template>
  <xsl:template match="ev:LiterarniZanr" mode="term">
    <term type="literary-genre">
      <xsl:apply-templates />
    </term>
  </xsl:template>
  <xsl:template match="ev:Pramen/ev:Zkratka" mode="bibl">
    <bibl type="acronym" subtype="source">
      <xsl:apply-templates />
    </bibl>
  </xsl:template>
  <xsl:template match="ev:Pamatka/ev:Zkratka" mode="bibl">
    <bibl type="acronym" subtype="original-text">
      <xsl:apply-templates />
    </bibl>
  </xsl:template>
  <xsl:template name="listBibl">
    <xsl:if test="ev:Hlava/ev:Pamatka/ev:Zkratka | ev:Hlava/ev:Pamatka/ev:Pramen/ev:Zkratka">
      <listBibl>
        <xsl:apply-templates select="ev:Hlava/ev:Pamatka/ev:Zkratka | ev:Hlava/ev:Pamatka/ev:Pramen/ev:Zkratka" mode="bibl" />
      </listBibl>
    </xsl:if>
  </xsl:template>
  <xsl:template name="identifikaceRukopisu">
    <msIdentifier>
      <xsl:apply-templates select="ev:Hlavicka/ev:ZemeUlozeni" />
      <xsl:apply-templates select="ev:Hlavicka/ev:MestoUlozeni" />
      <xsl:apply-templates select="ev:Hlavicka/ev:InstituceUlozeni" />
      <xsl:apply-templates select="ev:Hlavicka/ev:Signatura" />
    </msIdentifier>
  </xsl:template>
  <xsl:template match="ev:Signatura">
    <idno>
      <xsl:value-of select="." />
    </idno>
  </xsl:template>
  <xsl:template match="ev:InstituceUlozeni">
    <repository>
      <xsl:value-of select="." />
    </repository>
  </xsl:template>
  <xsl:template match="ev:MestoUlozeni">
    <settlement>
      <xsl:value-of select="." />
    </settlement>
  </xsl:template>
  <xsl:template match="ev:ZemeUlozeni">
    <country>
      <xsl:attribute name="key">
        <xsl:choose>
          <xsl:when test=". = 'Česko'">xr</xsl:when>
          <xsl:when test=". = 'Rakousko'">au</xsl:when>
          <xsl:when test=". = 'Polsko'">pl</xsl:when>
          <xsl:when test=". = 'Francie'">fr</xsl:when>
          <xsl:when test=". = 'Německo'">gw</xsl:when>
          <xsl:when test=". = 'Rusko'">ru</xsl:when>
          <xsl:when test=". = 'Slovensko'">xo</xsl:when>
          <xsl:when test=". = 'Maďarsko'">hu</xsl:when>
          <xsl:when test=". = 'Rakousko'">au</xsl:when>
        </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="." />
    </country>
  </xsl:template>
  <xsl:template match="ev:EditoriPrepisu">
    <xsl:apply-templates />
    <!--		<xsl:for-each select="ev:string">
			<xsl:apply-templates select="." />
		</xsl:for-each>-->
  </xsl:template>
  <xsl:template match="ev:EditoriPrepisu/ev:string">
    <respStmt>
      <resp>editor</resp>
      <name>
        <xsl:value-of select="." />
      </name>
    </respStmt>
  </xsl:template>
  <xsl:template match="ev:Autor" mode="titleStmt">
    <xsl:element name="author">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>