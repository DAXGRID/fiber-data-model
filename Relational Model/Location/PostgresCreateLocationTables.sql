--------------------------------------------------------------------------------------------------------
-- Location Schema
--------------------------------------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS "Location"
    AUTHORIZATION postgres;

--------------------------------------------------------------------------------------------------------
-- Route Node
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."RouteNode" (
    "Id" BIGSERIAL PRIMARY KEY,
	"LocationId" bigint,
    "Coordinates" GEOMETRY(POINT,25832)
);

CREATE INDEX IF NOT EXISTS idx_route_node_coordinates ON "Location"."RouteNode" USING gist ("Coordinates");

--------------------------------------------------------------------------------------------------------
-- Route Segment
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."RouteSegment" (
    "Id" BIGSERIAL PRIMARY KEY,
	"LocationId" bigint,	
	"FromNodeId" bigint,	
	"ToNodeId" bigint,	
	"RouteSegmentKind" varchar(80),
    "Coordinates" GEOMETRY(LINESTRING,25832)
);

CREATE INDEX IF NOT EXISTS idx_route_segment_coordinates ON "Location"."RouteSegment" USING gist ("Coordinates");

--------------------------------------------------------------------------------------------------------
-- Route Segment Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."RouteSegmentKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Location"."RouteSegmentKind";

INSERT INTO "Location"."RouteSegmentKind" VALUES ('unkown', 0, 'Unknown', 'Uoplyst');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('buried', 1, 'Buried Underground Trench', 'Gravet tracé');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('drilling', 2, 'Directional Drilling', 'Styret underboring');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('roadCrossoverDrilling', 3, 'Road Crossing by Drilling', 'Vejunderføring boret');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('roadCrossoverDuctBank', 4, 'Road Crossing in Duct Bank', 'Vejunderføring i rørblok');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('microTrenching', 5, 'Micro Trenching', 'Micro-trenching');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('tunnel', 6, 'Tunnel Route', 'Rute igennem tunnel');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('areal', 7, 'Areal Route', 'Lufthængt tracé');
INSERT INTO "Location"."RouteSegmentKind" VALUES ('indoor', 8, 'Indoor Route', 'Indendørs tracé');

--------------------------------------------------------------------------------------------------------
-- Location "super-entity"
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."Location" (
    "LocationId" BIGSERIAL PRIMARY KEY,
	"MRID" uuid,
	"DirectionInformation" varchar,
	"LocationOriginKind" varchar(80)
);

--------------------------------------------------------------------------------------------------------
-- Location Origin Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."LocationOriginKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Location"."LocationOriginKind";

INSERT INTO "Location"."LocationOriginKind" VALUES ('unkown', 0, 'Unknown', 'Uoplyst');
INSERT INTO "Location"."LocationOriginKind" VALUES ('official', 1, 'Officiel', 'Officiel');
INSERT INTO "Location"."LocationOriginKind" VALUES ('pendingOfficial', 2, 'Pending to become official', 'Bliver officel på et tidspunkt');
INSERT INTO "Location"."LocationOriginKind" VALUES ('unofficial', 3, 'Unofficial', 'Uofficiel');


--------------------------------------------------------------------------------------------------------
-- Zone
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."Zone" (
    "LocationId" bigint PRIMARY KEY,
	"Name" varchar(255),
	"ZoneKind" varchar(80),
    "Coordinates" GEOMETRY(POLYGON,25832)
);

CREATE INDEX IF NOT EXISTS idx_zone_coordinates ON "Location"."Zone" USING gist ("Coordinates");

--------------------------------------------------------------------------------------------------------
-- Zone Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."ZoneKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Location"."ZoneKind";

INSERT INTO "Location"."ZoneKind" VALUES ('unkown', 0, 'Unknown', 'Uoplyst');
INSERT INTO "Location"."ZoneKind" VALUES ('centralOfficeArea', 1, 'Central Office Area', 'Teknikhus område');
INSERT INTO "Location"."ZoneKind" VALUES ('flexArea', 2, 'Flex Area', 'Flexområde');
INSERT INTO "Location"."ZoneKind" VALUES ('customerArea', 3, 'Customer Area', 'Kundeområde');

--------------------------------------------------------------------------------------------------------
-- Access Address
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."AccessAddress" (
    "LocationId" bigint PRIMARY KEY,
	"ExternalAccessAddressId" varchar(255),
	"PostalCode" varchar(4),
	"MunicipalCode" varchar(4),
	"RoadCode" varchar(4),
	"RoadSegmentId" bigint,
	"HouseNumber" varchar(5),
    "Coordinates" GEOMETRY(POINT,25832)
);

CREATE INDEX IF NOT EXISTS idx_access_address_coordinates ON "Location"."AccessAddress" USING gist ("Coordinates");


