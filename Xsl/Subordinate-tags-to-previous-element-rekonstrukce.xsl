<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <!--<xsl:param name="debug" select="false()" />-->
  <xsl:template match="    body/*/*[2]    [preceding-sibling::*[1]/self::rekonstrukce]    [not(self::doplneny_text)]" priority="15">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Vybere pouze prvky třetí úrovně (znakové styly) v rámci odstavce, za nimiž následuje element, který by měl být sloučen.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="    body/*/*    [following-sibling::*[1]/self::rekonstrukce[not(contains(., ' '))]]    [    following-sibling::*[2]/self::text    [not(starts-with(., ' '))]    [substring(., string-length(.), 1) = ' ']    [not(contains(normalize-space(.), ' '))]    ]    [not(self::doplneny_text)]    [not(self::foliace)]    [not(self::cislo_verse)]    [not(self::relator)]    [substring(., string-length(.), 1) != ' ']    [not(following-sibling::*[3][self::poznamka])]    " priority="5">
    <xsl:copy-of select="." />
  </xsl:template>
  <!--
		body/*/*
		[following-sibling::*[1]/self::rekonstrukce]
		[not(self::doplneny_text)]
		[not(self::foliace)]
		[not(self::cislo_verse)]
		[not(self::relator)]
		[substring(., string-length(.), 1) != ' ' ]
		
		[not(preceding-sibling::*[1]/self::foliace[not(@rend='space' or substring(., string-length(.), 1) != ' ')))]
		-->
  <!--	
<xsl:template match="	body/*/rekonstrukce
	[preceding-sibling::*[1][self::doplneny_text]]"
	>
	<xsl:if test="$debug">
		<xsl:message> vynechaný prvek (<xsl:value-of select="name()"/>: <xsl:value-of select="."/>) </xsl:message>
	</xsl:if>
