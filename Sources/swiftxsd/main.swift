//
//  main.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//

import Foundation
import PugiSwift

let str =
#"""
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns="http://www.thalesgroup.com/rtti/PushPort/CommonTypes/v1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tns="http://www.thalesgroup.com/rtti/PushPort/CommonTypes/v1" targetNamespace="http://www.thalesgroup.com/rtti/PushPort/CommonTypes/v1" elementFormDefault="qualified" attributeFormDefault="unqualified" version="1.0">
    <xs:simpleType name="RIDType">
            <xs:annotation>
                <xs:documentation>RTTI Train ID Type</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:maxLength value="16"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="UIDType">
            <xs:annotation>
                <xs:documentation>Train UID Type</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="6"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="TrainIdType">
            <xs:annotation>
                <xs:documentation>Train ID or Head Code Type</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="4"/>
                <xs:pattern value="[0-9][A-Z][0-9][0-9]"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="TOCType">
            <xs:annotation>
                <xs:documentation>ATOC Code Type</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="2"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="TiplocType">
            <xs:annotation>
                <xs:documentation>Tiploc Type (This is the short version of a TIPLOC - without spaces)</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:minLength value="1"/>
                <xs:maxLength value="7"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="CrsType">
            <xs:annotation>
                <xs:documentation>CRS Code Type</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="3"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="SuffixType">
            <xs:annotation>
                <xs:documentation>Denotes the suffix for a TIPLOC that identifies the instance on a circular route</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="1"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="PlatformType">
            <xs:annotation>
                <xs:documentation>Defines a platform number</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:minLength value="1"/>
                <xs:maxLength value="3"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="TrainLengthType">
            <xs:annotation>
                <xs:documentation>Defines the length of a train</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:unsignedShort">
                <xs:maxInclusive value="99"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="ActivityType">
            <xs:annotation>
                <xs:documentation>Activity Type (a set of 6 x 2 character strings).  Full details are provided in Common Interface File End User Specification.</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:minLength value="2"/>
                <xs:maxLength value="12"/>
                <xs:whiteSpace value="preserve"/>
                <xs:pattern value="([A-Z0-9\- ][A-Z0-9\- ]){1,6}"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="CIFTrainStatusType">
            <xs:annotation>
                <xs:documentation>Defines the transport service type using CIF Train Status value</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="1"/>
                <xs:pattern value="[BFPST12345]"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="CIFTrainCategoryType">
            <xs:annotation>
                <xs:documentation>Defines the train category</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:minLength value="0"/>
                <xs:maxLength value="2"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="RTTITimeType">
            <xs:annotation>
                <xs:documentation>Time as HH:MM</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:pattern value="([0-1][0-9]|2[0-3]):[0-5][0-9]"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="WTimeType">
            <xs:annotation>
                <xs:documentation>Working scheduled time as HH:MM[:SS]</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:pattern value="([0-1][0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="RTTIDateType">
            <xs:annotation>
                <xs:documentation>RTTI Date Type (basic XML date)</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:date"/>
        </xs:simpleType>
        <xs:simpleType name="RTTIDateTimeType">
            <xs:annotation>
                <xs:documentation>RTTI DateTime Type (basic XML date/time)</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:dateTime"/>
        </xs:simpleType>
        <xs:simpleType name="TimetableIDType">
            <xs:annotation>
                <xs:documentation>Unique Timetable identifier </xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="14"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="TimetableFilenameType">
            <xs:annotation>
                <xs:documentation>The name of a timetable file that can be downloaded via FTP.</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:minLength value="1"/>
                <xs:maxLength value="128"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="SnapshotIDType">
            <xs:annotation>
                <xs:documentation>Defines the ID for a snapshot file to be recovered via FTP</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:maxLength value="40"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="SourceTypeInst">
            <xs:annotation>
                <xs:documentation>RTTI CIS code, provided if forecast or actual source type is CIS</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="4"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="ReasonCodeType">
            <xs:annotation>
                <xs:documentation>A Darwin Reason Code</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:short"/>
        </xs:simpleType>
        <xs:simpleType name="DelayValueType">
            <xs:annotation>
                <xs:documentation>A signed delay value as a number of minutes</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:short"/>
        </xs:simpleType>
        <xs:simpleType name="TDAreaIDType">
            <xs:annotation>
                <xs:documentation>A TD area identifier.</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="2"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="TDBerthIDType">
            <xs:annotation>
                <xs:documentation>A TD berth identifier.</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:length value="4"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:simpleType name="DCISRequestID">
            <xs:annotation>
                <xs:documentation>A DCIS client request identifier</xs:documentation>
            </xs:annotation>
            <xs:restriction base="xs:string">
                <xs:minLength value="1"/>
                <xs:maxLength value="16"/>
                <xs:pattern value="[-_A-Za-z0-9]{1,16}"/>
            </xs:restriction>
        </xs:simpleType>
        <xs:attributeGroup name="CircularTimes">
            <xs:annotation>
                <xs:documentation>A scheduled time used to distinguish a location on circular routes. Note that all scheduled time attributes are marked as optional, but at least one must always be supplied. Only one value is required, and typically this should be the wtd value. However, for locations that have no wtd, or for clients that deal exclusively with public times, another value that is valid for the location may be supplied.</xs:documentation>
            </xs:annotation>
            <xs:attribute name="wta" type="tns:WTimeType" use="optional">
                <xs:annotation>
                    <xs:documentation>Working time of arrival.</xs:documentation>
                </xs:annotation>
            </xs:attribute>
            <xs:attribute name="wtd" type="tns:WTimeType" use="optional">
                <xs:annotation>
                    <xs:documentation>Working time of departure.</xs:documentation>
                </xs:annotation>
            </xs:attribute>
            <xs:attribute name="wtp" type="tns:WTimeType" use="optional">
                <xs:annotation>
                    <xs:documentation>Working time of pass.</xs:documentation>
                </xs:annotation>
            </xs:attribute>
            <xs:attribute name="pta" type="tns:RTTITimeType" use="optional">
                <xs:annotation>
                    <xs:documentation>Public time of arrival.</xs:documentation>
                </xs:annotation>
            </xs:attribute>
            <xs:attribute name="ptd" type="tns:RTTITimeType" use="optional">
                <xs:annotation>
                    <xs:documentation>Public time of departure.</xs:documentation>
                </xs:annotation>
            </xs:attribute>
        </xs:attributeGroup>
</xs:schema>
"""#

let schema = try! Schema(from: str)
print(schema)



