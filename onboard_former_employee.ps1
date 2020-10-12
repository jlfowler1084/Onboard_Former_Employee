
$Repeat = $True
While ($Repeat) {

#######Set the OU's based on your AD layout###################################

    $OU1 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU2 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU3 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU4 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com''
    $OU5 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU6 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU7 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU8 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU9 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU10 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU11 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU12 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU13 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU14 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU15 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU16 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU17 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU18 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU19 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'
    $OU20 = 'OU=,OU=,OU=,OU=Company,DC=Company,DC=com'


    $FormerEmployee = Read-Host "Enter 5-digit UserID"
    $departeduserCAG = "Departed Users"
    $departeduser = Get-ADGroupMember -Identity "$departeduser" -Recursive | Select-Object -ExpandProperty sAMAccountName

############Checks that user is a departed user prior to running######################

    if ($departeduser -contains $FormerEmployee) {
        write-host "$FormerEmployee exists in 'Departed Users'" -ForegroundColor Green
    }
    Else {
        write-host "$FormerEmployee Not a member of Departed Users - Exiting Script"
        Start-Sleep -s 2
        exit
    }


############# Set temporary AD Password, enable account, add to domain users (set domain users as primary group), remove from departed users ##############   


    $pwPlain = "Enter Password"
    Write-Host "User" $FormerEmployee " Set to Enabled" -ForegroundColor Green
    Enable-ADAccount -Identity $FormerEmployee 

    Write-Host "Setting Default Password for user " $FormerEmployee -ForegroundColor Green
    Set-ADAccountPassword -Identity $FormerEmployee -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $pwPlain -Force)

    write-host "User" $FormerEmployee " Adding to Domain Users" -ForegroundColor Green
    $UserDN = Get-ADUser -Identity $FormerEmployee | Select-Object distinguishedName -ExpandProperty distinguishedname
    Add-ADGroupMember "Domain Users" -Members $FormerEmployee 

    $primarygroup = get-adgroup "Domain Users" -properties @("primaryGroupToken")
    Write-Host "Setting Primary Group to Domain Users for user " $FormerEmployee -ForegroundColor Green
    get-aduser $FormerEmployee | set-aduser -replace @{primaryGroupID = $primarygroup.primaryGroupToken } 

    Write-Host "Removing User " $FormerEmployee " From 'Departed Users'" -ForegroundColor Green
    Remove-ADGroupMember -Identity "Departed Users" -Members $FormerEmployee -Confirm:$False

################## Select the users department. User will be moved into the corresponding OU and added to departmental AD group ##############################

    $menu = @"

----------------------------------------------

1.  Dept 1
2.  Dept 2
3.  Dept 3
4.  Dept 4
5.  Dept 5
6.  Dept 5
7.  Dept 6
8.  Dept 7
9.  Dept 8
10. Dept 9
11. Dept 10
12. Dept 11
13. Dept 12
14. Dept 13
15. Dept 14
16. Dept 15
17. Dept 16
18. Dept 17
19. Dept 18
20. Dept 19
Q.  Quit
 
----------------------------------------------

