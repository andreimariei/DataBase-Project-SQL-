
insert into Tables values ('Dezmembrare')
insert into Tables values ('Masini')
insert into Tables values ('Iduri')

select * from Tables

insert into Views values ('View_1')
insert into Views values ('View_2')
insert into Views values ('View_3')

select * from Views

insert into Tests values ('delete_table')
insert into Tests values ('insert_table')
insert into Tests values ('select_view')

select * from Tests

insert into TestViews(TestID, ViewID) values (3, 1)
insert into TestViews(TestID, ViewID) values (3, 2)
insert into TestViews(TestID, ViewID) values (3, 3)

--Stergere
insert into TestTables(TestID, TableID, NoOfRows, Position) values (1, 3, 200, 1)
insert into TestTables(TestID, TableID, NoOfRows, Position) values (1, 2, 200, 2)
insert into TestTables(TestID, TableID, NoOfRows, Position) values (1, 1, 200, 3)

--Inserare
insert into TestTables(TestID, TableID, NoOfRows, Position) values (2, 1, 200, 1)
insert into TestTables(TestID, TableID, NoOfRows, Position) values (2, 2, 200, 2)
insert into TestTables(TestID, TableID, NoOfRows, Position) values (2, 3, 200, 3)


CREATE PROCEDURE insertInto_Dezmembrare
	@NoOfRows int
AS
BEGIN
	declare @contor int
	DECLARE @t VARCHAR(30)
	set @contor = 1
	while (@NoOfRows >= @contor)
	begin
		set @t = 'Nume' + CONVERT (VARCHAR(5), @contor)
		insert into Dezmembrare(id,nume) values (@contor,@t)
		set @contor=@contor+1
	end
END

SELECT * FROM Dezmembrare

drop procedure insertInto_Dezmembrare

CREATE PROCEDURE deleteFrom_Dezmembrare
AS
BEGIN
	delete from Dezmembrare
END

delete from Angajati
exec insertInto_Dezmembrare 10
select * from Dezmembrare
exec deleteFrom_Dezmembrare



CREATE or alter PROCEDURE insertInto_Masini
	@NoOfRows int
AS
BEGIN
	declare @contor int
	DECLARE @marca varchar(50)
	DECLARE @model varchar(50)
	DECLARE @combustibil varchar(50)
	DECLARE @id int
	set @contor = 1
	set @combustibil='Diesel'

	while (@NoOfRows >= @contor)
	begin
		set @marca = 'Marca' + CONVERT (VARCHAR(5), @contor)
		set @model = 'Model' + CONVERT (VARCHAR(5), @contor)
		select @id = min(id) from Dezmembrare 
		insert into Masini(id_masina,id,marca,model,combustibil) values
		(@contor, @id, @marca, @model,@combustibil)
		set @contor=@contor+1
	end
END

CREATE PROCEDURE deleteFrom_Masini
AS
BEGIN
	delete from Masini
END



CREATE PROCEDURE insertInto_Iduri
	@NoOfRows int
AS
BEGIN
	declare @contor int
	declare @idVanzare int
	declare @idClient int
	declare @nume varchar(50)
	set @contor = 1
	select count(*) from Vanzari
		if( @@ROWCOUNT =0 )
			insert into Vanzari(id_vanzare) values (@contor )
	select count(id_client) from Clienti
		if(	@@ROWCOUNT =0 )
			insert into Clienti(id_client) values (@contor )
	while (@NoOfRows >= @contor)
	begin	
		select count(*) from Vanzari
		if( @@ROWCOUNT < @contor )
			insert into Vanzari(id_vanzare) values (@contor )
		select count(id_client) from Clienti
		if(	@@ROWCOUNT < @contor )
			insert into Clienti(id_client) values (@contor )
		set @idVanzare=	(select max(id_vanzare) from Vanzari)
		set @idClient=	(select max(id_client) from Clienti)
		insert into Iduri(id_client, id_vanzare) values 
		(@idClient,@idVanzare )
		set @contor=@contor+1

	end
END
drop procedure insertInto_Iduri
select * from Vanzari
exec insert_table 3,2
CREATE PROCEDURE deleteFrom_Iduri
AS
BEGIN
	delete from Iduri
END



CREATE PROCEDURE delete_table
	@Position int
