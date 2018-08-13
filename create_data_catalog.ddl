objects		
columnname	type	description
objectid	serial primary key	identity for objects
objectname	varchar(200)	object name
objecttype	varchar(200)	logic table, physical table,collection,dataset
Description	TEXT	table usage description
updatets	TIMESTAMP	update timestamp
		
		
		
		
#fields		
fieldid	serial primary key	identity for fields
collectionid	int	identity for objects
datasetid	int	identity for objects
fieldname	varchar(200)	field name
fieldtype	varchar(200)	field type
Description	TEXT	description
ispublic	BOOLEAN	open to public
iskey	BOOLEAN	key fields for object
updatets	TIMESTAMP	upate timestamp
		
		
#routine		
srcfieldid 	int	
tgtfieldid	int	
updatets	TIMESTAMP	


CREATE TABLE routine(
    srcfieldid INT REFERENCES fields(fieldid),
    tgtfieldid INT REFERENCES fields(fieldid)
)


CREATE SEQUENCE objectid_sequence
  start 1000
  increment 1;


CREATE SEQUENCE fieldid_sequence
  start 20000
  increment 1;

CREATE DATABASE data_catalog OWNER datateam TABLESPACE data_catalog_space;




CREATE TABLE objects(
    objectid Serial PRIMARY KEY,
    objectname VARCHAR(200) NOT NULL,
    objecttype VARCHAR(200) NOT NULL,
    parentobjectid INT default 0,
    description TEXT,
    updatets TIMESTAMP
);

WITH RECURSIVE r AS ( 
       SELECT * FROM objects WHERE objectid = 1000
     union ALL 
       SELECT objects.* FROM objects,r WHERE objects.parentobjectid = r.objectid 
     ) 
SELECT * FROM r ORDER BY objectid;

/*for collection*/
insert into objects values(nextval('objectid_sequence'),'patent','COLLECTION',0,'This is collection for patent data, worldwide patent, including docdb, official patent in each country',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'trademark','COLLECTION',0,'This is collection for trademark data, worldwide trademark, including docdb, official trademark in each country',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'literature','COLLECTION',0,'This is collection for literature data, worldwide literature',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'news','COLLECTION',0,'This is collection for news data, worldwide news, including docdb, official news in each country',current_timestamp);

/*for patent*/
insert into objects values(nextval('objectid_sequence'),'patent_biblio','DATASET',1000,'dataset for patent_biblio',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'patent_legal','DATASET',1000,'dataset for patent_biblio',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'patent_citation','DATASET',1000,'dataset for patent_biblio',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'patent_value','DATASET',1000,'dataset for patent_biblio',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'patent_abstract','DATASET',1000,'dataset for patent_biblio',current_timestamp);

/*for trademark*/
insert into objects values(nextval('objectid_sequence'),'trademark_biblio','DATASET',1001,'dataset for patent_biblio',current_timestamp);
insert into objects values(nextval('objectid_sequence'),'trademark_value','DATASET',1001,'dataset for patent_biblio',current_timestamp);


CREATE TABLE fields(
    fieldid Serial PRIMARY KEY,
    collectionid INT,
    datasetid INT,
    fieldname VARCHAR(200) NOT NULL,
    fieldtype VARCHAR(200) NOT NULL,
    Description	TEXT,
    ispublic	BOOLEAN	,
    iskey	BOOLEAN,
    updatets TIMESTAMP
);

insert into fields values(nextval('fieldid_sequence'),1000,1001,'patent_id','string',current_timestamp);