</xsl:template>
-->
  <xsl:template match="    body/*/*    [following-sibling::*[1]/self::rekonstrukce]    [not(self::doplneny_text)]    [not(self::foliace)]    [not(self::cislo_verse)]    [not(self::relator)]    [substring(., string-length(.), 1) != ' ']        ">
    <!--<xsl:template match="body/*/popisek_k_obrazku[following-sibling::*[1]/self::rekonstrukce]">-->
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <!--<xsl:if test="preceding-sibling::*[1][self::rekonstrukce] and preceding-sibling::*[2][self::doplneny_text]">
				<xsl:copy-of select="preceding-sibling::*[1]"/>
			</xsl:if>-->
      <!--<xsl:if test="preceding-sibling::*[1][self::rekonstrukce[substring(., string-length(.), 1) != ' ']]">
				<xsl:copy-of select="preceding-sibling::*[1]"/>
			</xsl:if>-->
      <xsl:apply-templates />
      <xsl:choose>
        <xsl:when test="following-sibling::*[2]/self::poznamka">
          <xsl:element name="rekonstrukce">
            <xsl:copy-of select="following-sibling::*[1]/text()" />
            <xsl:copy-of select="following-sibling::*[2]" />
          </xsl:element>
        </xsl:when>
        <xsl:when test="       following-sibling::node()[2]/self::transliterace and       following-sibling::node()[3]/self::poznamka">
          <xsl:element name="rekonstrukce">
            <xsl:copy-of select="following-sibling::*[1]/text()" />
            <xsl:copy-of select="following-sibling::*[2]" />
            <xsl:copy-of select="following-sibling::*[3]" />
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="following-sibling::*[1]" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <!--
		body/*/*[self::text]
[preceding-sibling::*[1]/self::rekonstrukce[not(contains(., ' '))]]
[
preceding-sibling::*[2]/self::text[substring(., string-length(.), 1) = ' ' ]

or 
(
preceding-sibling::*[2]/self::text[substring(., string-length(.), 1) != ' ' ]
and
preceding-sibling::*[3]/self::rekonstrukce
)

]
		-->
  <!--
		<rekonstrukce>Ne</rekonstrukce>
    <text>nie to veliká věc milovati dob</text>
    <rekonstrukce>r</rekonstrukce>
    <text>odějcě a přá</text>
    <rekonstrukce>tely</rekonstrukce>
    <text>, ale veliká věc </text>
	-->
  <xsl:template match="/body/*/   text[contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' ']] [preceding-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' ']] " priority="18">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <!--	-->
  <xsl:template match="/body/*/   text[contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[3][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [preceding-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' ']] [preceding-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' '][translate(substring(., 1, 1), ',?!;:', '') = '']] [ following-sibling::*[3][self::rekonstrukce][not(contains(normalize-space(.), ' '))] [substring(., string-length(.), 1) != ' '] ]" priority="18">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <!--<xsl:copy-of select="preceding-sibling::*[1]" />-->
      <xsl:apply-templates />
      <!--				<xsl:copy-of select="following-sibling::*[1]"/>-->
    </xsl:copy>
  </xsl:template>
  <!--
		body/*/*[self::text]
[preceding-sibling::*[1]/self::rekonstrukce[not(contains(., ' '))]]
[translate(substring(., 1, 1), ' ,?!;:', '') != '']
		-->
  <xsl:template match="    body/*/*[self::text]    [preceding-sibling::*[1]/self::rekonstrukce[not(contains(., ' '))]]    [translate(., ',?!;:.', '') != '']    [    preceding-sibling::*[2]/self::text[substring(., string-length(.), 1) = ' ']        or    (    preceding-sibling::*[2]/self::text[substring(., string-length(.), 1) != ' ']    and    (    preceding-sibling::*[3]/self::rekonstrukce[substring(., string-length(.), 1) != ' '][contains(., ' ')]    or    (    preceding-sibling::*[3]/self::foliace[not(@rend = 'space' or substring(., string-length(.), 1) != ' ')]    and    preceding-sibling::*[4]/self::text[substring(., string-length(.), 1) != ' ']    )    )    )        ]    " priority="15">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:if test="following-sibling::*[1]/self::poznamka">
        <xsl:copy-of select="following-sibling::*[1]" />
      </xsl:if>
      <xsl:if test="following-sibling::*[1]/self::rekonstrukce[substring(., string-length(.), 1) = ' ' or (substring(., string-length(.), 1) != ' ' and contains(., ' ') )]">
        <xsl:copy-of select="following-sibling::*[1]" />
      </xsl:if>
    </xsl:copy>
  </xsl:template>
  <!-- ZrcSpasA -->
  <xsl:template match="body/*/text   [following-sibling::*[1]/self::rekonstrukce]   [following-sibling::*[2]/self::poznamka]   [following-sibling::*[3]/self::text]   [following-sibling::*[4]/self::doplneny_text]   " priority="18">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
      <xsl:copy-of select="following-sibling::*[2]" />
      <xsl:copy-of select="following-sibling::*[3]" />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <Vers>
          <rekonstrukce>Kter</rekonstrukce>
          <text>ýž </text>
          <poznamka>čitelné pouze „…ýž“ </poznamka>
          <text>svatební veselí</text>
        </Vers>
      </xd:pre>
    </xd:desc>
  </xd:doc>
  <xsl:template match="    body/*/*    [preceding-sibling::*[1]/self::rekonstrukce]    [not(self::doplneny_text)]    [not(self::foliace)]    [not(self::cislo_verse)]    [not(self::relator)]    [not(preceding-sibling::*[2])]    [following-sibling::*[1]/self::poznamka]    " priority="20">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:choose>
        <xsl:when test="following-sibling::*[1]/self::poznamka">
          <xsl:copy-of select="following-sibling::*[1]" />
        </xsl:when>
        <xsl:otherwise>
          <!--<xsl:copy-of select="following-sibling::*[1]"/>-->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <!-- KomKancTisk -->
  <xsl:template match="    body/*/rekonstrukce    [not(contains(., ' '))]    [substring(preceding-sibling::node()[1], string-length(preceding-sibling::node()[1]), 1) = ' ']    [following-sibling::*[1]/self::foliace]    ">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="    body/*/rekonstrukce    [not(preceding-sibling::*[1]/self::doplneny_text)]    [not(preceding-sibling::*[1]/self::foliace)]    [not(preceding-sibling::*[1]/self::cislo_verse)]    [not(preceding-sibling::*[1]/self::relator)]    [not(following-sibling::node()[1]/self::text)]    [not(following-sibling::node()[1]/self::foliace)]" priority="10">
    <xsl:if test="$debug">
      <xsl:message> vynechaný text: <xsl:value-of select="." /></xsl:message>
    </xsl:if>
  </xsl:template>
  <!--	
	 <rekonstrukce>ve</rekonstrukce>
    <text>likého. </text>
    <rekonstrukce>Velik</rekonstrukce>
    <text>o</text>
    <rekonstrukce>st r</rekonstrukce>
	-->
  <xsl:template match="/body/*/   rekonstrukce[not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' '] [following-sibling::*[1][self::text][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[2][self::rekonstrukce][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' ']]   " priority="22">
    <xsl:if test="$debug">
      <xsl:message> vynechaný text: <xsl:value-of select="." /></xsl:message>
    </xsl:if>
  </xsl:template>
  <!-- ZrcSpasA -->
  <xsl:template match="body/*/   rekonstrukce[not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[1][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' ']] [following-sibling::*[1][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' ']] [following-sibling::*[2][self::doplneny_text][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) = ' ']]">
    <xsl:if test="$debug">
      <xsl:message> vynechaný text: <xsl:value-of select="." /></xsl:message>
    </xsl:if>
  </xsl:template>
  <!-- XXXX
	[not(following-sibling::*[1]/self::text[translate(. , '.?!;:', '') != ''])]
	-->
  <!-- [following-sibling::*[1]/self::poznamka] -->
  <!--	<xsl:template match="body/*/rekonstrukce[preceding-sibling::*[1]/self::popisek_k_obrazku]" priority="10" />-->
  <xsl:template match="    body/*/rekonstrukce[not(following-sibling::*[1]/self::rekonstrukce)]        [not(preceding-sibling::*[1]/self::doplneny_text)]    [not(preceding-sibling::*[1]/self::poznamka)]    [not(preceding-sibling::*[1]/self::foliace)]    [not(preceding-sibling::*[1]/self::cislo_verse)]    [not(preceding-sibling::*[1]/self::relator)]    " priority="15">
    <xsl:if test="$debug">
      <xsl:message> vynechaný text: <xsl:value-of select="." /></xsl:message>
    </xsl:if>
  </xsl:template>
  <!--
		<text>k sobě samé</text>
    <rekonstrukce>m</rekonstrukce>
    <text>u </text>
    <poznamka>Rekonstruováno podle tisku uloženého v … signaturou 54 K 023269. </poznamka>
    <text>poberu.</text>
		-->
  <xsl:template match="body/*/text   [preceding-sibling::*[1][self::rekonstrukce]]   [following-sibling::*[1][self::poznamka]]   " priority="5">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <!--<xsl:copy-of select="preceding-sibling::*[1]"/>-->
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <!--
		<text>a sě skrzě opakovánie a zatraceni nebu</text>
    <rekonstrukce>de</rekonstrukce>
    <text>m. Ó, milý Jesu Christe, … s tebú přěbývati. Amen. </text>
    <popisek_k_obrazku>Buožie vzkřiešenie </popisek_k_obrazku>
    <text>#</text>
	-->
  <xsl:template match="/body/*/   text[contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' '] [preceding-sibling::*[3][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [preceding-sibling::*[2][self::text]] [preceding-sibling::*[1][self::rekonstrukce]] [following-sibling::*[1][self::popisek_k_obrazku]] " priority="5">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!--
		 <rekonstrukce>své</rekonstrukce>
    <text>ho nebeského otcě prosil a nám </text>
    <rekonstrukce>pří</rekonstrukce>
    <text>klad dal, abychom nep</text>
    <rekonstrukce>řátel</rekonstrukce>
    <text>y milovali. Nebo když našě nepřátely milujem a za ně </text>
    <poznamka>nejisté čtení </poznamka>
    <text>buoha prosímy, ukazujem, že smy synové buoží a bratrové Kristovi. Nebť jest to učinil, abychmy nepřátely milovali, abychmy synové </text>
    <rekonstrukce>o</rekonstrukce>
    <text>tcě jeho, jenž na nebi jest, býti mohli. </text>
	-->
  <xsl:template match="body/*/text   [contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' '] [preceding-sibling::*[3][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [preceding-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' ']] [preceding-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[1][self::poznamka][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' ']] [following-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' ']] [following-sibling::*[3][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']]   " priority="8">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <!--
		<poznamka>zastřižený list </poznamka>
    <text>Jan Hruška, kderý u něho … bejti. Žádám Vaši knížecí Mil</text>
    <rekonstrukce>o</rekonstrukce>
    <text>st </text>
    <pramen>milsti </pramen>
    <text>pokud by se tak stalo, … by jeho Vaše knížecká Mil</text>
		-->
  <xsl:template match="body/*/text   [not(contains(normalize-space(.), ' '))]   [preceding-sibling::*[1][self::rekonstrukce]]   [following-sibling::*[1][self::pramen]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!--
		<rekonstrukce>li</rekonstrukce>
		<text>d h</text>
		<rekonstrukce>lé</rekonstrukce>
		<text>daje, i posmieváchu sě jemu kniežata kněžská i </text>
		<rekonstrukce>staro</rekonstrukce>
		<text>sty a súdce jich s mi</text>
		<rekonstrukce>stry</rekonstrukce>
		-->
  <!-- ZrcSpasA -->
  <xsl:template match="body/*/text   [not(contains('.,?!;:', substring(., 1, 1) ))]   [substring(., string-length(.), 1) = ' ']   [preceding-sibling::*[1][self::rekonstrukce[not(contains(., ' '))]]]   [preceding-sibling::*[2][self::text[contains(., ' ')]]]   [preceding-sibling::*[3][self::rekonstrukce[not(contains(., ' '))]]]   [following-sibling::*[1][self::rekonstrukce[not(contains(., ' '))]]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!-- ZrcSpasA -->
  <!--
		<text>ú m</text>
  <rekonstrukce>il</rekonstrukce>
		<text>ostí ner</text>
  <rekonstrukce>á</rekonstrukce>
  <text>čil </text>
  <doplneny_text>ostřieci. </doplneny_text>
		-->
  <xsl:template match="body/*/text   [not(preceding-sibling::*[3][self::doplneny_text])]   [not(preceding-sibling::*[2][self::doplneny_text])]   [not(preceding-sibling::*[2][self::foliace])]   [preceding-sibling::*[1][self::rekonstrukce[not(contains(., ' '))]]]   [following-sibling::*[1][self::doplneny_text]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!--	
	<text>dřěvniem rozdielu sl</text>
    <rekonstrukce>yšie</rekonstrukce>
    <text>chom o člověčiem v</text>
    <rekonstrukce>ykú</rekonstrukce>
    <text>pení. Potom slyšmy </text>
    <doplneny_text>o </doplneny_text>
	-->
  <xsl:template match="body/*/   text[contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' ']] [preceding-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' ']] [following-sibling::*[3][self::doplneny_text]]" priority="8">
    <xsl:copy-of select="." />
  </xsl:template>
  <!--
		<Normalni>
    <iniciala>V </iniciala>
    <text>dřěvniem rozdielu slyšiechom, kak Kristus … umdlen, že té těžké klá</text>
    <rekonstrukce>d</rekonstrukce>
    <text>y sám </text>
    <doplneny_text>nésti </doplneny_text>
    <rekonstrukce>nem</rekonstrukce>
    <text>ohl. Tehdy přinutichu někakého jménem Šimona syren</text>
    <rekonstrukce>e</rekonstrukce>
    <text>nského, aby pomohl Kristovi </text>
    <doplneny_text>nésti </doplneny_text>
    <text>jeho křížě. A když přijidechu k huo</text>
				<rekonstrukce>řě </rekonstrukce>
    <text>Kalvarie a viděli jej ustalého, dali jemu octa se žlučí smiešeného a vína s myrrú. To pitie zlost židov</text>
  </Normalni>
	-->
  <xsl:template match="body/*/   text[contains(normalize-space(.), ' ')][substring(., string-length(.), 1) = ' ']  [preceding-sibling::*[2][self::text][contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' ']] [preceding-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[1][self::doplneny_text][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) = ' ']] [following-sibling::*[2][not(self::doplneny_text)]]  [not(following-sibling::*[3][self::rekonstrukce[not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']])]   " priority="5">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!--
		<rekonstrukce>av </rekonstrukce>
    <doplneny_text>a </doplneny_text>
    <rekonstrukce>brá</rekonstrukce>
    <text>nu i s vraty s sebú vzal. Tak</text>
    <rekonstrukce>ež Christ</rekonstrukce>
    <text>us do města svých ne</text>
    <rekonstrukce>přá</rekonstrukce>
    <text>tel, točíš do pekla moc</text>
    <rekonstrukce>ně </rekonstrukce>
    <doplneny_text>všel </doplneny_text>
	-->
  <xsl:template match="body/*/   text[contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[3][self::rekonstrukce]] [preceding-sibling::*[2][self::text]] [preceding-sibling::*[1][self::rekonstrukce][not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' ']] [following-sibling::*[1][self::rekonstrukce]] [following-sibling::*[2][self::doplneny_text]] [following-sibling::*[3][self::text]]   " priority="18">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <!--
		 <doplneny_text>a </doplneny_text>
    <rekonstrukce>člo</rekonstrukce>
    <text>vě</text>
    <rekonstrukce>kem n</rekonstrukce>
    <text>emohl </text>
		-->
  <xsl:template match="/body/*/   text[not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[3][self::rekonstrukce]] [preceding-sibling::*[2][self::doplneny_text]] [preceding-sibling::*[1][self::rekonstrukce]] [following-sibling::*[1][self::rekonstrukce]] [following-sibling::*[2][self::text]] [following-sibling::*[3][self::doplneny_text]]" priority="2">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <!--	
	<rekonstrukce>in</rekonstrukce>
    <text>hed jemu jiné od </text>
    <rekonstrukce>diáblu</rekonstrukce>
    <text>ov bývá přihoto</text>
    <rekonstrukce>váno</rekonstrukce>
    <doplneny_text>. </doplneny_text>
	-->
  <xsl:template match="/body/*/   text[contains(normalize-space(.), ' ')][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[3][self::rekonstrukce]] [preceding-sibling::*[2][self::text]] [preceding-sibling::*[1][self::rekonstrukce]] [following-sibling::*[1][self::rekonstrukce]] [following-sibling::*[2][self::doplneny_text]] [following-sibling::*[3][self::popisek_k_obrazku]]" priority="18">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/body/*/   text[not(contains(normalize-space(.), ' '))][substring(., string-length(.), 1) != ' '] [preceding-sibling::*[3][self::text]] [preceding-sibling::*[2][self::doplneny_text]] [preceding-sibling::*[1][self::rekonstrukce]] [following-sibling::*[1][self::rekonstrukce]] [following-sibling::*[2][self::text]] [following-sibling::*[3][self::rekonstrukce]] " priority="18">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::*[1]" />
    </xsl:copy>
  </xsl:template>
  <!--
		<Normalni>
    <foliace>89r </foliace>
    <rekonstrukce>T</rekonstrukce>
    <text>aké nemá žádný konšel s … pokuty jmě dáti a zaplatiti.</text>
  </Normalni>
	-->
  <xsl:template match="body/*/text   [preceding-sibling::*[1][self::rekonstrukce[not(contains(., ' '))]]]   [preceding-sibling::*[2][self::foliace[substring(., string-length(.), 1) = ' ']]]   [preceding-sibling::*[2][not(preceding-sibling::*)]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!--
		<text>A když vjide Je</text>
    <rekonstrukce>žíš</rekonstrukce>
    <text>, tehdy od korúhevníkóv, jenž … proti korúhevníkóm. Tehdy Pilát </text>
    <foliace>9r </foliace>
    <rekonstrukce>ve</rekonstrukce>
    <text>ce kniežatóm židovským i k … sami ot sebe sú </text>
    <doplneny_text>sě </doplneny_text>
		-->
  <xsl:template match="body/*/rekonstrukce   [preceding-sibling::*[1][self::foliace[substring(., string-length(.), 1) = ' ']]]   ">
    <xsl:if test="$debug">
      <xsl:message>vynechaný element <xsl:value-of select="name()" /></xsl:message>
    </xsl:if>
  </xsl:template>
  <!-- ZrcSpasA -->
  <xsl:template match="body/*/text   [contains('.,?!;:', substring(., 1, 1) )]   [substring(., string-length(.), 1) = ' ']   [preceding-sibling::*[1][self::rekonstrukce]]   [not(following-sibling::*[1][self::emendace])]   [not(following-sibling::*[1][self::pramen])]   [following-sibling::*[1][self::rekonstrukce]]   [following-sibling::*[2][self::text]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="preceding-sibling::*[1]" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!-- XXXXX
		[not(contains(',.!?;', substring(., 1, 1)))]
	-->
  <!-- ZrcSpasA -->
  <xsl:template match="body/*/text   [substring(., string-length(.), 1) = ' ']   [not(contains(',.!?;', substring(., 1, 1)))]   [preceding-sibling::*[2][self::rekonstrukce]]   [preceding-sibling::*[1][self::poznamka]]   [following-sibling::*[1][self::doplneny_text]]   ">
    <xsl:if test="$debug">
      <xsl:message> vynechaný text: <xsl:value-of select="." /></xsl:message>
    </xsl:if>
  </xsl:template>
  <!-- KomKancTisk -->
  <xsl:template match="    body/*/rekonstrukce    [not(contains(., ' '))]    [substring(preceding-sibling::node()[1], string-length(preceding-sibling::node()[1]), 1) = ' ']    [following-sibling::*[1]/self::foliace]    " priority="20">
    <xsl:copy-of select="." />
  </xsl:template>
  <!-- KomKancTisk -->
  <xsl:template match="    body/*/rekonstrukce    [not(contains(., ' '))]    [substring(preceding-sibling::node()[1], string-length(preceding-sibling::node()[1]), 1) = ' ']    [following-sibling::*[1]/self::text[not(contains(., ' '))]]    [following-sibling::*[1]/self::text[not(contains(., ','))]]    " priority="20">
    <xsl:copy-of select="." />
  </xsl:template>
</xsl:stylesheet>