--------------------------------------------------------------------------------------------------------
-- Unit Address
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."UnitAddress" (
    "LocationId" bigint PRIMARY KEY,
	"AccessAddressId" bigint,
	"ExternalUnitAddressId" varchar(255),
	"FloorName" varchar(80),
	"RoomName" varchar(80),
	"UnitUsageKind" varchar(80),
	"UnitOwnershipKind" varchar(80)
);

--------------------------------------------------------------------------------------------------------
-- Unit Ownership Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."UnitOwnershipKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Location"."UnitOwnershipKind";

INSERT INTO "Location"."UnitOwnershipKind" VALUES ('unkown', 0, 'Unknown', 'Uoplyst');
INSERT INTO "Location"."UnitOwnershipKind" VALUES ('private', 1, 'Private', 'Privat ejet');
INSERT INTO "Location"."UnitOwnershipKind" VALUES ('housingAsscociation', 2, 'Housing Asscociation', 'Boligforening');
INSERT INTO "Location"."UnitOwnershipKind" VALUES ('commercial', 3, 'Commercial', 'Kommerciel ejet');
INSERT INTO "Location"."UnitOwnershipKind" VALUES ('govermental', 4, 'Govermental', 'Statsejet');
INSERT INTO "Location"."UnitOwnershipKind" VALUES ('other', 5, 'Other', 'Andet');

--------------------------------------------------------------------------------------------------------
-- Unit Usage Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."UnitUsageKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Location"."UnitUsageKind";

INSERT INTO "Location"."UnitUsageKind" VALUES ('unkown', 0, 'Unknown', 'Uoplyst');
INSERT INTO "Location"."UnitUsageKind" VALUES ('household', 1, 'Household', 'Bolig');
INSERT INTO "Location"."UnitUsageKind" VALUES ('accommodation', 2, 'Accommodation', 'Indkvatering');
INSERT INTO "Location"."UnitUsageKind" VALUES ('office', 3, 'Office', 'Kontor');
INSERT INTO "Location"."UnitUsageKind" VALUES ('retail', 4, 'Retail', 'Forretning');
INSERT INTO "Location"."UnitUsageKind" VALUES ('institutional', 4, 'Institutional', 'Institution');
INSERT INTO "Location"."UnitUsageKind" VALUES ('industrial', 4, 'Industrial', 'Industri');
INSERT INTO "Location"."UnitUsageKind" VALUES ('other', 5, 'Other', 'Andet');

--------------------------------------------------------------------------------------------------------
-- Building
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."Building" (
    "LocationId" bigint PRIMARY KEY,
	"ExternalBuildingId" varchar(255),
	"Name" varchar(255),
	"BuildingStructureKind" varchar(80),
    "Coordinates" GEOMETRY(POLYGON,25832)
);

CREATE INDEX IF NOT EXISTS idx_building_coordinates ON "Location"."Building" USING gist ("Coordinates");


--------------------------------------------------------------------------------------------------------
-- Building Structure Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."BuildingStructureKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Location"."BuildingStructureKind";

INSERT INTO "Location"."BuildingStructureKind" VALUES ('unkown', 0, 'Unknown', 'Uoplyst');
INSERT INTO "Location"."BuildingStructureKind" VALUES ('singleDwellingUnit', 1, 'singleDwellingUnit', 'Byggeri med en enhed');
INSERT INTO "Location"."BuildingStructureKind" VALUES ('multiDwellingUnit', 2, 'multiDwellingUnit', 'Etagebyggeri');


--------------------------------------------------------------------------------------------------------
-- Building Access Point
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."BuildingAccessPoint" (
    "LocationId" bigint PRIMARY KEY,
	"BuildingId" bigint,
	"AccessAddressId" bigint,
    "Coordinates" GEOMETRY(POINT,25832)
);

CREATE INDEX IF NOT EXISTS idx_building_access_point ON "Location"."BuildingAccessPoint" USING gist ("Coordinates");


--------------------------------------------------------------------------------------------------------
-- Road Segment
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."RoadSegment" (
    "LocationId" bigint PRIMARY KEY,
	"RoadCode" varchar(4),
	"MunicipalCode" varchar(4),
	"Name" varchar(255),
    "Coordinates" GEOMETRY(LINESTRING,25832)
);

CREATE INDEX IF NOT EXISTS idx_road_segment ON "Location"."RoadSegment" USING gist ("Coordinates");


--------------------------------------------------------------------------------------------------------
-- Post District
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."PostDistrict" (
    "Code" varchar(80) PRIMARY KEY,
	"Name" varchar(255)
);

--------------------------------------------------------------------------------------------------------
-- Municipal
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Location"."Municipal" (
    "Code" varchar(80) PRIMARY KEY,
	"Name" varchar(255)
);




