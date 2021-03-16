use DezmembrariAuto

create or alter function test_nume(@name varchar(50))
returns bit
as
begin
	declare @flag bit
	if @name like '[A-Z]%' set @flag=1;
	else set @flag=0;
	return @flag
end



create or alter procedure CRUD_Clienti
	@table_name varchar(50),
	@nume varchar(50)
as
begin
set nocount on;
	if (dbo.test_nume(@nume)=1)
	begin
	declare @id int
	set @id=(select max(id) from Dezmembrare)
		--Create--
			insert into Clienti(id,nume) values(@id,@nume)
		--Read--
		select * from Clienti

		--Update--

		update Clienti set nume='Gheorghe' where nume like 'G%'

		--Delete--

		delete from Clienti where nume='Gheorghe'

		print 'Operatii efectuate pentru tabela' + @table_name
	end
	else
	begin
		print 'Eroare'
		return
	end
end

delete from Clienti

drop procedure CRUD_Clienti

exec CRUD_Clienti 'Clienti','Gica'

create or alter procedure CRUD_Angajati
	@table_name varchar(50),
	@nume varchar(50)
as
begin
set nocount on;
	--Create--
	if (dbo.test_nume(@nume)=1)
	begin
	declare @id int
	set @id=(select max(id) from Dezmembrare)
		insert into Angajati(id,nume) values(@id,@nume)

	--Read--
	select * from Angajati

	--Update--

	update Angajati set nume='Andrei' where nume like 'G%'

	--Delete--

	delete from Angajati where nume='Andrei'

	print 'Operatii efectuate pentru tabela' + @table_name
	end
	else
	begin
		print 'Eroare'
		return
	end
end
delete from Angajati
drop procedure CRUD_Angajati

exec CRUD_Angajati 'Angajati','Mihai'

create procedure CRUD_Vanzare
	@table_name varchar(50),
	@categorie varchar(50),
	@idpiesa int
as
begin
declare @idAngajat int
declare	@idClient int
set nocount on;
	--Create--
	if (dbo.test_nume(@categorie)=1)
	begin
		set @idClient=(select max(id_client) from Clienti)
		set @idAngajat=(select max(id_angajat) from Angajati)
		insert into Vanzari(id_angajat,id_client,id_piesa,categorie_piesa) values(@idAngajat,@idClient,@idpiesa,@categorie)

	--Read--
	select * from Vanzari

	--Update--

	update Vanzari set categorie_piesa='Caroserie' where id_piesa like '5%'

	--Delete--

	delete from Vanzari where categorie_piesa='Caroserie'

	print 'Operatii efectuate pentru tabela' + @table_name
	end
	else
	begin
		print 'Eroare'
		return
	end
end

drop procedure CRUD_Vanzare

exec CRUD_Vanzare 'Vanzari','Motor',5
