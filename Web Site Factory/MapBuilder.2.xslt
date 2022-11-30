<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"   />

    <xsl:template match="/">
        <map>
            <xsl:apply-templates select="map/node"/>
        </map>
    </xsl:template>

    <xsl:template match="node">
        <xsl:if test="not(ancestor-or-self::node[not(parent::node)]/preceding-sibling::*[@name=current()/@name or .//node/@name=current()/@name])">
            <node>
                <xsl:for-each select="@*">
                    <xsl:copy/>
                </xsl:for-each>
                <xsl:apply-templates/>
            </node>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text()"/>

</xsl:stylesheet>
