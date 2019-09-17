<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:ev="http://www.daliboris.cz/schemata/prepisy.xsd" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd ev tei" version="1.0">
  <xsl:template name="classificationDeclarations" xmlns="http://www.tei-c.org/ns/1.0">
    <classDecl>
      <taxonomy xml:id="taxonomy">
        <category xml:id="taxonomy-dictionary">
          <catDesc xml:lang="cs-cz">slovník</catDesc>
          <category xml:id="taxonomy-dictionary-contemporary">
            <catDesc xml:lang="cs-cz">soudobý</catDesc>
          </category>
          <category xml:id="taxonomy-dictionary-historical">
            <catDesc xml:lang="cs-cz">dobový</catDesc>
          </category>
        </category>
        <category xml:id="taxonomy-historical_text">
          <catDesc xml:lang="cs-cz">historický text</catDesc>
          <category xml:id="taxonomy-historical_text-old_czech">
            <catDesc xml:lang="cs-cz">staročeský</catDesc>
          </category>
          <category xml:id="taxonomy-historical_text-medieval_czech">
            <catDesc xml:lang="cs-cz">středněčeský</catDesc>
          </category>
        </category>
        <category xml:id="taxonomy-scholary_text">
          <catDesc xml:lang="cs-cz">odborný text</catDesc>
        </category>
        <category xml:id="taxonomy-digitized-grammar">
          <catDesc xml:lang="cs-cz">digitalizovaná mluvnice</catDesc>
        </category>
        <category xml:id="taxonomy-card-index">
          <catDesc xml:lang="cs-cz">lístková kartotéka</catDesc>
        </category>
      </taxonomy>
      <taxonomy xml:id="output">
        <category xml:id="output-dictionary">
          <catDesc xml:lang="cs-cz">slovníky</catDesc>
          <category xml:id="output-dictionary-diachronic-modern">
            <catDesc xml:lang="cs-cz">moderní diachronní slovníky</catDesc>
          </category>
          <category xml:id="output-dictionary-diachronic-period">
            <catDesc xml:lang="cs-cz">dobové diachronní slovníky</catDesc>
          </category>
        </category>
        <category xml:id="output-editions">
          <catDesc xml:lang="cs-cz">edice</catDesc>
          <category xml:id="output-editions-old_czech">
            <catDesc xml:lang="cs-cz">staročeské edice</catDesc>
          </category>
          <category xml:id="output-editions-middle_czech">
            <catDesc xml:lang="cs-cz">středněčeské edice</catDesc>
          </category>
        </category>
        <category xml:id="output-text_bank">
          <catDesc xml:lang="cs-cz">textová banka</catDesc>
          <category xml:id="output-text_bank-old_czech">
            <catDesc xml:lang="cs-cz">staročeská textová banka</catDesc>
          </category>
          <category xml:id="output-text_bank-middle_czech">
            <catDesc xml:lang="cs-cz">středněčeská textová banka</catDesc>
          </category>
        </category>
        <category xml:id="output-scholary_literature">
          <catDesc xml:lang="cs-cz">odborná literatura</catDesc>
        </category>
        <category xml:id="output-digitized-grammar">
          <catDesc xml:lang="cs-cz">digitalizované mluvnice</catDesc>
        </category>
      </taxonomy>
    </classDecl>
  </xsl:template>
</xsl:stylesheet>