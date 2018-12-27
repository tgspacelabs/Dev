using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestUsp_GetPatientInformation
{
    static class Program
    {
        static void Main()
        {
            //var patientInfosFromDb = QueryPatientInformation
            //(
            //    from deviceEntry in patientInfosReference
            //    where Devices.ContainsKey(deviceEntry.Key) && deviceEntry.Value.ContainsKey(mrnIdKey) && !string.IsNullOrWhiteSpace(deviceEntry.Value[mrnIdKey])
            //    select Tuple.Create(deviceEntry.Key, deviceEntry.Value[mrnIdKey])
            //);

            Console.WriteLine("STARTING...");

            for (int x = 0; x < 10; x++)
            {
                QueryPatientInformation();
            }

            Console.WriteLine("DONE!");

            Console.ReadLine();
        }

        //private IEnumerable<Tuple<Guid, Dictionary<string, string>>> QueryPatientInformation(IEnumerable<Tuple<Guid, string>> deviceIds)
        static void QueryPatientInformation()
        {
            //if (!Enumerable.Any(deviceIds))
            //    yield break;

            //const string ConnectionString = "Server=PER730XD;Database=portal;Trusted_Connection=True;Application Name=TestUsp_GetPatientInformation;";
            //const string ConnectionString = "Data Source=localhost;Initial Catalog=portal;User ID=portal;Password=Sl_service;Application Name=DataLoader"
            const string ConnectionString = "Data Source=PER730XD;Initial Catalog=portal;User ID=portal;Password=Portal_1;Application Name=TestUsp_GetPatientInformation";
            SqlDataReader sqlDataReader;
            DataTable dt = new DataTable("GetPatientInformation");
            dt.Columns.Add("DeviceID");
            dt.Columns.Add("ID1");
            dt.Columns.Add("ID2");
            dt.Columns.Add("FirstName");
            dt.Columns.Add("MiddleName");
            dt.Columns.Add("LastName");

            var strQuery =
@"DECLARE @deviceIds [dbo].[GetPatientUpdateInformationType];

INSERT  INTO @deviceIds
        ([DeviceId], [PatientSessionId], [ID1])
VALUES
        ('22f1045a-0e38-5338-ef50-ea7b12464c9c', '65571cd1-0ca9-4cf8-aedc-99acda986559', N'DL03_6YN91XNMSA'),
        ('ab5de664-4bd2-2f04-89e7-395281a6bb47', 'a4701434-d483-4473-9c5e-e36b87cf1158', N'DL03_MGBFPAW2XW'),
        ('42c40247-f5ba-e953-4ec2-af8a64a39cba', '35189428-a530-4e2e-90c6-f31a0dd9ae05', N'DL03_45F67MPD53'),
        ('ea2a4fb6-edd6-f2ad-c7e7-393aa8b70119', 'ed3d4547-0722-4483-8b31-5d861e758901', N'DL03_S7XNGX39MS'),
        ('2bdca792-7116-f736-2e54-f4d282f00ddc', '13d4eac8-6e85-468c-af18-c62ccacc00c7', N'DL03_2HWFMXDST3'),
        ('868f894c-803b-3536-6e51-089c00fcd498', '09306a3b-20c6-4776-98ef-bb42b1ed6fb8', N'DL03_K3RVHYFTFE'),
        ('f1076fe7-b4b3-265e-f618-0f9c0e8fe493', '7823b84f-5d5f-4dc0-8149-396bb3e460f3', N'DL03_CBRM9J25AC'),
        ('4dc01076-7b93-adae-eb8d-421a81c23e47', 'bd74b9f7-8c94-432d-9df4-b6593438e2b8', N'DL03_34EPA8694D'),
        ('fd2dac44-38a0-fd37-5e9a-997fe5e4bccb', 'fc0e4ee0-17e3-4daf-8ab9-0d4a211e54b8', N'DL03_JR5FFNL1LY'),
        ('4341a3e1-24ea-3dd5-1123-275cc604369d', '7a70403f-49cf-4e45-b201-dfcf13b3e632', N'DL03_CP7969WJS0'),
        ('e877e6ff-3283-a48a-5558-99bf680214b2', 'aab21e80-bc5b-4118-8851-63b331c16d4e', N'DL03_JV1NKAL4V9'),
        ('aa7c5a55-7788-c639-7ccd-8e2e97cb4ae8', '8193a7b9-a067-47ed-a5fa-e25574e89c1d', N'DL03_7QDS0V0AXY'),
        ('c33c2d20-b494-108c-7db8-c41ec1a7a8d4', '52b257fc-58b7-4bf1-ba41-59851c897d83', N'DL03_7EBP6B8N4V'),
        ('75764b6f-8c87-8e2e-274e-d02b22f5e479', '870bab06-8916-4088-9819-ffb049af190d', N'DL03_DGCXJWCNKD'),
        ('b0c93ce8-817c-c00a-31e7-cdff7c665a0f', '576c12b3-ca6e-4328-ae84-1b9d04bc614e', N'DL03_S5LPL6X2QY'),
        ('e3fb8719-e281-a1c5-fc0c-bd39fed3c535', 'c6ccd4c1-e0e0-4119-8429-c813e83157fa', N'DL03_5KQ9GG62MY'),
        ('2c7b7f95-c457-da70-5084-34e731703674', 'ca594bf5-3e64-4bc3-b118-e8681f38f8c9', N'DL01_KTS2C28JE6'),
        ('0dedc0dc-e2be-1b80-54fe-3b3c8ad76945', '83325000-1f2f-4bd4-8a7f-cbbbb021c236', N'DL03_95RHBARG45'),
        ('c2249048-44e8-59f4-d43c-2eeac7f3e5b5', '8cc98d2a-a04a-4377-8865-d9eb80788b4f', N'DL03_AD5M71HX12'),
        ('fe3d91ed-425e-dc77-233e-0cb9018987d3', '5886c8c1-d6fe-40f2-9e1c-9d0a550d622d', N'DL03_M06C8Y4H2S'),
        ('e5a9e01d-6cf2-51dc-c0f7-da5b5bb7b011', 'fb4451f2-7863-4e04-8a3c-be89e4048e32', N'DL03_5HEF1DAS24'),
        ('2015952c-b623-91d1-b9fe-96404f36c955', '0aa4a6a4-98d1-469a-b259-8cdf74e5316e', N'DL03_F0H726TY58'),
        ('795ff826-acb3-ea9e-5fcf-5e3c30be1a7a', 'aab77ffa-fa1e-43f0-a90e-a2468ec80e42', N'DL03_E08FXKASK5'),
        ('afebfabe-5118-85fc-d26e-00822bbc5af1', '043dcc08-47c7-49ed-95ee-de331cdc7bcd', N'DL03_CGPJNGR7PP'),
        ('4078c3c9-ec6b-09ae-0130-e497b8d809c5', 'adc84b79-514c-44de-9a10-f5d43fe5a208', N'DL03_0G3FN40MH4'),
        ('a004c691-b533-e694-863c-8bd86adedc31', '7c52313f-53ce-44d3-abb7-ffd6931eb943', N'DL03_96AVXP7SNE'),
        ('794de0c5-bee9-b0f2-6017-e1ae890fa3e3', 'e53d19eb-ba7a-4a22-9683-ee84b0a222e7', N'DL03_GWRXJSJVJ5'),
        ('41295046-33a2-0986-0ce2-b6068c06df89', 'e4504d45-51a8-445e-9023-b8a9b0a2cc54', N'DL01_CQTRY7950G'),
        ('7f5c5099-e780-3782-848b-38ab1a0b81c1', 'de631962-00eb-4042-811e-f4aeb63c6841', N'DL03_B2MB1D7A2L'),
        ('dde81011-410b-bf7b-58d1-c5c638b6ba8a', '83a369d3-0cae-49b3-82c0-b546eb8dc42a', N'DL03_SQPDAFG7NH'),
        ('023372fe-7094-ce09-7ef7-21f7ad1e293e', 'b953fe18-658e-401d-987a-970167fa6873', N'DL03_0PR3CET2RN'),
        ('18b46a66-463d-04c0-4aac-8dcdc65be939', '7f2216e6-003c-41b0-8d47-329ed6975687', N'DL03_4VE61H27YL'),
        ('4019e1b2-1a46-c151-bfa3-29a9e687d09f', '5c1120ef-b79f-4cee-b592-40a320e8d987', N'DL03_4MG6YR1QL9'),
        ('32506385-cdf7-00ba-4d40-ee658fced5bf', '3dfede05-b43f-4a87-bd37-d1fd0f721f1a', N'DL03_98GNCDVMWG'),
        ('3d2866bf-eaf9-8d10-f1c3-b4a8153403d7', 'cbcfffa5-4691-40f8-b5d0-b193332d2bb6', N'DL03_ELY32YRJWP'),
        ('e6b968fd-de83-69d8-8694-ce5f44165041', '6233b0cc-a5de-4530-99dc-ea5383cdd495', N'DL03_QC3XBPT8N7'),
        ('b13727a6-2bf7-f851-4f03-beb574d248a9', '265f67b2-df6f-42b5-a145-da368ca96aec', N'DL03_1B6VTYQC2E'),
        ('e8e034bb-200c-0c5f-8ec3-e2cf8caa32a7', 'b5dd6e93-1df5-4c46-ae26-e6d97cbb165c', N'DL03_YHSQJFL5TF'),
        ('270a4f49-5449-3e02-d16d-f8d04968f573', 'db6ac1a4-2b8a-4359-879c-dab7b50cc127', N'DL03_82JP03K6FA'),
        ('ce413d69-0d48-eb70-64f0-be780808ddbc', 'e05472db-9c0f-4728-918e-403be245431a', N'DL03_TB551B6RXY'),
        ('98cd28e4-6498-9c2c-067b-2fd5b09a6f21', '8ff2e47d-4fe7-4d86-86b4-7080e2ccb8f6', N'DL03_921P2GSNMN'),
        ('d5ea3bf7-be4a-b67c-d6aa-99db08c75976', 'baf26980-b716-49f9-b9fc-ad07cab39be3', N'DL03_9DDQ3ETTV6'),
        ('68e1590f-e182-e9bf-e194-a0117ab45ca4', '44a85bb6-b102-418b-86d9-bcd40da74a10', N'DL03_WYAJBTK09E'),
        ('5175b34d-debc-70d5-f18e-17052d427c4a', '6b4b6676-674f-4e2b-bd63-33f271ee5664', N'DL03_FCJ5LRH0FS'),
        ('cfbc892b-8c53-3882-41d5-2ebc55108b61', '84863f5d-a0fa-4dba-b62b-01028eecfa5b', N'DL03_1TB4YDYFKV'),
        ('6d548a86-87e2-6654-2910-a8558c50e988', '86f8a4b0-30ff-4209-98e6-99995f2a72df', N'DL03_Q8MBTVL2CX'),
        ('f0a014b0-b07c-5f1e-810a-5fb0460dc922', 'f8090770-927c-40bb-8984-48ab20d2644a', N'DL03_38Q89H6MB0'),
        ('78717474-9cf6-9c4a-037e-27fe46bfb362', 'a7e5dcb2-0598-414e-9bd8-7d917f109d33', N'DL03_QQVJWS46FA'),
        ('2a47628a-4e4e-ed18-7a6b-6d8663a59783', '0af79113-c809-4deb-977b-a68003b77a24', N'DL01_9LVQ7X5YSE'),
        ('d812570a-d4f0-a161-5907-2996aa2effc3', 'a27b8b75-3b89-4ddc-89e2-23fe56694476', N'DL03_7R7EAAMC5B'),
        ('7f0db772-50fb-f70b-45a2-7d2353f4f3f9', '156a273c-4446-4f1b-a96b-f7402147df8b', N'DL03_BQXKHWNHVH'),
        ('f375971c-216f-786b-b476-0c2fe5805742', 'ef024763-80bb-4129-af98-9555d7558e3a', N'DL03_QSSKK8G5NT'),
        ('2e9d2efd-fd82-d5d6-0001-3782598826ff', 'f85b6c26-7a46-4353-be2a-bd8e88a2a5a6', N'DL03_Q9531Y7F76'),
        ('131e9ddf-e9c5-6d44-dc0a-655d4f309e57', '95db9d9a-4846-4165-9b91-1a4a891bbbac', N'CLAYTON670'),
        ('e3f1e6c4-3267-f1de-8506-75849ca9524f', 'b6e01ce5-aeb3-411f-ae65-7b5565d5c5cd', N'DL03_D8JT2WXWMB'),
        ('e77a2f50-a161-8c27-1329-25acc008b07d', 'e2e0891e-e564-4178-9b96-8af2ca3b29be', N'DL03_YR1QAM7LR5'),
        ('104147eb-b2b8-8225-b0ca-351570c6f087', '765b7702-b47e-49f8-8b9c-545f00bc3fb8', N'DL03_GE91QS1MHQ'),
        ('c0d0a28f-4e8c-fcf6-246b-6b4a143a6242', '511cb156-d2bf-4f17-9fca-fd1463f83edb', N'DL03_YSBR7W3X4A'),
        ('32699812-9b58-2991-8592-86066eca1f1d', 'd3af0da6-7230-42f9-8bf5-c7b9dfcaf49a', N'DL03_0EMQ7BCX0A'),
        ('74f40555-e500-c5f7-4bf9-dc80db35b9ea', '1b252ff0-fec7-46f5-ae06-66b3a61a6179', N'DL03_BDF1NCQM5A'),
        ('23e985b5-4ec4-fdc7-a629-5dfd4e0c0865', 'ac460d10-06d9-4b47-ae0c-dc624e8d118d', N'DL03_2YKTH0EHM5'),
        ('c5b53da0-a3a3-6679-ac6f-c48be3e722a5', '3ff8babe-1b55-4e7b-b047-029153745f8b', N'DL03_649F1W0PW7'),
        ('58a610ae-5d25-dcd9-5619-7aa409a978a1', '669ba098-cdf4-467e-b2e7-dfed5af04e78', N'DL03_NSRYRPNE8M'),
        ('2426f049-6b37-9663-6756-76b62b957114', 'f036c9e2-2289-4814-8058-6dcfcede0c7f', N'DL01_2BVV5V2C0J'),
        ('8d48db19-254a-f5ef-e46e-df65f1859027', '5fecaf72-a980-4c27-8396-43a2c67f7593', N'DL03_55PY0KGBJN'),
        ('22722017-133a-10a3-0f58-a8cce6953064', 'bb35fbae-df04-4320-8dba-c2f74707942b', N'DL03_0AJC4M5VKQ'),
        ('89be3706-ad83-caec-4ecc-9ec105f369f6', '00c6c5a9-3b18-4624-b9b6-0294ada3b1b0', N'DL03_4SYABV3944'),
        ('3d3c9ef6-f200-778d-d8b9-7cd90252e950', '66d81d37-cfb5-4579-a27c-86387bc1bb35', N'DL03_LDF6D1LYV0'),
        ('222dccf3-0fe4-5cb1-a82e-ba33bc4ce69f', 'ebc20ec7-0333-4f03-94f2-60db19fcd782', N'DL03_HDA4CJLTEE'),
        ('bade2db3-a1a8-9a0c-f339-ed1353b70daf', '632f887d-90e0-4b14-ad83-205dc0033c30', N'DL03_FH9YAQQD5R'),
        ('de526017-cb89-09c1-e2fe-3366a1262d17', '065debbc-efee-4773-9b5b-7c4d3eaf30f1', N'DL03_GKD023DS3S'),
        ('eca4805c-80f9-3502-3e8b-ea34e856da68', '1453f001-6849-4156-8a24-1e5b0bea231a', N'DL03_0MV3LNNRY0'),
        ('3253133b-308c-72f5-675d-eed1122341c0', 'd20f3342-1327-4620-9619-738841804886', N'DL03_4TJEMFS4H5'),
        ('4a756f93-b6b4-689f-1cc2-864fcbf1c303', '1899969e-4394-445f-8ade-fc9c72aafe4f', N'DL03_035WHBJSVS'),
        ('7df2f7a5-a597-9dfe-6013-99a8a9fd6205', '100fb4f4-b41a-42f6-904f-1996aab735ef', N'DL01_E39XM5R4D1'),
        ('45fb9e80-cd0e-9559-ba02-58e8608a44b3', 'fd5d2ee8-d522-4512-bffc-4cfc48581fe7', N'DL03_D639G0FTP9'),
        ('08e92e26-1489-2d19-7a31-602328599b30', '905ffa97-fb52-4124-9012-99a02b727ba4', N'DL01_D5EL2FTFJF'),
        ('002d4f1e-b1bf-4fea-2ff4-285327218c95', 'daea1e1a-e2e2-420f-941e-5f53cee99b11', N'DL03_JCENS63H12'),
        ('375293bb-9707-2049-c5e3-cc2e0722a9f2', '5e266932-df10-4f34-8093-a797a62532a2', N'DL03_1N5BCY89WK'),
        ('65d55af4-7269-3866-c595-2cccf09c282a', '547b3255-0fb9-45b2-bf2b-4568a624cb8b', N'DL03_B62J8E98H6');
";

            //strQuery += string.Join
            //(
            //    ",\n",
            //    deviceIds
            //    // Depending on the timing of device discovery, some devices might not have an associated patient session id yet.
            //    // we skip these and they will get tried again at the next polling.
            //    .Where(tpl => PatientSessionManager.SessionExists(tpl.Item1))
            //    .Select
            //    (
            //        tpl => string.Format
            //        (
            //            "('{0}','{1}',{2})",
            //            tpl.Item1,
            //            PatientSessionManager.GetSessionId(tpl.Item1),
            //            MonitorDisplayFormat.SqlCharacterStringConstant(tpl.Item2)
            //        )
            //    )
            //);

            strQuery += "\n";

            strQuery += "EXEC [dbo].[usp_GetPatientInformation] @deviceIds;\n";

            using (var sqlCommand = new SqlCommand(strQuery))
            {
                // The connection will be closed along with the sqlDataReader
                // because of the CloseConnection argument to ExecuteReader.
                var sqlConnection = new SqlConnection(ConnectionString);
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandTimeout = 60;
                sqlConnection.Open();
                sqlDataReader = sqlCommand.ExecuteReader(CommandBehavior.CloseConnection);

                //outcome = new QueryExecutionOutcome.Data(sqlDataReader);
            }

            //var queryExecutionOutcome = ExecuteQuery(strQuery);

            //if (queryExecutionOutcome is QueryExecutionOutcome.Data)
            //{
            //var sqlDataReader = (queryExecutionOutcome as QueryExecutionOutcome.Data).SqlDataReader;

            //if (sqlDataReader == null || sqlDataReader.IsClosed)
            //    yield break;

            while (sqlDataReader.Read())
            {
                Guid deviceId = Guid.Empty;
                var data = new Dictionary<string, string>();

                foreach (var ordinal in Enumerable.Range(0, sqlDataReader.FieldCount))
                {
                    if (sqlDataReader.IsDBNull(ordinal))
                        continue;

                    var name = sqlDataReader.GetName(ordinal);

                    try
                    {
                        if (name == "DeviceId")
                        {
                            deviceId = sqlDataReader.GetGuid(ordinal);
                        }
                        else
                        {
                            data.Add(sqlDataReader.GetName(ordinal), sqlDataReader.GetString(ordinal));
                        }
                    }
                    catch (InvalidCastException e)
                    {
                        var message = "Cast exception on retrieving key " + name + ".\n";
                        message += " Exception : " + e;
                        //EventLogger.LogDeviceEvent(deviceId, message, EventLogger.EventCategory.Unexpected, EventLogger.EventId.NeedsAttention, EventLogEntryType.Error);
                    }
                }

                //yield return Tuple.Create(deviceId, data);
                var tuple = Tuple.Create(deviceId, data);

                dt.Rows.Add(sqlDataReader);

                Console.WriteLine("{0} - {1}, {2}, {3}, {4}, {5}", deviceId, data["ID1"], data["ID2"], data["FirstName"], data["MiddleName"], data["LastName"]);
            }

            foreach(DataRow dr in dt.Rows)
            {
                Console.WriteLine("{0} - {1}, {2}, {3}, {4}, {5}", dr[0], dr[1], dr[2], dr[3], dr[4], dr[5]);
            }
            return;
            //}
        }
    }
}