Select a task by number or Q to quit
"@

    Write-Host "Select Users Department from Onboarding Request (This will move user into corresponding OU)" -ForegroundColor Cyan
    $r = Read-Host $menu

    Switch ($r) {

        "1" {
            Write-Host "User" $formeremployee " Moving to OU1" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU1 
            Write-Host "User" $FormerEmployee " Adding to Group1"  -ForegroundColor Green
            Add-ADGroupMember "Group 1" -Members $FormerEmployee 
        }
 
        "2" {
            Write-Host "User" $formeremployee " Moved to OU2" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU2 
            Write-Host "User" $FormerEmployee " Adding to Group 2"  -ForegroundColor Green
            Add-ADGroupMember "Group 2" -Members $FormerEmployee 
        }
 
        "3" {
            Write-Host "User" $formeremployee " Moved to OU3" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU3 
            Write-Host "User" $FormerEmployee " Adding to Group 3"  -ForegroundColor Green
            Add-ADGroupMember "Group 3" -Members $FormerEmployee 
        }

        "4" {
            Write-Host "User" $formeremployee " Moved to OU4" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU4
            Write-Host "User" $FormerEmployee " Adding to Group 4"  -ForegroundColor Green
            Add-ADGroupMember "Group 4" -Members $FormerEmployee 
        }

        "5" {
            Write-Host "User" $formeremployee " Moved to OU5" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU5
            Write-Host "User" $FormerEmployee " Adding to Group 5"  -ForegroundColor Green
            Add-ADGroupMember "Group 5" -Members $FormerEmployee 
        }

        "6" {
            Write-Host "User" $formeremployee " Moved to Client OU6" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU6
            Write-Host "User" $FormerEmployee " Adding to Group 6"  -ForegroundColor Green
            Add-ADGroupMember "Group 6" -Members $FormerEmployee 
        }

        "7" {
            Write-Host "User" $formeremployee " Moved to OU7" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU7
            Write-Host "User" $FormerEmployee " Adding to Group 7"  -ForegroundColor Green
            Add-ADGroupMember "Group 7" -Members $FormerEmployee 
        }


        "8" {
            Write-Host "User" $formeremployee " Moved to OU8" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU8
            Write-Host "User" $FormerEmployee " Adding to Group 8"  -ForegroundColor Green
            Add-ADGroupMember "Group 8" -Members $FormerEmployee 
        }

        "9" {
            Write-Host "User" $formeremployee " Moved to OU9" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU9
            Write-Host "User" $FormerEmployee " Adding to Group 9"  -ForegroundColor Green
            Add-ADGroupMember "CAG - Group 9" -Members $FormerEmployee 
        }

        "10" {
            Write-Host "User" $formeremployee " Moved to OU10" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU10 
            Write-Host "User" $FormerEmployee " Adding to Group 10"  -ForegroundColor Green
            Add-ADGroupMember "Group 10" -Members $FormerEmployee 
        }

        "11" {
            Write-Host "User" $formeremployee " Moved to OU11" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU11 
            Write-Host "User" $FormerEmployee " Adding to Group 11"  -ForegroundColor Green
            Add-ADGroupMember "Group 11" -Members $FormerEmployee 
        }

        "12" {
            Write-Host "User" $formeremployee " Moved to OU12" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU12
            Write-Host "User" $FormerEmployee " Adding to Group 12"  -ForegroundColor Green
            Add-ADGroupMember "Group 12" -Members $FormerEmployee 
        }
 
        "13" {
            Write-Host "User" $formeremployee " Moved to OU13" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU13 
            Write-Host "User" $FormerEmployee " Adding to Group 13"  -ForegroundColor Green
            Add-ADGroupMember "Group 13" -Members $FormerEmployee 
        }

        "14" {
            Write-Host "User" $formeremployee " Moved to OU 14" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU14
            Write-Host "User" $FormerEmployee " Adding to Group 14"  -ForegroundColor Green
            Add-ADGroupMember "Group 14" -Members $FormerEmployee 
        }

        "15" {
            Write-Host "User" $formeremployee " Moved to OU15" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU15
            Write-Host "User" $FormerEmployee " Adding to Group 15"  -ForegroundColor Green
            Add-ADGroupMember "Group 15" -Members $FormerEmployee 
        }

        "16" {
            Write-Host "User" $formeremployee " Moved to OU16" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU16
            Write-Host "User" $FormerEmployee " Adding to Group 16"  -ForegroundColor Green
            Add-ADGroupMember "Group 16" -Members $FormerEmployee 
        }

        "17" {
            Write-Host "User" $formeremployee " Moved to OU17" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU17 
            Write-Host "User" $FormerEmployee " Adding to Group 17"  -ForegroundColor Green
            Add-ADGroupMember "Group 17" -Members $FormerEmployee 
        }

        "18" {
            Write-Host "User" $formeremployee " Moved to OU18" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU18
            Write-Host "User" $FormerEmployee " Adding to Group 18"  -ForegroundColor Green
            Add-ADGroupMember "Group 18" -Members $FormerEmployee 
    
        }

        "19" {
            Write-Host "User" $formeremployee " Moved to OU19" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU19 
            Write-Host "User" $FormerEmployee " Adding to Group 19"  -ForegroundColor Green
            Add-ADGroupMember "Group 19" -Members $FormerEmployee 
        }

        "20" {
            Write-Host "User" $formeremployee " Moved to OU20" -ForegroundColor Green
            Move-ADObject -Identity $UserDN -TargetPath $OU20
            Write-Host "User" $FormerEmployee " Adding to Group 20"  -ForegroundColor Green
            Add-ADGroupMember "Group 20" -Members $FormerEmployee 
        }
        "Q" {
            Write-Host "Quitting" -ForegroundColor Green
        }
 
        default {
            Write-Host "I don't understand what you want to do." -ForegroundColor Yellow
        }
    } #end switch

############# Select users office location. This will create the users home drive on the correct server and add user to correct GPO drive mapping group #############

    $menu2 = @"

