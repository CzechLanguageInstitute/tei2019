<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 9, 2011</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Rozepíše kumulativní styly (např. <xd:b>poznamka_kurziva</xd:b> na více jednochých stylů.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> Decompose-merged-styles-to-components </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="poznamka_kurziva">
    <xsl:element name="poznamka">
      <xsl:copy-of select="@*" />
      <xsl:element name="kurziva">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="poznamka_preskrtnute">
    <xsl:element name="poznamka">
      <xsl:copy-of select="@*" />
      <xsl:element name="preskrtnute">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="poznamka_horni_index">
    <xsl:element name="poznamka">
      <xsl:copy-of select="@*" />
      <xsl:element name="horni_index">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="interni_poznamka_dolni_index">
    <xsl:element name="interni_poznamka">
      <xsl:copy-of select="@*" />
      <xsl:element name="dolni_index">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_rozepsani_zkratky">
    <xsl:element name="transliterace">
      <xsl:copy-of select="@*" />
      <xsl:element name="rozepsani_zkratky">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_horni_index">
    <xsl:element name="transliterace">
      <xsl:copy-of select="@*" />
      <xsl:element name="horni_index">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_cizi_jazyk">
    <xsl:element name="transliterace">
      <xsl:copy-of select="@*" />
      <xsl:element name="cizi_jazyk">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_zkratka">
    <xsl:element name="transliterace">
      <xsl:copy-of select="@*" />
      <xsl:element name="zkratka">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_zkratka_horni_index">
    <xsl:element name="transliterace">
      <xsl:copy-of select="@*" />
      <xsl:element name="zkratka">
        <xsl:element name="horni_index">
          <xsl:value-of select="." />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_preskrtnute">
    <xsl:element name="transliterace">
      <xsl:copy-of select="@*" />
      <xsl:element name="preskrtnute">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="transliterace_cizi_jazyk_horni_index">
    <xsl:element name="transliterace">
      <xsl:copy-of select="@*" />
      <xsl:element name="cizi_jazyk">
        <xsl:element name="horni_index">
          <xsl:value-of select="." />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="rekonstrukce_cizi_jazyk">
    <xsl:element name="cizi_jazyk">
      <xsl:copy-of select="@*" />
      <xsl:element name="rekonstrukce">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="cizi_jazyk_torzo">
    <xsl:element name="cizi_jazyk">
      <xsl:copy-of select="@*" />
      <xsl:element name="torzo">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_marginalni_mladsi_torzo">
    <xsl:element name="pripisek_marginalni_mladsi">
      <xsl:copy-of select="@*" />
      <xsl:element name="torzo">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_marginalni_mladsi_doplneny_text">
    <xsl:element name="pripisek_marginalni_mladsi">
      <xsl:copy-of select="@*" />
      <xsl:element name="doplneny_text">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_marginalni_soudoby_doplneny_text">
    <xsl:element name="pripisek_marginalni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:element name="doplneny_text">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_interlinearni_soudoby_cizi_jazyk">
    <xsl:element name="pripisek_interlinearni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:element name="cizi_jazyk">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_interlinearni_soudoby_doplneny_text">
    <xsl:element name="pripisek_interlinearni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:element name="doplneny_text">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_marginalni_soudoby_cizi_jazyk">
    <xsl:element name="pripisek_marginalni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:element name="cizi_jazyk">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_marginalni_soudoby_torzo">
    <xsl:element name="pripisek_marginalni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:element name="torzo">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="popisek_k_obrazku_rekonstrukce">
    <xsl:element name="popisek_k_obrazku">
      <xsl:copy-of select="@*" />
      <xsl:element name="rekonstrukce">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="popisek_k_obrazku_doplneny_text">
    <xsl:element name="popisek_k_obrazku">
      <xsl:copy-of select="@*" />
      <xsl:element name="doplneny_text">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="popisek_k_obrazku_cizi_jazyk">
    <xsl:element name="popisek_k_obrazku">
      <xsl:copy-of select="@*" />
      <xsl:element name="cizi_jazyk">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="kurziva_horni_index">
    <xsl:element name="kurziva">
      <xsl:copy-of select="@*" />
      <xsl:element name="horni_index">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match="popisek_k_obrazku_torzo">
    <xsl:element name="popisek_k_obrazku">
      <xsl:copy-of select="@*" />
      <xsl:element name="torzo">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="cizi_jazyk_horni_index">
    <xsl:element name="cizi_jazyk">
      <xsl:copy-of select="@*" />
      <xsl:element name="horni_index">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="prolozena_kurziva">
    <xsl:element name="prolozene">
      <xsl:copy-of select="@*" />
      <xsl:element name="kurziva">
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pramen_horni_index">
    <xsl:element name="pramen">
      <xsl:copy-of select="@*" />
      <xsl:element name="horni_index">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <!-- Texty Igora Němce -->
  <xsl:template match="zkratka_kurziva">
    <xsl:element name="zkratka">
      <xsl:copy-of select="@*" />
      <xsl:element name="kurziva">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="kurziva_tucne">
    <xsl:element name="tucne">
      <xsl:copy-of select="@*" />
      <xsl:element name="kurziva">
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <!--
		pripisek_marginalni_soudoby_cizi_jazyk_horni_index
		pripisek_interlinearni_soudoby_horni_index
		pramen_rozepsani_zkratky
	-->
  <xsl:template match="pripisek_marginalni_soudoby_cizi_jazyk_horni_index">
    <xsl:element name="pripisek_marginalni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:element name="cizi_jazyk">
        <xsl:element name="horni_index">
          <xsl:value-of select="." />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pripisek_interlinearni_soudoby_horni_index">
    <xsl:element name="pripisek_interlinearni_soudoby">
      <xsl:copy-of select="@*" />
      <xsl:element name="horni_index">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="pramen_rozepsani_zkratky">
    <xsl:element name="pramen">
      <xsl:copy-of select="@*" />
      <xsl:element name="rozepsani_zkratky">
        <xsl:value-of select="." />
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <!--	<xsl:template match="horni_index_kurziva">
			<xsl:element name="kurziva">
			<xsl:copy-of select="@*" />
			<xsl:element name="horni_index">
				<xsl:value-of select="." />
			</xsl:element>
		</xsl:element>
	</xsl:template>-->
</xsl:stylesheet>