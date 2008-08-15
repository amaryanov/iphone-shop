CREATE TABLE IF NOT EXISTS Category (id 			integer primary key autoincrement,
									type 		integer default 0,
									name 		text not null,
									imageURL 	text);
CREATE TABLE IF NOT EXISTS ChildCategories (
									id					integer primary key autoincrement,
									parentCategoryId	integer,
									categoryId			integer);
CREATE TABLE IF NOT EXISTS Product (
								id 			integer primary key autoincrement,
								name 		text not null,
								imageURL 	text,
								categoryId	integer);

CREATE TABLE IF NOT EXISTS DetailedProduct(
											id 				integer primary key autoincrement,
											productId		integer unique,
											reviewURL		text,
											amazonURL		text);
CREATE TABLE IF NOT EXISTS ProductOffer(
									id 				integer primary key autoincrement,
									model 			text,
									details 		text,
									maunufacturer 	text,
									currency 		text,
									shipmentCost 	real,
									productURL		text,
									price			real);

CREATE TABLE IF NOT EXISTS OffersList (
									id 					integer primary key autoincrement,
									productId			int,
									productOfferId		int);

CREATE TABLE IF NOT EXISTS BusinessCard(
									id integer primary key autoincrement,
									categoryId integer unique,
									name text not null,
									imageURL text,
									vipLevel integer default 1);

CREATE TABLE IF NOT EXISTS DetailedBusinessCard(
									id				integer primary key autoincrement,
									businessCardId	integer unique,
									name			text not null,
									imageURL		text,
									addressId		integer,
									contactInfoId	integer);


INSERT INTO Category (id,name,imageURL)VALUES(1,"Electronics","");
	INSERT INTO Category (id,name,imageURL)VALUES(2,"Computers","");
		INSERT INTO Category (id,name,imageURL)VALUES(3,"Laptops","");
			INSERT INTO Category (id,name,imageURL)VALUES(4,"Vendors","");
				INSERT INTO Category (id,name,imageURL)VALUES(5,"Apple","");
					INSERT INTO Category (id,name,imageURL)VALUES(6,"MacAir","");
					INSERT INTO Category (id,name,imageURL)VALUES(7,"MacBook","");
				INSERT INTO Category (id,name,imageURL)VALUES(8,"IBM","");
				INSERT INTO Category (id,name,imageURL)VALUES(9,"Sony","");
				INSERT INTO Category (id,name,imageURL)VALUES(10,"Samsyng","");
				INSERT INTO Category (id,name,imageURL)VALUES(11,"HP","");
				INSERT INTO Category (id,name,imageURL)VALUES(12,"Accus","");
				INSERT INTO Category (id,name,imageURL)VALUES(13,"Asser","");
		INSERT INTO Category (id,name,imageURL)VALUES(14,"Desctops","");
			INSERT INTO Category (id,name,imageURL)VALUES(15,"Apple","");
			INSERT INTO Category (id,name,imageURL)VALUES(16,"IBM","");
			INSERT INTO Category (id,name,imageURL)VALUES(17,"Sony","");
			INSERT INTO Category (id,name,imageURL)VALUES(18,"Samsyng","");
			INSERT INTO Category (id,name,imageURL)VALUES(19,"HP","");
			INSERT INTO Category (id,name,imageURL)VALUES(20,"Accus","");
			INSERT INTO Category (id,name,imageURL)VALUES(21,"Asser","");
		INSERT INTO Category (id,name,imageURL)VALUES(22,"Servers","");
			INSERT INTO Category (id,name,imageURL)VALUES(23,"Apple","");
			INSERT INTO Category (id,name,imageURL)VALUES(24,"IBM","");
			INSERT INTO Category (id,name,imageURL)VALUES(25,"Sony","");
			INSERT INTO Category (id,name,imageURL)VALUES(26,"Samsyng","");
			INSERT INTO Category (id,name,imageURL)VALUES(27,"HP","");
			INSERT INTO Category (id,name,imageURL)VALUES(28,"Accus","");
			INSERT INTO Category (id,name,imageURL)VALUES(29,"Asser","");

	INSERT INTO Category (id,name,imageURL)VALUES(30,"Gadgets","");
		INSERT INTO Category (id,name,imageURL)VALUES(31,"Players","");
			INSERT INTO Category (id,name,imageURL)VALUES(32,"ApplePl","");
			INSERT INTO Category (id,name,imageURL)VALUES(33,"IBMPl","");
			INSERT INTO Category (id,name,imageURL)VALUES(34,"SonyPl","");
			INSERT INTO Category (id,name,imageURL)VALUES(35,"SamsyngPl","");
			INSERT INTO Category (id,name,imageURL)VALUES(36,"HPPl","");
			INSERT INTO Category (id,name,imageURL)VALUES(37,"AccusPl","");
			INSERT INTO Category (id,name,imageURL)VALUES(38,"AsserPl","");
		INSERT INTO Category (id,name,imageURL)VALUES(39,"HeadPhones","");
	INSERT INTO Category (id,name,imageURL)VALUES(40,"Phones","");
		INSERT INTO Category (id,name,imageURL)VALUES(41,"Samsung","");
		INSERT INTO Category (id,name,imageURL)VALUES(42,"iPhone","");
		INSERT INTO Category (id,name,imageURL)VALUES(43,"Nokia","");
		INSERT INTO Category (id,name,imageURL)VALUES(44,"Other","");
		
