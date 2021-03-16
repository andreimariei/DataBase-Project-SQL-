use DezmembrariAuto

drop procedure procedura1
create procedure procedura1 
as
begin
alter table Motor
alter column nume nvarchar(255)
print('Coloana nume este acum de tipul nvarchar')
end

create procedure procedura1_revers 
as
begin
alter table Motor
alter column nume varchar(255)
print('Coloana nume este acum de tipul varchar')
end

create procedure procedura2 as
begin
alter table Dezmembrare
add constraint df_nume
default 'Bunesti' for nume
print('Numele default a fost setat drept Bunesti')
end

create procedure procedura2_revers
as
begin
alter table Dezmembrare
drop constraint df_nume
print('Numele dezmembrarii nu mai are valoare default')
end

create procedure procedura3
as
begin
create table Lumini
(id_lumina int primary key,
id int foreign key references Masini(id_masina),
nume varchar(255)
)
print('Tabela lumini a fost creata')
end

create procedure procedura3_revers
as
begin
drop table Lumini
print('Tabela lumini a fost stearsa')
end

drop procedure procedura4
create procedure procedura4
as
begin
alter table Masini
add cod_motor varchar(255)
print('A fost adaugata coloana cod motor')
end

create procedure procedura4_revers
as
begin
alter table Masini
drop column cod_motor
print('A fost stearsa coloana cod motor')
end

drop procedure procedura5_revers
create procedure procedura5
as
begin
alter table Caroserie
drop constraint FK__Caroserie__id__5CD6CB2B
print('Constrangerea foreign key a id-ului a fost stearsa')
end

SELECT * 
FROM sys.foreign_keys
WHERE referenced_object_id = object_id('')

create procedure procedura5_revers
as
begin
alter table Caroserie
add constraint FK__Caroserie__id__5CD6CB2B foreign key(id) references Masini(id_masina)
print('Constrangerea foreign key a id-ului a fost adaugata')
end


exec procedura1
exec procedura1_revers
exec procedura2
exec procedura2_revers
exec procedura3
exec procedura3_revers
exec procedura4
exec procedura4_revers
exec procedura5
exec procedura5_revers

create table versiune
(
versiune_actuala INT DEFAULT 0
)

INSERT INTO versiune(versiune_actuala) VALUES(0)
delete from versiune where versiune_actuala=1


select versiune_actuala from versiune
update versiune set versiune_actuala=0
select versiune_actuala from versiune

drop procedure main

create procedure main
@versiuneFinala int
as
begin
if @versiuneFinala<0 or @versiuneFinala>5
	begin
		print('Nu se poate!');
	end
else
begin
if @versiuneFinala>=0 or @versiuneFinala<=5
	begin
	declare @versiuneActuala int
	select @versiuneActuala=versiune_actuala from versiune
	if(@versiuneActuala < @versiuneFinala)
		begin
			while(@versiuneActuala<@versiuneFinala)
			begin
				if(@versiuneActuala=0)
				 exec procedura1
				 if(@versiuneActuala=1)
				 exec procedura2
				 if(@versiuneActuala=2)
				 exec procedura3
				 if(@versiuneActuala=3)
				 exec procedura4
				 if(@versiuneActuala=4)
				 exec procedura5
				 update versiune set versiune_actuala=versiune_actuala+1
				 select @versiuneActuala = versiune_actuala from versiune
			end
		end
		if(@versiuneActuala>@versiuneFinala)
		begin
			while(@versiuneActuala>@versiuneFinala)
			begin
				if(@versiuneActuala=5)
				 exec procedura5_revers
				 if(@versiuneActuala=4)
				 exec procedura4_revers
				 if(@versiuneActuala=3)
				 exec procedura3_revers
				 if(@versiuneActuala=2)
				 exec procedura2_revers
				 if(@versiuneActuala=1)
				 exec procedura1_revers
				 update versiune set versiune_actuala=versiune_actuala-1
				 select @versiuneActuala = versiune_actuala from versiune
			end
		end
		print('Versiunea actuala:')
		select versiune_actuala from versiune
	end
end
end

exec main 1
select versiune_actuala from versiune