----------------------------------------------

1.  Office 1
2.  Office 2
3.  Office 3
4.  Office 4
5.  Office 5
6.  Office 6

Q.  Quit

----------------------------------------------
 
Select a task by number or Q to quit
"@

    Write-Host "Select Users Primary Office Noted in Onboarding Request" -ForegroundColor Cyan
    $r = Read-Host $menu2

    Switch ($r) {

        "1" {
            Write-Host "User" $formeremployee " Added to 'GPO Drive Mapping - Office1'" -ForegroundColor Green
            Add-ADGroupMember "GPO Drive Mapping - Office1" -Members $FormerEmployee 
            $HDrivePath = '\\company.com\dfs\office1_users'
            Write-Host "User" $FormerEmployee " Home Drive Created" -ForegroundColor Green
            New-Item -Path $HomeDrivePath -name $FormerEmployee -ItemType "directory" 
        }
        "2" {
            Write-Host "User" $formeremployee " Added to 'GPO Drive Mapping - Office2'" -ForegroundColor Green
            Add-ADGroupMember "GPO Drive Mapping - Office2" -Members $FormerEmployee 
            $HDrivePath = '\\company.com\dfs\office2_users'
            Write-Host "User" $FormerEmployee " Home Drive Created" -ForegroundColor Green
            New-Item -Path $HDrivePath -name $FormerEmployee -ItemType "directory" 
        }
        "3" {
            Write-Host "User" $formeremployee " Added to 'GPO Drive Mapping - Office3'" -ForegroundColor Green
            Add-ADGroupMember "GPO Drive Mapping - Office3" -Members $FormerEmployee 
            $HDrivePath = '\\company.com\dfs\Office3_users'
            Write-Host "User" $FormerEmployee " Home Drive Created" -ForegroundColor Green
            New-Item -Path $HDrivePath -name $FormerEmployee -ItemType "directory" 
        }
        "4" {
            Write-Host "User" $formeremployee " Added to 'GPO Drive Mapping - Office4'" -ForegroundColor Green
            Add-ADGroupMember "GPO Drive Mapping - Office4" -Members $FormerEmployee 
            $HDrivePath = '\\company.com\dfs\office4_users'
            Write-Host "User" $FormerEmployee " Home Drive Created" -ForegroundColor Green
            New-Item -Path $HDrivePath -name $FormerEmployee -ItemType "directory" 
        }
        "5" {
            Write-Host "User" $formeremployee " Added to 'GPO Drive Mapping - Office5'" -ForegroundColor Green
            Add-ADGroupMember "GPO Drive Mapping - Office5" -Members $FormerEmployee 
            $HDrivePath = '\\company.com\dfs\office5_users'
            Write-Host "User" $FormerEmployee " Home Drive Created" -ForegroundColor Green
            New-Item -Path $HDrivePath -name $FormerEmployee -ItemType "directory" 
        }
        "6" {
            Write-Host "User" $formeremployee " Added to 'GPO Drive Mapping - Office6'" -ForegroundColor Green
            Add-ADGroupMember "GPO Drive Mapping - Office6" -Members $FormerEmployee 
            $HDrivePath = '\\company.com\dfs\office6_users'
            Write-Host "User" $FormerEmployee " Home Drive Created" -ForegroundColor Green
            New-Item -Path $HDrivePath -name $FormerEmployee -ItemType "directory" 
        }

        "Q" {
            Write-Host "Quitting" -ForegroundColor Green
        }

    } #end switch

    ICACLS ("$HDrivePath\$FormerEmployee") /grant "$FormerEmployee`:(OI)(CI)(F)"


############## Enable remote access ##############################################

    $menu3 = @"

----------------------------------------------

Y.  Yes
N.  No

----------------------------------------------

Type 'Y' for yes, 'N' for no
"@


    Write-Host "Will user require Remote Access? (Exempt employees only - Non-exempt employees must be approved by the CTO)" -ForegroundColor Cyan
    $r = Read-Host $menu3

    Switch ($r) {

        "Y" {
            Write-Host "User" $formeremployee " Added to 'Remote Access Group'" -ForegroundColor Green
            Add-ADGroupMember "Remote Access Group" -Members $FormerEmployee  
        }

        "N" {
            Write-Host "Quitting" -ForegroundColor Green
        }


    } #end switch

########### Repeat #################################

    $Answer = Read-Host "Would you like to add another user - type Yes or No"
        
    If ($Answer -eq "No") {
        $Repeat = $False
    }

}