INSERT INTO Category (id,name,imageURL)VALUES(45,"Motor","");
	INSERT INTO Category (id,name,imageURL)VALUES(46,"Cars","");
		INSERT INTO Category (id,name,imageURL)VALUES(47,"CarType1","");
		INSERT INTO Category (id,name,imageURL)VALUES(48,"CarType2","");
		INSERT INTO Category (id,name,imageURL)VALUES(49,"CarType3","");
		INSERT INTO Category (id,name,imageURL)VALUES(50,"CarType4","");

INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(-1,1);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(1,2);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(2,3);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(3,4);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(4,5);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(5,6);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(5,7);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(4,8);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(4,9);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(4,10);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(4,11);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(4,12);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(4,13);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(2,14);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(14,15);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(14,16);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(14,17);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(14,18);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(14,19);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(14,20);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(14,21);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(2,22);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(22,23);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(22,24);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(22,25);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(22,26);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(22,27);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(22,28);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(22,29);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(1,30);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(30,31);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(31,32);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(31,33);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(31,34);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(31,35);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(31,36);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(31,37);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(31,38);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(30,39);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(1,40);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(40,41);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(40,42);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(40,43);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(40,44);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(-1,45);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(45,46);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(46,47);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(46,48);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(46,49);
INSERT INTO ChildCategories (parentCategoryId, categoryId) VALUES(46,50);

