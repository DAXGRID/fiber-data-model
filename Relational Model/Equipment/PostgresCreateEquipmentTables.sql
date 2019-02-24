-- CREATE SCHEMA Equipment
CREATE SCHEMA IF NOT EXISTS "Equipment"
    AUTHORIZATION postgres;

--------------------------------------------------------------------------------------------------------
-- Conduit
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."Conduit" (
     "Id" BIGSERIAL PRIMARY KEY,
	 "MRID" uuid,
	 "ParentId" bigint,
	 "SequenceNumber" integer,
     "Name" varchar(200),
	 "InnerDiameter" float,
  	 "ConduitMarkingKind" varchar(80),
	 "ConduitCategoryKind" varchar(80),
	 "ConduitShapeKind" varchar(80),
	 "ConduitColorKind" varchar(80),
	 "AssetRef" uuid
);

--------------------------------------------------------------------------------------------------------
-- Conduit Marking Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."ConduitMarkingKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"ColorCode" varchar(80),
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Equipment"."ConduitMarkingKind";

INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('none', 0, null, 'None', 'Ingen markering');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('redStripe', 1, 'red', 'Red stripe', 'Rød stribe');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('blueStripe', 2, 'blue', 'Blue stripe', 'Blue stribe');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('greenStripe', 3, 'blue', 'Green stripe', 'Grøn stribe');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('whiteStripe', 4, 'blue', 'White stripe', 'Hvid stribe');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('aaa', 20, null, 'AAA mark', 'AAA');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('bbb', 21, null, 'BBB mark', 'BBB');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('ccc', 22, null, 'CCC mark', 'CCC');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('ddd', 23, null, 'DDD mark', 'DDD');
INSERT INTO "Equipment"."ConduitMarkingKind" VALUES ('eee', 25, null, 'EEE mark', 'EEE');


--------------------------------------------------------------------------------------------------------
-- Conduit Category Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."ConduitCategoryKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Equipment"."ConduitCategoryKind";

INSERT INTO "Equipment"."ConduitCategoryKind" VALUES ('singleDuct', 1, 'Single Duct', 'Enkeltrør');
INSERT INTO "Equipment"."ConduitCategoryKind" VALUES ('outerDuct', 2, 'Outer Duct', 'Ydrerør');
INSERT INTO "Equipment"."ConduitCategoryKind" VALUES ('innerDuct', 3, 'Inner Duct', 'Inderrør');

--------------------------------------------------------------------------------------------------------
-- Conduit Shape Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."ConduitShapeKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Equipment"."ConduitShapeKind";

INSERT INTO "Equipment"."ConduitShapeKind" VALUES ('unknown', 0, 'Unknown', 'Ukendt');
INSERT INTO "Equipment"."ConduitShapeKind" VALUES ('round', 1, 'Rund', 'Rundt');
INSERT INTO "Equipment"."ConduitShapeKind" VALUES ('flat', 2, 'Flat', 'Flad');

--------------------------------------------------------------------------------------------------------
-- Conduit Color Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."ConduitColorKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Equipment"."ConduitColorKind";

INSERT INTO "Equipment"."ConduitColorKind" VALUES ('unknown', 0, 'Unknown', 'Ukendt');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('clear', 1, 'Clear', 'Klar');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('blue', 2, 'Flat', 'Flad');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('yellow',3 , 'Yellow', 'Gul');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('white', 4, 'White', 'Hvid');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('green', 5, 'Green', 'Grøn');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('black', 6, 'Black', 'Sort');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('red', 7, 'Red', 'Rød');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('orange', 8, 'Orange', 'Orange');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('pink', 9, 'Pink', 'Pink');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('gray', 10, 'Gray', 'Grå');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('brown', 11, 'Brown', 'Brun');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('violet', 12, 'Violet', 'Violet');
INSERT INTO "Equipment"."ConduitColorKind" VALUES ('turquoise', 13, 'Turquoise', 'Turkis');


--------------------------------------------------------------------------------------------------------
-- Conduit Segment
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."ConduitSegment" (
     "Id" BIGSERIAL PRIMARY KEY,
	 "ConduitId" bigint,
	 "RouteSegmentId" bigint,
	 "SequenceNumber" integer
);

--------------------------------------------------------------------------------------------------------
-- Conduit Connectivity Node
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."ConduitConnectivityNode" (
     "Id" BIGSERIAL PRIMARY KEY,
	 "RouteNodeId" bigint,
	 "ConduitId" bigint,
	 "FromConduitSegmentId" bigint,
     "ToConduitSegmentId" bigint,
	 "ConduitConnectivityKind" varchar(80)
);

--------------------------------------------------------------------------------------------------------
-- Conduit Connectivity Kind
--------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "Equipment"."ConduitConnectivityKind" (
    "Code" varchar(80) PRIMARY KEY,
	"SortOrder" integer,
	"TextEnglish" varchar(255),
	"TextLocal" varchar(255)
);

TRUNCATE TABLE "Equipment"."ConduitConnectivityKind";

INSERT INTO "Equipment"."ConduitConnectivityKind" VALUES ('passBy', 0, 'Pass By', 'Pass By');
INSERT INTO "Equipment"."ConduitConnectivityKind" VALUES ('passThrough', 1, 'Pass Through', 'Pass Through');
INSERT INTO "Equipment"."ConduitConnectivityKind" VALUES ('cut', 2, 'Cut Over', 'Cut Over');
INSERT INTO "Equipment"."ConduitConnectivityKind" VALUES ('breakout',3 , 'Breakout', 'Breakout');
INSERT INTO "Equipment"."ConduitConnectivityKind" VALUES ('start',4 , 'End', 'End');
INSERT INTO "Equipment"."ConduitConnectivityKind" VALUES ('end',5 , 'End', 'End');
	
	