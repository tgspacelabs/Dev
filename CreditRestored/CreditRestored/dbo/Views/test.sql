create view dbo.test
with schemabinding
as select [MemberNo], lastname, firstname
from dbo.[Member]
