create view dbo.test2
with schemabinding
as
select [MemberNo], lastname
from dbo.test