AS
BEGIN
	if (@Position = 1) --position 1 inseamna stergerea din tabelul Iduri
	begin
		exec deleteFrom_Iduri
		print('Am sters din tabelul Iduri.')
	end

	if (@Position = 2) --position 2 inseamna stergerea din tabelul Dezmembrare.
	begin
		exec deleteFrom_Iduri
		exec deleteFrom_Masini
		print('Am sters din tabelul Masini.')
	end

	if (@Position = 3) --position 3 inseamna stergerea din tabelul Masini.
	begin
		exec deleteFrom_Iduri
		exec deleteFrom_Masini
		exec deleteFrom_Dezmembrare
		print('Am sters din tabelul Dezmembrare.')
	end
END
drop procedure delete_table
CREATE PROCEDURE insert_table
	@Position int,
	@NoOfRows int
AS
BEGIN
	if (@Position = 1)
	begin
		exec insertInto_Dezmembrare @NoOfRows
	end

	if (@Position = 2)
	begin
		exec insertInto_Masini @NoOfRows
	end

	if (@Position = 3)
	begin
		exec insertInto_Iduri @NoOfRows
	end
END


--Procedura care executa stergerea+inserarea in tabele pentru un id de tabel dat ca parametru
create procedure testTable
	@TableIDTest int
as
begin
	declare @NoOfRowsInsert int
	declare @PositionDelete int
	declare @PositionInsert int

	select @PositionDelete = TestTables.Position from
	TestTables where TestTables.TestID = 1 and TestTables.TableID = @TableIDTest

	select @PositionInsert = TestTables.Position, @NoOfRowsInsert = TestTables.NoOfRows from
	TestTables where TestTables.TestID = 2 and TestTables.TableID = @TableIDTest
	
	exec delete_table @PositionDelete
	exec insert_table @PositionInsert, @NoOfRowsInsert
end

select * from TestTables

CREATE PROCEDURE mainFunction
	@Descriere varchar(50)
AS
BEGIN
	declare @TestRunID_Var int
	declare @startTime datetime
	declare @endTime datetime

	declare @end1Start2 datetime
	declare @end2Start3 datetime
	declare @end3Startv1 datetime
	declare @endv1Startv2 datetime
	declare @endv2Startv3 datetime

	set @startTime = GETDATE()
	insert into TestRuns(Description, StartAt, EndAt) values
	(@Descriere, @startTime, GETDATE())
	
	select @TestRunID_Var=TestRuns.TestRunID from TestRuns where TestRuns.StartAt = @startTime
	
	--Testele pt fiecare tabel
	exec testTable 1
	set @end1Start2 = GETDATE()
	insert into TestRunTables(TestRunID, TableID, StartAt, EndAt) values
	(@TestRunID_Var, 1, @startTime, @end1Start2)

	exec testTable 2
	set @end2Start3 = GETDATE()
	insert into TestRunTables(TestRunID, TableID, StartAt, EndAt) values
	(@TestRunID_Var, 2, @end1Start2, @end2Start3)

	exec testTable 3
	set @end3Startv1 = GETDATE()
	insert into TestRunTables(TestRunID, TableID, StartAt, EndAt) values
	(@TestRunID_Var, 3, @end2Start3, @end3Startv1)

	--Test views

	select * from View_1
	set @endv1Startv2 = GETDATE()
	insert into TestRunViews(TestRunID, ViewID, StartAt, EndAt) values
	(@TestRunID_Var, 1, @end3Startv1, @endv1Startv2)

	select * from View_2
	set @endv2Startv3 = GETDATE()
	insert into TestRunViews(TestRunID, ViewID, StartAt, EndAt) values
	(@TestRunID_Var, 2, @endv1Startv2, @endv2Startv3)

	select * from View_3
	set @endTime = GETDATE()
	insert into TestRunViews(TestRunID, ViewID, StartAt, EndAt) values
	(@TestRunID_Var, 3, @endv2Startv3, @endTime)

	update TestRuns
	set EndAt = @endTime
	where StartAt = @startTime
END


exec mainFunction 'test cu 200'


select * from TestRunTables
select * from TestRunViews
select * from TestRuns

delete from TestRunTables
delete from TestRunViews
delete from TestRuns

select * from Dezmembrare
select * from Vanzari
select * from Clienti
select * from Iduri
delete from Dezmembrare
delete from Masini
delete from Iduri

delete from Iduri
delete from Clienti
delete from Vanzari


exec delete_table 1
exec insert_table 3, 10