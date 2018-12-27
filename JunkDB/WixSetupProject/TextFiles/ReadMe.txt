//------------------------------------------------------- 
// 
// THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF 
// ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY 
// IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR 
// PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT. 
// 
//------------------------------------------------------- 

To use the Clinical Access Start utility place the program 
executable (Clinical Access Start.exe) and "config" file 
(Clinical Access Start.exe.config) in the same folder on 
the workstation. These files are located in the 

Clinical Access Start.zip\Clinical Access Start\Clinical Access Start\bin\Release

folder. Navigate to the new folder where the files were copied
and double-click Clinical Access Start.exe or right-click 
Clinical Access Start.exe and select Open to start the application.

To define a specific Active Directory Domain for the program to 
use open Clinical Access Start.exe.config in a text editor
like Notepad and located the section of the file shown below.

        <Clinical_Access_Start.Properties.Settings>
            <setting name="Domain" serializeAs="String">
                <value>
                </value>
            </setting>
        </Clinical_Access_Start.Properties.Settings>

Insert the domain name you would like to use between the 
<value> and <\value> tags.