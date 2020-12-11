--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: addclient(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION addclient(id integer, newname character varying, newaddress character varying, newphone character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO client VALUES (id, newName, newAddress, newPhone);
END;
$$;


ALTER FUNCTION public.addclient(id integer, newname character varying, newaddress character varying, newphone character varying) OWNER TO njackson;

--
-- Name: auditlogfunc(); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION auditlogfunc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN INSERT INTO AUDIT(CLIENT_ID, ENTRY_DATE) VALUES (new.clientid, current_timestamp); RETURN NEW; END; $$;


ALTER FUNCTION public.auditlogfunc() OWNER TO njackson;

--
-- Name: avgnsalary(integer); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION avgnsalary(n integer) RETURNS TABLE(average_salary numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
      RETURN QUERY SELECT AVG(salary)::numeric(10,2)
      FROM Employees
      LIMIT n;
END;
$$;


ALTER FUNCTION public.avgnsalary(n integer) OWNER TO njackson;

--
-- Name: delclient(); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION delclient() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE
    FROM Employees
    WHERE Employees.clientID = old.clientID;

    DELETE 
    FROM field_info
    WHERE field_info.clientID = old.clientID;

    DELETE
    FROM incomingdeliveries i
    WHERE i.clientID = old.clientID;

    DELETE
    FROM outgoingdeliveries o
    WHERE o.clientID = old.clientID;

    DELETE 
    FROM livestock
    WHERE livestock.clientID = old.clientID;

    DELETE
    FROM inventory
    WHERE inventory.clientID = old.clientID;
    
    DELETE
    FROM transactions
    WHERE transactions.clientID = old.clientID;

    RETURN OLD;
END;
$$;


ALTER FUNCTION public.delclient() OWNER TO njackson;

--
-- Name: equipmaintlog(); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION equipmaintlog() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO equipmentlog(equipmentnumber, fieldid, status, entry_date)
    VALUES (new.equipmentnumber, new.fieldid, new.status, current_timestamp);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.equipmaintlog() OWNER TO njackson;

--
-- Name: get_sum(numeric, numeric); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION get_sum(a numeric, b numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN a+b;
END; $$;


ALTER FUNCTION public.get_sum(a numeric, b numeric) OWNER TO njackson;

--
-- Name: inserttest(integer, integer); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION inserttest(a integer, b integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
Begin
    INSERT INTO test VALUES (a);
    INSERT INTO test VALUES (b);
END;
$$;


ALTER FUNCTION public.inserttest(a integer, b integer) OWNER TO njackson;

--
-- Name: updateinstead(); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION updateinstead() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE client
    SET name = new.clientname
    WHERE name = old.clientname;

    UPDATE inventory
    SET name = new.inventoryname, amount = new.amount
    WHERE name = old.inventoryname
    AND amount = old.amount;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.updateinstead() OWNER TO njackson;

--
-- Name: upincamt(); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION upincamt() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
price numeric(4,2);

BEGIN
    UPDATE inventory
    SET amount = amount + new.stock_levels
    WHERE new.stockID = inventory.stockID;

    SELECT priceperunit INTO price
    FROM inventory
    WHERE new.stockID = inventory.stockID;

    INSERT INTO transactions (clientid,transaction,transactionID,amount) VALUES
    (new.clientID, 'Inbound Delivery', new.in_deliveryid,  -1 * new.stock_levels * price);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.upincamt() OWNER TO njackson;

--
-- Name: upinvamt(); Type: FUNCTION; Schema: public; Owner: njackson
--

CREATE FUNCTION upinvamt() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
price numeric(4,2);

BEGIN
    UPDATE inventory
    SET amount = amount - new.stockamount
    WHERE new.clientID = inventory.clientID
    AND new.stockID = inventory.stockID;

    SELECT priceperunit INTO price
    FROM inventory
    WHERE new.stockID = inventory.stockID;

    INSERT INTO transactions (clientid,transaction,transactionid,amount) VALUES
    (new.clientID, 'Outbound Delivery', new.out_deliveryid,new.stockamount*price);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.upinvamt() OWNER TO njackson;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: client; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE client (
    clientid integer NOT NULL,
    name character varying(50) DEFAULT NULL::character varying,
    address character varying(50) DEFAULT NULL::character varying,
    phone character varying(15) DEFAULT NULL::character varying
);


ALTER TABLE public.client OWNER TO njackson;

--
-- Name: equipment; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE equipment (
    equipmentnumber integer NOT NULL,
    equipmenttype character varying(50),
    fuel character varying(8) DEFAULT NULL::character varying,
    status character varying(50) DEFAULT NULL::character varying,
    brand character varying(50) DEFAULT NULL::character varying,
    fieldid integer
);


ALTER TABLE public.equipment OWNER TO njackson;

--
-- Name: field_info; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE field_info (
    fieldid integer NOT NULL,
    clientid integer,
    acreage integer,
    cropid integer
);


ALTER TABLE public.field_info OWNER TO njackson;

--
-- Name: clients_equipment; Type: VIEW; Schema: public; Owner: njackson
--

CREATE VIEW clients_equipment AS
    SELECT c.name, e.equipmenttype AS equipment, e.brand, e.status AS current_status FROM client c, equipment e, field_info f WHERE ((c.clientid = f.clientid) AND (f.fieldid = e.fieldid));


ALTER TABLE public.clients_equipment OWNER TO njackson;

--
-- Name: crops; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE crops (
    cropid integer NOT NULL,
    croptype text,
    name text,
    amount integer
);


ALTER TABLE public.crops OWNER TO njackson;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE employees (
    employeeid integer NOT NULL,
    clientid integer,
    name character varying(20) DEFAULT NULL::character varying,
    phone character varying(50) DEFAULT NULL::character varying,
    employmentstatus character varying(50) DEFAULT NULL::character varying,
    salary integer
);


ALTER TABLE public.employees OWNER TO njackson;

--
-- Name: employee_roster; Type: VIEW; Schema: public; Owner: njackson
--

CREATE VIEW employee_roster AS
    SELECT client.name AS clientname, employees.name AS employeename, employees.employmentstatus AS job, employees.salary AS pay FROM employees, client WHERE (client.clientid = employees.clientid) ORDER BY employees.salary DESC;


ALTER TABLE public.employee_roster OWNER TO njackson;

--
-- Name: equipmentlog; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE equipmentlog (
    equipmentnumber integer NOT NULL,
    fieldid integer,
    status character varying(20),
    entry_date date
);


ALTER TABLE public.equipmentlog OWNER TO njackson;

--
-- Name: incomingdeliveries; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE incomingdeliveries (
    in_deliveryid integer NOT NULL,
    clientid integer,
    stockid integer,
    stock_levels integer,
    deliverydate date,
    supplier character varying(30)
);


ALTER TABLE public.incomingdeliveries OWNER TO njackson;

--
-- Name: incomingdeliveries_in_deliveryid_seq; Type: SEQUENCE; Schema: public; Owner: njackson
--

CREATE SEQUENCE incomingdeliveries_in_deliveryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incomingdeliveries_in_deliveryid_seq OWNER TO njackson;

--
-- Name: incomingdeliveries_in_deliveryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: njackson
--

ALTER SEQUENCE incomingdeliveries_in_deliveryid_seq OWNED BY incomingdeliveries.in_deliveryid;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE inventory (
    stockid integer NOT NULL,
    clientid integer,
    name text,
    category text,
    amount integer,
    priceperunit numeric(4,2) DEFAULT 0
);


ALTER TABLE public.inventory OWNER TO njackson;

--
-- Name: inventory_log; Type: VIEW; Schema: public; Owner: njackson
--

CREATE VIEW inventory_log AS
    SELECT client.name AS clientname, inventory.name AS stockname, inventory.amount FROM inventory, client WHERE (client.clientid = inventory.clientid);


ALTER TABLE public.inventory_log OWNER TO njackson;

--
-- Name: livestock; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE livestock (
    speciesid integer NOT NULL,
    clientid integer,
    species character varying(25) DEFAULT NULL::character varying,
    food character varying(25) DEFAULT NULL::character varying,
    feed_levels character varying(45) DEFAULT NULL::character varying
);


ALTER TABLE public.livestock OWNER TO njackson;

--
-- Name: most_acres; Type: VIEW; Schema: public; Owner: njackson
--

CREATE VIEW most_acres AS
    SELECT c.name, sum(f.acreage) AS total_acres FROM client c, field_info f WHERE (c.clientid = f.clientid) GROUP BY c.name ORDER BY sum(f.acreage) DESC;


ALTER TABLE public.most_acres OWNER TO njackson;

--
-- Name: outgoingdeliveries; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE outgoingdeliveries (
    out_deliveryid integer NOT NULL,
    clientid integer,
    stockid integer,
    stockamount integer,
    deliverydate date,
    recipient character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.outgoingdeliveries OWNER TO njackson;

--
-- Name: outgoingdeliveries_out_deliveryid_seq; Type: SEQUENCE; Schema: public; Owner: njackson
--

CREATE SEQUENCE outgoingdeliveries_out_deliveryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.outgoingdeliveries_out_deliveryid_seq OWNER TO njackson;

--
-- Name: outgoingdeliveries_out_deliveryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: njackson
--

ALTER SEQUENCE outgoingdeliveries_out_deliveryid_seq OWNED BY outgoingdeliveries.out_deliveryid;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: njackson; Tablespace: 
--

CREATE TABLE transactions (
    id integer NOT NULL,
    clientid integer,
    transaction character varying(40),
    transactionid integer,
    amount numeric(8,2)
);


ALTER TABLE public.transactions OWNER TO njackson;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: njackson
--

CREATE SEQUENCE transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO njackson;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: njackson
--

ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;


--
-- Name: in_deliveryid; Type: DEFAULT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY incomingdeliveries ALTER COLUMN in_deliveryid SET DEFAULT nextval('incomingdeliveries_in_deliveryid_seq'::regclass);


--
-- Name: out_deliveryid; Type: DEFAULT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY outgoingdeliveries ALTER COLUMN out_deliveryid SET DEFAULT nextval('outgoingdeliveries_out_deliveryid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY transactions ALTER COLUMN id SET DEFAULT nextval('transactions_id_seq'::regclass);


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY client (clientid, name, address, phone) FROM stdin;
1	Ogle	8018 Sachs Lane	627-690-4132
2	Grosvenor	14 Memorial Place	926-343-5481
3	Espinola	638 Stang Junction	784-219-6469
4	Klaas	24855 Lakewood Terrace	977-896-4852
5	Cutridge	59 Carberry Junction	379-454-4020
6	Landy	983 Prairieview Place	588-931-8658
7	Thirsk	20 Towne Way	804-980-7201
8	Reimer	586 Golf Point	620-232-8011
9	Wahncke	917 Oxford Parkway	392-260-0175
10	Rosser	505 Continental Point	287-103-5208
11	Otto	016 Fair Oaks Plaza	543-837-7330
12	Softley	708 Karstens Place	569-191-3898
13	Booty	964 Lotheville Plaza	544-218-2251
14	Laban	1 Blackbird Pass	317-681-2131
15	Le Guin	581 6th Lane	106-539-3500
16	Tunder	80978 Del Sol Way	728-338-3598
17	MacLice	7937 Ronald Regan Center	714-147-3709
18	Hamberstone	20 Spohn Court	347-221-3131
19	McGonnell	815 Meadow Valley Pass	556-834-2812
20	D'Angeli	7 Becker Circle	177-228-0927
\.


--
-- Data for Name: crops; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY crops (cropid, croptype, name, amount) FROM stdin;
1	Vegetable	Carrot	895
2	Vegetable	Corn	4300
3	Nut	Pistachio	1135
4	Nut	Almond	1159
5	Fruit	Strawberry	499
6	Fruit	Grape	1646
7	Grain	Wheat	921
8	Fruit	Tomato	1890
9	Vegetable	Spinach	502
10	Vegetable	Broccoli	1408
11	Vegetable	Lettuce	71
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY employees (employeeid, clientid, name, phone, employmentstatus, salary) FROM stdin;
1	1	Pringell	704-265-4575	Office Assistant I	112931
2	1	Toppin	684-718-2582	Software Consultant	50227
3	1	Durman	595-932-7972	Human Resources Manager	50392
4	1	Loker	378-884-7214	Analog Circuit Design Manager	60723
5	1	Dartnall	420-158-1899	Analyst Programmer	133337
6	1	Hurich	816-413-5218	VP Quality Control	131983
7	1	Logsdail	322-102-0217	Accounting Assistant I	74941
8	1	Gonin	242-318-8383	Safety Technician IV	155305
9	1	Friedank	812-722-6036	Mechanical Systems Engineer	57639
10	1	Wannell	283-276-9150	Structural Analysis Engineer	107481
11	2	Lattimore	858-974-7830	Teacher	135289
12	2	Knapper	742-617-3137	Desktop Support Technician	88140
13	3	Hallor	497-463-2914	Compensation Analyst	183641
14	4	Salery	731-734-6116	Systems Administrator II	157722
15	4	Anthoine	724-358-6102	Financial Analyst	73168
16	4	O'Crevan	622-412-4752	Physical Therapy Assistant	108541
17	4	Woolbrook	172-946-4606	Systems Administrator III	78837
18	4	Degoix	262-542-2006	Assistant Professor	127801
19	4	Adess	817-821-1441	Financial Advisor	150208
20	5	Redholls	927-810-9644	Developer IV	191720
21	5	Yates	299-149-2457	Accountaint I	156976
22	5	Broadley	270-623-4451	Staff Scientist	94392
23	5	Ianilli	361-387-0632	Senior Financial Analyst	182972
24	5	Ure	210-642-9989	Librarian	80075
25	6	Malitrott	209-620-2042	Junior Executive	150967
26	7	Yoseloff	962-909-0698	Automation Specialist III	177180
27	7	Arnholdt	301-273-3478	Budget/Accounting Analyst II	183687
28	8	Alps	901-607-7414	Statistician II	67379
29	9	Sprasen	630-233-9915	Quality Engineer	54432
30	10	Sylvester	114-704-9652	Health Coach IV	71401
31	12	Padmore	516-429-2190	Help Desk Operator	157715
32	12	Benes	157-725-4946	Software Consultant	143112
33	13	Bleacher	724-485-4650	General Manager	180491
34	13	Dury	895-551-2998	Speech Pathologist	55739
35	13	Hens	377-622-4216	Technical Writer	62109
36	13	Giraudot	160-535-0825	Editor	110210
37	14	Vedeniktov	171-506-2369	Clinical Specialist	197459
38	14	Bernhardi	197-320-2802	Assistant Media Planner	144271
39	14	MacCollom	525-414-5955	Librarian	149405
40	15	Grishankov	964-993-4720	Help Desk Operator	140741
41	15	Crookshanks	534-450-5432	Chief Design Engineer	117338
42	15	Dodgson	887-822-4162	Business Systems Development Analyst	92718
43	16	Maginot	160-693-3997	Accountaint IV	184829
44	17	Coneley	363-387-6456	Developer III	195040
45	18	Buff	905-166-1346	Accountant Assistant IV	185153
46	18	Jersh	732-947-1152	Teacher	108489
47	19	Burder	696-415-0811	Structural Analysis Engineer	121225
48	20	Jiruch	661-466-9039	VP Quality Control	170745
49	20	Blick	917-709-7538	Chemical Engineer	154451
50	13	Giacobazzi	877-991-9020	Chemical Engineer	97112
51	12	Headley	371-659-3495	Accountant I	51770
52	14	Stang-Gjertson	534-578-7994	Cost Accountaint	49026
53	17	Meriton	642-129-9755	Research Associate	132357
54	9	LeLouche	704-945-8756	Ruler of the World	999999
55	3	O'Currine	258-790-4222	Senior Sales Associate	62951
56	4	Have	179-865-7614	Senior Editor	49174
57	8	Tezure	975-700-6389	Structural Analysis Egnineer	45146
58	11	Iacolvo	361-135-7530	Web Developer II	49853
59	15	Zoomback	389-873-8030	Actuary	150710
60	6	Lakenden	162-259-6999	Engineer II	141294
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY equipment (equipmentnumber, equipmenttype, fuel, status, brand, fieldid) FROM stdin;
1	Town Car	Diesel	Good	BMW	1
2	Irigation System	Electric	Good	Pontiac	2
3	SUV	Petrol	Good	Mazda	3
4	Toyota Hilux	Diesel	Good	Toyota	4
5	DUKW Vehicle	Diesel	Good	GMC	6
6	Cow-Milker	Electric	Good	Pontiac	6
7	ATV	Diesel	Needs Repair	Mitsubishi	7
8	Das Gutenmahdrescher	Electric	Good	Volkswagen	7
9	M60A1 MBT	Diesel	Good	Chrysler	8
10	Lift	Electric	Good	Mazda	8
11	TV-8	Electric	Good	Chrysler	9
12	A ferrari? Why does a farm have a Ferrari?	Electric	Good	Ferrari	10
13	Cow Milker	Electric	Good	Pontiac	10
14	Leisure Vehicle	Electric	Good	Nissan	11
15	Combine Harvester	Diesel	Good	Toyota	12
16	Tractor	Petrol	Good	Volkswagen	13
17	Tractor	Petrol	Good	Mercury	15
18	Follow Truck	Diesel	Good	Chrysler	16
19	Combine Harvester	Diesel	Good	Scion	17
20	Transport Car	Electric	Good	Ford	18
\.


--
-- Data for Name: equipmentlog; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY equipmentlog (equipmentnumber, fieldid, status, entry_date) FROM stdin;
\.


--
-- Data for Name: field_info; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY field_info (fieldid, clientid, acreage, cropid) FROM stdin;
1	12	289	1
2	5	615	2
3	5	820	3
4	7	817	4
5	9	410	5
6	10	268	6
7	9	916	7
8	10	708	8
9	12	409	9
10	11	532	10
11	18	967	11
12	14	660	1
13	19	839	1
14	17	607	2
15	20	168	3
16	6	437	4
17	20	400	5
18	16	865	6
19	2	784	5
20	3	566	4
\.


--
-- Data for Name: incomingdeliveries; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY incomingdeliveries (in_deliveryid, clientid, stockid, stock_levels, deliverydate, supplier) FROM stdin;
\.


--
-- Name: incomingdeliveries_in_deliveryid_seq; Type: SEQUENCE SET; Schema: public; Owner: njackson
--

SELECT pg_catalog.setval('incomingdeliveries_in_deliveryid_seq', 1, false);


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY inventory (stockid, clientid, name, category, amount, priceperunit) FROM stdin;
1	1	Cut_grass	Feed	6546	0.10
2	2	Corn	Feed	7002	0.20
3	3	Hay	Feed	21330	0.20
4	4	Wheat	Feed	3445	0.70
5	5	Cereal_grains	Feed	4192	0.60
6	6	Corn	Product	4	0.50
7	7	Apricots	Product	100	0.75
8	8	Apples	Product	45	0.90
9	9	Bananas	Product	40	0.60
10	10	Cabbage	Product	35	0.50
\.


--
-- Data for Name: livestock; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY livestock (speciesid, clientid, species, food, feed_levels) FROM stdin;
1	7	Cow	Grasses	good
2	8	Pig	Corn	good
3	3	Chicken	Grains	good
4	5	Horse	Hay	good
5	7	Sheep	Grasses	low
\.


--
-- Data for Name: outgoingdeliveries; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY outgoingdeliveries (out_deliveryid, clientid, stockid, stockamount, deliverydate, recipient) FROM stdin;
\.


--
-- Name: outgoingdeliveries_out_deliveryid_seq; Type: SEQUENCE SET; Schema: public; Owner: njackson
--

SELECT pg_catalog.setval('outgoingdeliveries_out_deliveryid_seq', 1, false);


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: njackson
--

COPY transactions (id, clientid, transaction, transactionid, amount) FROM stdin;
\.


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: njackson
--

SELECT pg_catalog.setval('transactions_id_seq', 1, false);


--
-- Name: client_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY client
    ADD CONSTRAINT client_pkey PRIMARY KEY (clientid);


--
-- Name: crops_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY crops
    ADD CONSTRAINT crops_pkey PRIMARY KEY (cropid);


--
-- Name: employees_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employeeid);


--
-- Name: equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipmentnumber);


--
-- Name: equipmentlog_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY equipmentlog
    ADD CONSTRAINT equipmentlog_pkey PRIMARY KEY (equipmentnumber);


--
-- Name: field_info_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY field_info
    ADD CONSTRAINT field_info_pkey PRIMARY KEY (fieldid);


--
-- Name: incomingdeliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY incomingdeliveries
    ADD CONSTRAINT incomingdeliveries_pkey PRIMARY KEY (in_deliveryid);


--
-- Name: inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (stockid);


--
-- Name: livestock_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY livestock
    ADD CONSTRAINT livestock_pkey PRIMARY KEY (speciesid);


--
-- Name: outgoingdeliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY outgoingdeliveries
    ADD CONSTRAINT outgoingdeliveries_pkey PRIMARY KEY (out_deliveryid);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: njackson; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: delclients; Type: TRIGGER; Schema: public; Owner: njackson
--

CREATE TRIGGER delclients BEFORE DELETE ON client FOR EACH ROW EXECUTE PROCEDURE delclient();


--
-- Name: equiplog; Type: TRIGGER; Schema: public; Owner: njackson
--

CREATE TRIGGER equiplog AFTER UPDATE ON equipment FOR EACH ROW EXECUTE PROCEDURE equipmaintlog();


--
-- Name: updateinstead; Type: TRIGGER; Schema: public; Owner: njackson
--

CREATE TRIGGER updateinstead INSTEAD OF UPDATE ON inventory_log FOR EACH ROW EXECUTE PROCEDURE updateinstead();


--
-- Name: upincamt; Type: TRIGGER; Schema: public; Owner: njackson
--

CREATE TRIGGER upincamt AFTER INSERT ON incomingdeliveries FOR EACH ROW EXECUTE PROCEDURE upincamt();


--
-- Name: upinvamt; Type: TRIGGER; Schema: public; Owner: njackson
--

CREATE TRIGGER upinvamt AFTER INSERT ON outgoingdeliveries FOR EACH ROW EXECUTE PROCEDURE upinvamt();


--
-- Name: employees_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_clientid_fkey FOREIGN KEY (clientid) REFERENCES client(clientid);


--
-- Name: equipment_fieldid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY equipment
    ADD CONSTRAINT equipment_fieldid_fkey FOREIGN KEY (fieldid) REFERENCES field_info(fieldid);


--
-- Name: field_info_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY field_info
    ADD CONSTRAINT field_info_clientid_fkey FOREIGN KEY (clientid) REFERENCES client(clientid);


--
-- Name: field_info_cropid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY field_info
    ADD CONSTRAINT field_info_cropid_fkey FOREIGN KEY (cropid) REFERENCES crops(cropid);


--
-- Name: incomingdeliveries_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY incomingdeliveries
    ADD CONSTRAINT incomingdeliveries_clientid_fkey FOREIGN KEY (clientid) REFERENCES client(clientid);


--
-- Name: inventory_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_clientid_fkey FOREIGN KEY (clientid) REFERENCES client(clientid);


--
-- Name: livestock_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY livestock
    ADD CONSTRAINT livestock_clientid_fkey FOREIGN KEY (clientid) REFERENCES client(clientid);


--
-- Name: outgoingdeliveries_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY outgoingdeliveries
    ADD CONSTRAINT outgoingdeliveries_clientid_fkey FOREIGN KEY (clientid) REFERENCES client(clientid);


--
-- Name: transactions_clientid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: njackson
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_clientid_fkey FOREIGN KEY (clientid) REFERENCES client(clientid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