INSERT INTO Product (id,name,categoryId) VALUES (1,"MacAir laptop",6);
INSERT INTO Product (id,name,categoryId) VALUES (2,"MacBook laptom",7);
INSERT INTO Product (id,name,categoryId) VALUES (3,"IBM laptop",8);
INSERT INTO Product (id,name,categoryId) VALUES (4,"IBM laptop1",8);
INSERT INTO Product (id,name,categoryId) VALUES (5,"IBM laptop2",8);
INSERT INTO Product (id,name,categoryId) VALUES (6,"Sony laptop1",9);
INSERT INTO Product (id,name,categoryId) VALUES (7,"Sony laptop2",9);
INSERT INTO Product (id,name,categoryId) VALUES (8,"Sony laptop3",9);
INSERT INTO Product (id,name,categoryId) VALUES (9,"Sony laptop4",9);
INSERT INTO Product (id,name,categoryId) VALUES (10,"Sony laptop5",9);
INSERT INTO Product (id,name,categoryId) VALUES (11,"Samsyng laptop1",10);
INSERT INTO Product (id,name,categoryId) VALUES (12,"Samsyng laptop2",10);
INSERT INTO Product (id,name,categoryId) VALUES (13,"Samsyng laptop3",10);
INSERT INTO Product (id,name,categoryId) VALUES (14,"Samsyng laptop4",10);
INSERT INTO Product (id,name,categoryId) VALUES (15,"Samsyng laptop5",10);
INSERT INTO Product (id,name,categoryId) VALUES (16,"Samsyng laptop6",10);
INSERT INTO Product (id,name,categoryId) VALUES (17,"HP laptop1",11);
INSERT INTO Product (id,name,categoryId) VALUES (18,"HP laptop2",11);
INSERT INTO Product (id,name,categoryId) VALUES (19,"HP laptop3",11);
INSERT INTO Product (id,name,categoryId) VALUES (20,"HP laptop4",11);
INSERT INTO Product (id,name,categoryId) VALUES (21,"HP laptop5",11);
INSERT INTO Product (id,name,categoryId) VALUES (22,"Accus laptop1",12);
INSERT INTO Product (id,name,categoryId) VALUES (23,"Accus laptop2",12);
INSERT INTO Product (id,name,categoryId) VALUES (24,"Accus laptop3",12);
INSERT INTO Product (id,name,categoryId) VALUES (25,"Accus laptop4",12);
INSERT INTO Product (id,name,categoryId) VALUES (26,"Accus laptop5",12);
INSERT INTO Product (id,name,categoryId) VALUES (27,"Accus laptop6",12);
INSERT INTO Product (id,name,categoryId) VALUES (28,"Asser laptop1",13);
INSERT INTO Product (id,name,categoryId) VALUES (29,"Asser laptop2",13);
INSERT INTO Product (id,name,categoryId) VALUES (30,"Asser laptop3",13);
INSERT INTO Product (id,name,categoryId) VALUES (31,"Asser laptop4",13);
INSERT INTO Product (id,name,categoryId) VALUES (32,"Asser laptop5",13);
INSERT INTO Product (id,name,categoryId) VALUES (33,"Asser laptop6",13);

INSERT INTO DetailedProduct(id,productId) VALUES (1,1);
INSERT INTO DetailedProduct(id,productId) VALUES (2,2);
INSERT INTO DetailedProduct(id,productId) VALUES (3,3);
INSERT INTO DetailedProduct(id,productId) VALUES (4,4);
INSERT INTO DetailedProduct(id,productId) VALUES (5,5);
INSERT INTO DetailedProduct(id,productId) VALUES (6,6);
INSERT INTO DetailedProduct(id,productId) VALUES (7,7);
INSERT INTO DetailedProduct(id,productId) VALUES (8,8);
INSERT INTO DetailedProduct(id,productId) VALUES (9,9);
INSERT INTO DetailedProduct(id,productId) VALUES (10,10);

INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (1,"Model1","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (2,"Model2","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (3,"Model3","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (4,"Model4","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (5,"Model5","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (6,"Model6","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (7,"Model7","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (8,"Model8","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (9,"Model9","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (10,"Model10","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (11,"Model11","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (12,"Model12","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (13,"Model13","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (14,"Model14","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (15,"Model15","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (16,"Model16","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (17,"Model17","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (18,"Model18","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (19,"Model19","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (20,"Model20","About product","vendor","Currency",99.0,199.0);
INSERT INTO ProductOffer(id,model,details,maunufacturer,currency,shipmentCost,price) VALUES (21,"Model21","About product","vendor","Currency",99.0,199.0);

INSERT INTO OffersList (id,productId,productOfferId) VALUES(1,1,1);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(2,1,2);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(3,1,3);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(4,1,4);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(5,1,5);

INSERT INTO OffersList (id,productId,productOfferId) VALUES(6,2,6);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(7,2,5);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(8,2,7);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(9,2,8);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(10,2,8);

INSERT INTO OffersList (id,productId,productOfferId) VALUES(11,3,9);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(12,3,10);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(13,3,11);

INSERT INTO OffersList (id,productId,productOfferId) VALUES(14,4,12);

INSERT INTO OffersList (id,productId,productOfferId) VALUES(15,5,20);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(16,6,21);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(17,7,11);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(18,8,12);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(19,9,13);
INSERT INTO OffersList (id,productId,productOfferId) VALUES(20,10,14);

