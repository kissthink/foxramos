/*
; �޸� firadisk.inf Ϊ LoadOrderGroup = Boot Bus Extender
; hklm\SYSTEM\ControlSet001\Control\ServiceGroupOrder

��Hotswap���ŵ�system32Ŀ¼�¡�
ɨ��Ӳ�̣�HotSwap! -s
ֹͣӲ�̣�HotSwap! c: -Q

Devcon.exe��Ӧ�ã�
ɨ���豸��devcon.exe rescan
ж��Ӳ�̣�devcon.exe remove @ide\*

WMI���CIM_LogicalDevice���SetPowerState������������Ӳ�̵�Դ
*/

VersionDate := "2012-9-18"
stringleft, SysDL, A_WinDir, 1 ; ϵͳ�����̵���ĸ
SysDL2 := SysDL . ":"

GuiInit:
	GUi +LastFound
	NowWinID := Winexist()  ; ��ʽ��������Ҫ

	Menu, FAMenu, Add, ��װ΢��RamDisk����(&D), OtherMethod
	Menu, FAMenu, Add, ���΢��RamDisk������Ӳ������(&F), OtherMethod

	Menu, CZMenu, Add, ��װimDisk(&I), OtherActionS
	Menu, CZMenu, Add, ���ؾ���(&M), OtherActionS
	Menu, CZMenu, Add, ж�ؾ���(&U), OtherActionS
	Menu, CZMenu, Add ;---------------------
;	Menu, CZMenu, Add, ��װFileDisk(&F), OtherActionS
	Menu, CZMenu, Add, VDMһ������(&V), OtherActionS
	Menu, CZMenu, Add ;---------------------
	Menu, CZMenu, Add, ʹ��StrArc�ȱ���(&A), OtherActionS
	Menu, CZMenu, Add, ʹ��Reg��������ע���(&S), OtherActionS
	Menu, CZMenu, Add ;---------------------
	Menu, CZMenu, Add, ���������(&R) Win+F11, OtherActionS

	Menu, HelpMenu, Add, ������־(&R), FoxHelp
	Menu, HelpMenu, Add
	Menu, HelpMenu, Add, �÷�(&D), FoxHelp
	Menu, HelpMenu, Add
	Menu, HelpMenu, Add, ����(&P), FoxHelp
	Menu, HelpMenu, Add
	Menu, HelpMenu, Add, ����(&A), FoxHelp

	Menu, SiteMenu, Add, www.olsoul.com(&W), FoxHelp
	Menu, SiteMenu, Add, bbs.olsoul.com(&B), FoxHelp
	Menu, SiteMenu, Add
	Menu, SiteMenu, Add, �������׷���ַ(&R), FoxHelp
	Menu, SiteMenu, Add, ������Դ�����ַ(&S), FoxHelp
	Menu, SiteMenu, Add, ���������ص�ַ(www.autohotkey.net), FoxHelp
	; �����ǲ˵���

	Menu, MyMenuBar, Add, ��������(&F), :FAMenu
	Menu, MyMenuBar, Add, ����(&O), :CZMenu
	Menu, MyMenuBar, Add, ��������(&L), :SiteMenu
	Menu, MyMenuBar, Add, ����(&H), :HelpMenu
	Gui, Menu, MyMenuBar
	; ��������ͼ�ν���
	Gui, Add, GroupBox, x6 y10 w160 h100 cBlue, 1. �����������ļ�����
	Gui, Add, Button, x16 y30 w140 h30 gStepA vGrub4dos, ���Grub4Dos������
	Gui, Add, Button, x16 y70 w140 h30 gStepA vFiraDisk, ��װFiraDisk����

	Gui, Add, GroupBox, x176 y10 w370 h110 cBlue, 2. �����ļ�����:
	Gui, Add, GroupBox, x186 y30 w160 h80 cGreen, ��������(·������С):
	Gui, Add, ComboBox, x196 y50 w140 h20 R26 Choose2 vImgPath, �ڴ���|D:\RamOS.img|D:\Ram2K3.img|E:\RamOS.img
	Gui, Add, Edit, x196 y80 w40 h20 vImgSize, 444
	Gui, Add, Text, x246 y83 w8 h20 cGreen, M
	Gui, Add, Button, x266 y80 w70 h20 gStepB vCreateImg, ����(&C)
Gui, Add, Button, x356 y40 w80 h40 gStepB vMountImg, ���ص�(&M)>>
Gui, Add, Button, x356 y90 w80 h20 gStepB vUnMountImg, ж��(&U)
	Gui, Add, GroupBox, x446 y30 w90 h80 cGreen, Img�����̷�
	Gui, Add, ComboBox, x456 y50 w70 h20 R26 Choose1 vMountDrive, A:|R:|S:
	Gui, Add, Button, x456 y80 w70 h20 gStepB vFormat, ��ʽ��

	Gui, Add, GroupBox, x6 y120 w160 h100 cBlue, 3. �ļ�����:
	Gui, Add, Button, x16 y140 w140 h30 gStepC vCopyVolume, �ȱ���
	Gui, Add, Button, x16 y180 w140 h30 gStepC vRegBakSystem, reg�����system�ļ�

	Gui, Add, GroupBox, x176 y130 w370 h90 cBlue, 4. �̷�����:
	Gui, Add, Button, x186 y150 w50 h50 gStepD vMountReg, �������õ�Ԫ
	Gui, Add, GroupBox, x246 y150 w60 h50 cGreen, ʵ���̷�
	Gui, Add, ComboBox, x256 y170 w40 h20 R26 Choose1 vTrueDrive gChangeVolume, % GetVolList4DD() ; ��ȡ�������б�
	Gui, Add, Button, x316 y150 w80 h20 gStepD vWriteReg, �޸�Ϊ>>
	Gui, Add, Button, x316 y180 w80 h20 gStepD vOpenReg, ע���ȷ��
	Gui, Add, GroupBox, x406 y150 w70 h50 cGreen, RamOS�̷�
	Gui, Add, ComboBox, x416 y170 w50 h20 R26 Choose1 vImgDrive, B:
	Gui, Add, Button, x486 y150 w50 h50 gStepD vUnMountReg, ж�����õ�Ԫ
	; Generated using SmartGUI Creator 4.0

	Gui, Add, Progress, +Hidden cGreen x6 y224 w540 h10 vJinDu, 0
	Gui, Add, StatusBar, , ����״̬��
	SB_SetParts(355, 200)
	Gui, show, y30 h258 w555, ������֮�� �� RamOS �������� %VersionDate%

	Gosub, ChangeVolume    ; ��ʾ �̷���Ӧ�� ע���ֵ
	Gosub, FoxsSizeAdvice  ; Ԥ�������С����������ֵ
	Guicontrol, focus, MountImg
return


ChangeVolume: ; ��ʾ �̷���Ӧ�� ע���ֵ
	Gui, submit, Nohide
	TrueValue := VolumeReg(0, TrueDrive)  ; TrueValue �����õ���
	SB_SetText(TrueDrive . " " . TrueValue, 2)
return

FoxsSizeAdvice:  ; Ԥ�������С����������ֵ
	SysMemSize := GetSysMemSize()  ; �����ڴ��� M
	DriveGet, Size_All, Capacity, %SysDL%:\
	DriveSpaceFree, Size_Free, %SysDL%:\
	Size_Used := round(3 * ( Size_All - Size_Free ) / 4) ; Ԥ�������С=3/4 * ���ô�С

	If ( ( SysMemSize - Size_Used ) < 100 ) {
		SB_SetText(SysDL . "�̹���  Ԥ��ѹ������: " . Size_Used " M  �����ڴ�: " . SysMemSize . " M" )
		Guicontrol, Text, ImgSize, 0
	} else {
		SB_SetText("Ԥ��ѹ������: " . Size_Used " M  �����ڴ�: " . SysMemSize . " M" )
		Guicontrol, Text, ImgSize, %Size_Used%
	}
Return


OtherMethod:  ; �˵�: ��������
	If ( A_thismenuitem = "��װ΢��RamDisk����(&D)" ) {
		msgbox, 260, ȷ��, ȷ�ϰ�װ ΢��� RamDisk ?
		Ifmsgbox, yes
			SB_SetText(InstallRamDisk(SysDL))
		else
			SB_SetText("����װ Ramdisk")
	}
	If ( A_thismenuitem = "���΢��RamDisk������Ӳ������(&F)" )
		SB_SetText(RamDiskNoNewDevice())
return

OtherActionS: ; �˵�: ����
	Gui, submit, nohide
	If ( A_thismenuitem = "��װimDisk(&I)" )
		SB_SetText(InstallimDisk())
;	If ( A_thismenuitem = "��װFileDisk(&F)" )
;		SB_SetText(InstallFileDisk())
	If ( A_thismenuitem = "���ؾ���(&M)" ) {
		IfNotExist, %A_windir%\system32\drivers\imdisk.sys
			SB_SetText(InstallimDisk()) ; ��װ�����������
		SB_SetText(mountImg(ImgPath, MountDrive))
	}
	If ( A_thismenuitem = "ж�ؾ���(&U)" )
		SB_SetText(UnmountImg(MountDrive))
	If ( A_thismenuitem = "VDMһ������(&V)" ) {
		SetVDM(1, ImgPath, MountDrive)
		Run, % TestExePath("D:\bin\isotool\VDM1.exe," . A_scriptdir . "\FoxRamOS\VDM\VDM1.exe,C:\bin\isotool\VDM1.exe,X:\WXPE\SYSTEM32\VDM1.exe"), , Min
		
	}
	If ( A_thismenuitem = "ʹ��StrArc�ȱ���(&A)" ) {
		IfExist, %MountDrive%\
			runwait, cmd /c strarc -r -cd:%SysDL%: | strarc -xld:%MountDrive% , %A_scriptdir%\FoxRamOS
		SB_SetText("��ϲ: ��StrArc�������")
	}
	If ( A_thismenuitem = "ʹ��Reg��������ע���(&S)" ) {
		SaveAllHives(MountDrive . "\")
		SB_SetText("��ϲ: ע���ȫ���������")
	}
	If ( A_thismenuitem = "���������(&R) Win+F11" )
		gosub, Reboot
return

StepA:
	If ( A_guiControl = "Grub4dos" ) {
		SB_SetText(InstallGrub4Dos(SysDL))
		msgbox, 260, ���, Ҫȷ��һ����
		IfMsgbox, Yes
			run, explorer %SysDL%:\
	}
	If ( A_guiControl = "FiraDisk" )
		SB_SetText("FiraDisk ��װ��...") , SB_SetText(InstallFiraDisk())
return

StepB:
	Gui, Submit, Nohide
	If ( ( A_guiControl = "CreateImg" or A_guiControl = "MountImg" ) and ImgPath = "�ڴ���" ) {
		IfNotExist, %A_windir%\system32\drivers\imdisk.sys
			SB_SetText(InstallimDisk())
		runwait, imdisk -a -s %imgSize%m -m %MountDrive% -p "/FS:fat /q /y", , Hide
		SB_SetText("�����ڴ��� " . MountDrive . "���, ��С: " . imgSize . " M")
		return
	}
	If ( A_guiControl = "CreateImg" ) {
		stringleft, ImgPathDrive, ImgPath, 3
		DriveSpaceFree, ImgPathDriveSize, %ImgPathDrive%
		If ( ImgPathDriveSize < imgSize ) {
			SB_SetText("Ҫ����img���ڿռ䲻�㣬�������С")
			return
		}
		IfExist, %ImgPath%
		{
			SB_SetText("img�ļ����ڣ���������ԭ�ļ�")
			return
		}
		SB_SetText(ImgPath . "  ������...")
		CreateBlankFile(ImgPath, ImgSize*1024*1024)
		SB_SetText("IMG�������: " . ImgPath . "  ��С: " . ImgSize . " M")
	}
	If ( A_guiControl = "MountImg" ) {
		IfNotExist, %A_windir%\system32\drivers\imdisk.sys
			SB_SetText(InstallimDisk()) ; ��װ�����������
		SB_SetText(mountImg(ImgPath, MountDrive))
	}
	If ( A_guiControl = "UnMountImg" )
		SB_SetText(UnmountImg(MountDrive))
	If ( A_guiControl = "Format" ) {
		stringleft, SelDriver, MountDrive, 1
		Dllcall("Shell32.dll\SHFormatDrive", "Uint", NowWinID, "Uint"
		, ASC(SelDriver)-65, "Uint", 0xFFFF, "Uint", 1)
	}
return

StepC:
	Gui, Submit, Nohide
	If ( A_guiControl = "CopyVolume" ) {
		driveGet, MMDslsdStatus, FS, %MountDrive%
		If ( MMDslsdStatus = "" or ErrorLevel = 1 ) {
			SB_SetText(MountDrive . " �����ڻ�δ��ʽ��")
			return
		}
		sTime := A_tickcount
		CopyVolume(SysDL2, MountDrive)
		IniWrite, 0, %MountDrive%\boot.ini, boot loader, timeout
		IniDelete, %MountDrive%\boot.ini, operating systems, %SysDL2%\grldr

		IfExist, %A_scriptdir%\CopyError.lst 
		{
			SB_SetText("�������: ���ļ�δ���Ƴɹ������Ժ��ٸ���")
			run, notepad %A_scriptdir%\CopyError.lst
		} else
			SB_SetText("�ɹ�����: " . SysDL2 . " -> " . MountDrive . " ��ʱ: " . ( A_tickcount - sTime ) . " ����")
	}
	If ( A_guiControl = "RegBakSystem" ) {
		sb_setText("������: HKLM\system -> " . MountDrive . "\WINDOWS\SYSTEM32\config\system")
		RetAkssk := BakXPHiveSystem(MountDrive)
		If ( RetAkssk = 0 )
			sb_setText("�ɹ�: HKLM\system -> " . MountDrive . "\WINDOWS\SYSTEM32\config\system")
		else
			sb_setText("����ʧ��: " . RetAkssk)

	}
return

StepD:
	Gui, Submit, Nohide
	If ( A_guiControl = "MountReg" ) {
		IfNotExist, %MountDrive%\WINDOWS\system32\config\system
		{
			sb_setText("����system���õ�Ԫ�����ڣ����ȹ���")
			return
		}
		sb_setText("������: HKLM\systemR")
		GuiControl, Disable, WriteReg
		runwait, REG LOAD HKLM\systemR %MountDrive%\WINDOWS\system32\config\system, , Hide
		GuiControl, Enable, WriteReg
		sb_setText("�������: HKLM\systemR")
	}
	If ( A_guiControl = "WriteReg" )
		VolumeReg(1, TrueDrive, ImgDrive, TrueValue) , sb_setText("ע���д��������: HKLM\systemR")
	If ( A_guiControl = "OpenReg" ) {
		RegOpenPath := "Software\Microsoft\Windows\CurrentVersion\Applets\Regedit"
		RegWrite, REG_SZ, HKCU, %RegOpenPath%, LastKey, �ҵĵ���\HKEY_LOCAL_MACHINE\SYSTEMR\MountedDevices
		run, regedit
	}
	If ( A_guiControl = "UnMountReg" ) {
		sb_setText("ж����: HKLM\systemR")
		runwait, REG UnLOAD HKLM\systemR, , Hide
		sb_setText("ж�����: HKLM\systemR")
	}
return


GuiClose:
GuiEscape:
	ExitApp
return

FoxHelp:
Problem=
(Join`n
������ͬ����Ŀ��Բ�������ķ������:

��һ�ν�ϵͳ ��ʾ����
1. ��һ�ν�RamOS��������ҵ���Ӳ��,Ȼ�󵯳���ʾ�����Ի���, ѡ�� ������
2. ���б����ߣ���� ���ص� ��ť, ���ؾ��� A:[Ĭ��] ��
3. ��� reg�����system�ļ� ��ť
4. ��� ж�� ��ť
5. ������Ӧ�þ�û����ʾ��

���ʹ��HotSwap����ò�ƻ����´ν�ramos������Ӳ��
΢��ramdisk�����ľ��� 444Mʱ����, 470Mʱ������(������), ԭ����
   ����취�������հ׾���Ĵ�СҪ���Լ���

)
Thanks=
(Join`n
����: ������֮��
QQ: 308639546
Ⱥ��: 120902759
��̳ID: linpinger

��л: 
OlSoulϵͳQQһȺ: 3719654
Olsoul(QQ:�������Ⱥ��)
Olsoul��̳: http://bbs.olsoul.com
�׹�(QQ:873397921)
)
GrubFiraHelp=
(Join`n
�÷�˵��:
   ϵͳ�����: reg.exe sc.exe [ regini.exe ]

1. �ȵ����ť��װGrub4dos, FiraDisk [��ѡ����������[΢��ramdisk(����Ram2K3)]]
2. ����һ���հ�img[�ļ�����Ҫ�޸ģ����޸�grldr���ò˵�]��Ȼ�����
   ������Ϻ󣬵����ʽ��(ѡ�� NTFS ����ѹ��, ������ò�ƻ�����)����ʽ���ղŹ��صľ���
3. ��� �ȱ��� ��ť (���θ��ƺ�ʱ�ϳ�)


����Ĳ�����Ϊ�˽����RamOS���̷���������

1. �� �������õ�Ԫ��ѡ��ʵ���̷���ramos�̷�(����Ĭ�ϼ���)������޸�Ϊ��ť
2. ��� ע���ȷ�ϣ�ȷ���޸ĳɹ���������ɾע�����
3. �ر�ע���༭����Ȼ����ж�����õ�Ԫ��ť

OK, ĿǰΪֹ��RamOS�������ˣ�������ѡ����Ŀ Grub4Dos, �����ѡ ramos

)

UpdateLog =
(Join`n
2011-05-18: ���: ʹ�� imDisk ��� FileDisk, ������ǿ���ҿ��ܱ���FileDisk�����ж�ز�������
            ���: �����ڴ��̹���(�ھ���·����ѡ�� �ڴ���,Ȼ�������С,ѡ������̷�,����������ذ�ť)
2011-03-14: ���: Reg���������ע���(��лqiqiqicool���)���˵�
2011-03-09: ���: �����µ��ȱ��ݹ���strarc(http://www.ltr-data.se/opencode.html/), ����������˵�
2011-03-09: ����: ����firadisk�汾�� 0.0.1.30, ��˵�ð汾�����2k3����������
2011-02-12: ���: ��Դ����ų����ˣ���ַ: http://bbs.olsoul.com/read-htm-tid-526.html
2011-01-11: ���: �������ӣ���������������ж�ذ�ť
2010-11-10: ���: �˵���(������ʹ�õĹ��ܷ��ڹ�������),����GUI���岼�� 
            ���: Grub4dosĿ¼�����grldr���ò˵��༭����
2010-10-08: ���: ���reg����system���Ҽ��˵�
2010-08-27: ����: �ȱ�����ӽ�����, grldr���ò˵�(����grub4dosĿ¼�·����Լ���menu.lst)
2010-08-24: ����: ��rawread����Ϊ rawread.dll, ���ڵ���

)

	If ( A_thismenuitem = "������־(&R)" )
		msgbox, %UpdateLog%
	If ( A_thismenuitem = "�÷�(&D)" )
		msgbox, %GrubFiraHelp%
	If ( A_thismenuitem = "����(&P)" )
		msgbox, %Problem%
	If ( A_thismenuitem = "����(&A)" )
		msgbox, %Thanks%
	If ( A_thismenuitem = "www.olsoul.com(&W)" )
		run, http://www.olsoul.com
	If ( A_thismenuitem = "bbs.olsoul.com(&B)" )
		run, http://bbs.olsoul.com
	If ( A_thismenuitem = "�������׷���ַ(&R)" )
		run, http://bbs.olsoul.com/read-htm-tid-228.html
	If ( A_thismenuitem = "������Դ�����ַ(&S)" )
		run, http://bbs.olsoul.com/read-htm-tid-526.html
	If ( A_thismenuitem = "���������ص�ַ(www.autohotkey.net)")
		run, http://linpinger.github.io

return

Reboot: ; ����
	msgbox,260,,���Ҫ������
	ifmsgbox,yes
		shutdown,2
return

; -----��ע:
^esc::reload
+esc::Edit
!esc::ExitApp
#F11::gosub, Reboot

BakXPHiveSystem(TarDriver="A:")
{
	XPPath := TarDriver . "\WINDOWS\SYSTEM32\config\system"
	IfNotExist, %XPPath%
		runwait, Reg SAVE HKLM\SYSTEM %XPPath%, , Hide
	else {
		msgbox,260,,system�ļ����ڣ��Ƿ񸲸ǣ�
		ifmsgbox,yes
		{
			FileDelete, %XPPath%
			runwait, Reg SAVE HKLM\SYSTEM %XPPath%, , Hide
		}
	}
	IfExist, %XPPath%
		return 0
	else
		return "����ʧ�ܣ�������Ŀ��Ŀ¼������"
}

GetSysMemSize()  ; ��ȡ�����ڴ�����(M)
{
	VarSetCapacity(MEMORYSTATUSEX,64,0) , NumPut(64,MEMORYSTATUSEX) 
	DllCall("GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX) 
	PhysMemSizeB := NumGet(MEMORYSTATUSEX,8,"Int64")
	return, Round(PhysMemSizeB/1024/1024)
}


VolumeReg(Action=0, SrcDrive="C:" , DesDrive="B:", DesValue="") ; ʵ������Ϣ->�޸�->ӳ��ע���
{
	If ( Action = 0 ) {
		RegRead, SrcValue, HKLM, SYSTEM\MountedDevices, \DosDevices\%SrcDrive%
		return, SrcValue
	} Else {
		RegDelete, HKLM, systemR\MountedDevices, \DosDevices\%SrcDrive%
		RegWrite, REG_BINARY, HKLM, systemR\MountedDevices, \DosDevices\%DesDrive%, %DesValue%
	}
}


GetVolList4DD()  ; ��ȡ�������б�
{
	DriveGet, tmp_fksd, List, FIXED
	loop, parse, tmp_fksd
		VolumeDList .= A_loopField . ":|"
	stringtrimright, VolumeDList, VolumeDList, 1
	tmp_fksd := "" ; �ͷ��ڴ�
	return, VolumeDList
}

InstallGrub4Dos(TarDrive="C") ; ��װ Grub4Dos
{
	SrcDir := TestExePath("D:\bin\img," . A_scriptdir . "\FoxRamOS\Grub4Dos")
	FileCopy, %SrcDir%\grldr, %TarDrive%:\grldr, 1
	FileCopy, %SrcDir%\menu.lst, %TarDrive%:\menu.lst, 1

	FileSetAttrib, -R, %TarDrive%:\boot.ini
	IniWrite, 5, %TarDrive%:\boot.ini, boot loader, timeout
	IniWrite, "Grub4Dos", %TarDrive%:\boot.ini, operating systems, %TarDrive%:\grldr
	return, "Grub4Dos�Ѳ��õ�: " . TarDrive
}

CopyVolume(SrcDir="C:", DesDir="A:") ; �����ݸ���: ʹ��ǿ�Ƹ���
{
;	RawReadPath := A_scriptdir . "\FoxRamOS\RawRead.exe"
	RawReadPath := A_scriptdir . "\FoxRamOS\RawRead.dll"
	hModule := DllCall("LoadLibrary", "str", RawReadPath)
	
	IfNotExist, %SrcDir%
	{
		msgbox, ������Ŀ¼: %SrcDir%
		return
	}
	IfNotExist, %DesDir%
		FileCreateDir, %DesDir%
	JumpList=
	(Ltrim Join`,
	:\pagefile.sys
	:\System Volume Information
	\Temporary Internet Files\
	\Temp\
	)
	; -----������
	sTime := A_tickcount
	FileCount := 0 , NowCount := 0
	SB_settext("����: ɨ���ļ���...")
	loop, %SrcDir%\*, 1, 1
		 ++FileCount
	SB_settext( "ɨ�����! ��ʱ: " . (A_tickcount - sTime) . " ����  �ļ���: " . FileCount)
	Guicontrol, Show, JinDu
	; -----������

	FileDelete, %A_scriptdir%\CopyError.lst
	loop, %SrcDir%\*, 1, 1
	{       ; ѭ��������Ŀ¼
		; -----������
		++NowCount
		Guicontrol, , JinDu, % NowCount / FileCount * 100
		sb_setText(NowCount . " : " . A_LoopFileName, 2)
		; -----������

		stringreplace, TarFullPath, A_LoopFileFullPath, %SrcDir%, %DesDir%, A
		If A_LoopFileFullPath contains %JumpList%
			continue
		If instr(A_LoopFileAttrib, "D")
		{
			IfNotExist, %TarFullPath%
			{
				FileCreateDir, %TarFullPath%
				FileSetAttrib, +%A_LoopFileAttrib%, %TarFullPath%, 2, 0
			}
			continue
		}
		FileGetTime, TarTime, %TarFullPath%, M
		If ( A_LoopFileTimeModified = TarTime )
			continue
		Filecopy, %A_LoopFileFullPath%, %TarFullPath%, 1
		If Errorlevel
		{
			If instr(A_LoopFileName, ".log") ;or instr(A_LoopFileFullPath, "\Temp\")
				continue
			FileDelete, %TarFullPath%
;			runwait, %RawReadPath% "%A_LoopFileFullPath%" "%TarFullPath%", , Hide
;			FH := dllcall(RawReadPath . "\FileCopy", int, 55555, str, A_LoopFileFullPath, str, TarFullPath)
			FH := dllcall("RawRead\FileCopy", int, 55555, str, A_LoopFileFullPath, str, TarFullPath)
;			IfNotExist, %TarFullPath%
			If ( FH != 0 )
				FileAppend, %A_LoopFileFullPath%|%FH%`r`n, %A_scriptdir%\CopyError.lst
		}
	}
	DllCall("FreeLibrary", "UInt", hModule)
}


InstallFiraDisk() ; ��װFiraDisk����
{
	DevConP := TestExePath("D:\bin\bin32\devcon.exe," . A_scriptdir . "\FoxRamOS\devcon.exe,C:\bin\bin32\devcon.exe")
	IfExist, %A_windir%\system32\drivers\firadisk.sys
	{
		msgbox, 260, ȷ��, �Ѽ�⵽FiraDisk.sys���Ƿ�ǿ�ư�װ��
		Ifmsgbox, no
			return, "ò���Ѿ���װ��FiraDisk"
	}
	SrcDir := A_scriptdir . "\FoxRamOS"
	RunWait, "%DevConP%" install "%SrcDir%\FiraDisk\firadisk.INF" root\firadisk, %SrcDir%, Hide
	return, "FiraDisk ��װ���"
}

CreateBlankFile(FilePath="D:\RamOS.img", Size=55) ; �������ļ�
{
	If ( ( hFile:=DllCall("CreateFile", Str,FilePath, UInt,0x80000000|0x40000000, UInt,0x1|0x2, UInt,0, UInt,1, UInt,0, UInt,0) ) < 0 )
		Return -1
	If DllCall( "SetFilePointerEx", UInt,hFile, Int64,Size, Int64P,nPtr, UInt,0 ) = 0
		Return (DllCall( "CloseHandle", UInt,hFile )+null) "-2"
	If DllCall( "SetEndOfFile", UInt,hFile ) = 0
		Return (DllCall( "CloseHandle", UInt,hFile )+null) "-3"
	Return (DllCall( "CloseHandle", UInt,hFile )+null) "1"
}

; ---------------------------------------
InstallimDisk2() ; ��װimDisk
{
	SrcDir := A_scriptdir . "\FoxRamOS\imDisk"
	IfExist, %A_windir%\system32\drivers\imdisk.sys
	{
		msgbox, 260, ȷ��, �Ѽ�⵽imdisk.sys���Ƿ�ǿ�ư�װ��
		Ifmsgbox, no
			return, "ò���Ѿ���װ��imDisk"
	}
	runwait, rundll32.exe setupapi.dll`,InstallHinfSection Defaultinstall 132 %SrcDir%\imdisk.inf ; ��װ
	return, "��װ���: imDisk"
}

InstallimDisk() ; ��װimDisk
{
	SrcDir := A_scriptdir . "\FoxRamOS\imDisk"
	IfExist, %A_windir%\system32\drivers\imdisk.sys
	{
		msgbox, 260, ȷ��, �Ѽ�⵽imdisk.sys���Ƿ�ǿ�ư�װ��
		Ifmsgbox, no
			return, "ò���Ѿ���װ��imDisk"
	}

	Filecopy, %SrcDir%\awealloc\i386\awealloc.sys, %A_windir%\system32\drivers\awealloc.sys, 1
	Filecopy, %SrcDir%\cli\i386\imdisk.exe, %A_windir%\system32\imdisk.exe, 1
	Filecopy, %SrcDir%\cpl\i386\imdisk.cpl, %A_windir%\system32\imdisk.cpl, 1
	Filecopy, %SrcDir%\svc\i386\imdsksvc.exe, %A_windir%\system32\imdsksvc.exe, 1
	Filecopy, %SrcDir%\sys\i386\imdisk.sys, %A_windir%\system32\drivers\imdisk.sys, 1
	Filecopy, %SrcDir%\imdisk.inf, %A_windir%\inf\imdisk.inf, 1

	runwait, sc create imdisk binpath= system32\DRIVERS\imDisk.sys type= kernel error= ignore displayname= "ImDisk Virtual Disk Driver", , Hide
	runwait, sc create awealloc binpath= system32\DRIVERS\awealloc.sys type= kernel error= ignore displayname= "AWE Memory Allocation Driver", , Hide
	runwait, sc create imdsksvc binpath= system32\imdsksvc.exe type= own error= ignore displayname= "ImDisk Virtual Disk Driver Helper", , Hide

	; ж����
	UninsPath := "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ImDisk"
	regwrite, reg_sz, HKLM, %UninsPath%, DisplayIcon, %A_windir%\system32\imdisk.cpl
	regwrite, reg_sz, HKLM, %UninsPath%, DisplayName, ImDisk Virtual Disk Driver
	regwrite, reg_dword, HKLM, %UninsPath%, EstimatedSize, 3635
	regwrite, reg_sz, HKLM, %UninsPath%, Size
	regwrite, reg_sz, HKLM, %UninsPath%, UninstallString, rundll32.exe setupapi.dll`,InstallHinfSection DefaultUninstall 132 %A_windir%\INF\imdisk.inf

	; �Ҽ��˵�
;	regwrite, reg_sz, hkcr, *\shell\ImDiskMountFile, , Mount as ImDisk Virtual Disk
	regwrite, reg_sz, hkcr, *\shell\ImDiskMountFile, , ����ΪImDisk������(&M)
	regwrite, reg_sz, hkcr, *\shell\ImDiskMountFile\command, , rundll32.exe imdisk.cpl`,RunDLL_MountFile `%L

;	regwrite, reg_sz, hkcr, Drive\shell\ImDiskUnmount, , Unmount ImDisk Virtual Disk
	regwrite, reg_sz, hkcr, Drive\shell\ImDiskUnmount, , ж��ImDisk������(&U)
	regwrite, reg_sz, hkcr, Drive\shell\ImDiskUnmount\command, , rundll32.exe imdisk.cpl`,RunDLL_RemoveDevice `%L

;	regwrite, reg_sz, hkcr, Drive\shell\ImDiskSaveImage, , Save disk contents as image file
	regwrite, reg_sz, hkcr, Drive\shell\ImDiskSaveImage, , ����������ݵ�ӳ���ļ�(&S)
	regwrite, reg_sz, hkcr, Drive\shell\ImDiskSaveImage\command, , rundll32.exe imdisk.cpl`,RunDLL_SaveImageFile `%L

	return, "��װ���: imDisk"
}


mountImg(ImgPath="D:\RamOS.img", DL="A:") ; �����������
{
	runwait, imdisk -a -f "%ImgPath%" -m %DL%, , Hide
	return, "�ɹ����ؾ��� " . ImgPath . " ��: " . DL
}

UnmountImg(DL="A:") ; ж���������
{
	runwait, imdisk -d -m %DL%, , Hide
	return, "�ɹ�ж�ط���: " . DL
}

/*
InstallFileDisk() ; ��װ�����������
{
	SrcDir := A_scriptdir . "\FoxRamOS\FileDisk"
	IfExist, %A_windir%\system32\drivers\filedisk.sys
	{
		msgbox, 260, ȷ��, �Ѽ�⵽filedisk.sys���Ƿ�ǿ�ư�װ��
		Ifmsgbox, no
			return, "ò���Ѿ���װ��FileDisk"
	}
	Filecopy, %srcDir%\filedisk.sys, %A_windir%\system32\drivers\filedisk.sys, 1
	Filecopy, %srcDir%\filedisk.exe, %A_windir%\system32\filedisk.exe, 1
	runwait, sc create filedisk binpath= system32\DRIVERS\filedisk.sys type= kernel start= system, , Hide
	RegWrite, REG_DWORD, HKLM, SYSTEM\CurrentControlSet\Services\FileDisk\Parameters, NumberOfDevices, 4
	return, "��װ���: FileDisk"
}

mountImg_filedisk(ImgPath="D:\RamOS.img", DL="A:") ; �����������
{
	Random, DN, 0, 3  ; �豸�ţ�ò������ĸ��豸
	
	SrcDir := A_scriptdir . "\FoxRamOS\FileDisk"
	runwait, sc start filedisk, , Hide
	SplitPath, ImgPath, , , ImgExt
	If ( ImgExt = "iso" )
		RunWait, %SrcDir%\filedisk.exe /mount %DN% %ImgPath% /cd %DL%, , Hide
	else
		RunWait, %SrcDir%\filedisk.exe /mount %DN% %ImgPath% %DL%, , Hide
	return, "�ɹ����ؾ���: " . DL . "  ���: " . DN
}

UnmountImg_filedisk(DL="A:") ; ж���������
{
	SrcDir := A_scriptdir . "\FoxRamOS\FileDisk"
	RunWait, %SrcDir%\filedisk.exe /umount %DL%, , Hide
	runwait, sc stop filedisk, , Hide
	return, "�ɹ�ж�ط���: " . DL
}
*/
; ---------------------------------------

SetVDM(MountPrevious=1, SrcImg="D:\RamOS.img", TarDrive="A:", ReadOnly=0) ; ����VDMע�����
{
	RegPath := "Software\Towodo Software\Virtual Drive Manager\Settings"
	MountStr=
	(Ltrim Join`n
	%TarDrive%
	auto detect
	disabled
	%SrcImg%
	%ReadOnly%
	)
	If ( MountPrevious = 1 ) {
		RegWrite, REG_DWORD, HKCU, %RegPath%, MountPrevious, 1
		RegWrite, REG_MULTI_SZ, HKCU, %RegPath%, LastMounts, %MountStr%
	} else {
		RegWrite, REG_DWORD, HKCU, %RegPath%, MountPrevious, 0
		RegWrite, REG_MULTI_SZ, HKCU, %RegPath%, LastMounts, 
	}
}

InstallRamDisk(TarDrive="C")  ; ��װ MS RamDisk ����, �����ƽ� ntldr, �޸�boot.ini
{
	DevConP := TestExePath("D:\bin\bin32\devcon.exe," . A_scriptdir . "\FoxRamOS\devcon.exe,C:\bin\bin32\devcon.exe")
	SrcPath := A_scriptdir . "\FoxRamOS\RamDisk"
	IfNotExist, %SrcPath%\ramdisk.sys
		return, "Դramdisk.sys������"
	runwait, %DevConP% install %SrcPath%\ramdisk.inf "Ramdisk", %SrcPath%\, Hide
	runwait, %DevConP% install %SrcPath%\ramdisk.inf "Ramdisk\RamVolume", %SrcPath%\, Hide
;	regwrite, REG_DWORD, HKLM, SYSTEM\CurrentControlSet\Services\Ramdisk, Start, 0
	
	FileMove, %TarDrive%:\ntldr, %TarDrive%:\ntldr.fox, 1
	FileCopy, %SrcPath%\ntldr, %TarDrive%:\ntldr, 1

	FileSetAttrib, -R, %TarDrive%:\boot.ini
	IniWrite, 5, %TarDrive%:\boot.ini, boot loader, timeout
	IniWrite, "MS RamXP" /pae /fastdetect /rdpath=multi(0)disk(0)rdisk(0)partition(2)\RamOS.img, %TarDrive%:\boot.ini, operating systems, ramdisk(0)\Windows
	return, "΢��Ramdisk��װ���, �ɿ�ʼ��������"
}

RamDiskNoNewDevice()
{	; ��� Ramdisk �����ķ�����Ӳ������
	IfNotExist, %A_windir%\SYSTEM32\regini.exe
		return, "Regini.exe������"
	RegRead, tmpw3la, HKLM, SYSTEMR\ControlSet001\Services\RpcSs, Start
	If ErrorLevel
		return, "�㻹û�й���ӳ���System���õ�Ԫ"
	
	Set_Permissions("HKEY_LOCAL_MACHINE\SYSTEMR\ControlSet001\Enum [7 17]`r`n") ; �޸ĺ�Ȩ��

	TarRegPath := "SYSTEMR\ControlSet001\Enum\Ramdisk\RamVolume\{d9b257fc-684e-4dcb-ab79-03cfa2f6b750}"
	RegWrite, Reg_Dword, HKLM, %TarRegPath%, Capabilities, 0xF0
	RegWrite, Reg_SZ, HKLM, %TarRegPath%, Class, Ramdisk
	RegWrite, Reg_SZ, HKLM, %TarRegPath%, ClassGUID, {9D6D66A6-0B0C-4563-9077-A0E9A7955AE4}
	RegWrite, Reg_Dword, HKLM, %TarRegPath%, ConfigFlags, 0
	RegWrite, Reg_SZ, HKLM, %TarRegPath%, DeviceDesc, Windows RAM �����豸(��)
	RegWrite, Reg_SZ, HKLM, %TarRegPath%, Driver, {9D6D66A6-0B0C-4563-9077-A0E9A7955AE4}\0002
	RegWrite, Reg_MULTI_SZ, HKLM, %TarRegPath%, HardwareID, Ramdisk\RamVolume
	RegWrite, Reg_SZ, HKLM, %TarRegPath%, LocationInformation, Ramdisk\0
	RegWrite, Reg_SZ, HKLM, %TarRegPath%, Mfg, Microsoft
	RegWrite, Reg_SZ, HKLM, %TarRegPath%\Control
	RegWrite, Reg_SZ, HKLM, %TarRegPath%\LogConf

	Set_Permissions("HKEY_LOCAL_MACHINE\SYSTEMR\ControlSet001\Enum [8 17]`r`n") ; �ָ�ԭʼȨ��
	return, "Ramdisk������Ӳ���������ѽ��"
}

; ------------
SaveAllHives(TarDriver="A:\")
{	; ����ע�����ϵͳ�����е����õ�Ԫ
	IfNotExist, %A_windir%\system32\reg.exe
		return, "Reg.exe������"
	IfNotExist, %A_windir%\system32\regini.exe
		return, "Regini.exe������"

	HiveList := GetHiveList() ; ��= ��`n
	loop, parse, hivelist, `n, `r
	{
		If ( A_loopfield = "" )
			continue
		stringsplit, ksd_, A_loopfield, =
		TempPath = %TarDriver%%ksd_2%
		SplitPath, TempPath, , OutDir
		IfNotExist, %OutDir%
			FileCreateDir, %OutDir%
		
SB_SetText("����: " . ksd_1)
		If instr(ksd_1, "SECURITY")
		{
			Set_Permissions("HKEY_LOCAL_MACHINE\SECURITY [1 17]`r`n") ; �޸ĺ�Ȩ��
			runwait, Reg SAVE "%ksd_1%" "%TempPath%", , Hide
			Set_Permissions("HKEY_LOCAL_MACHINE\SECURITY [17]`r`n") ; ��ԭʼȨ��
		} else
			runwait, Reg SAVE "%ksd_1%" "%TempPath%", , Hide
	}
}

GetHiveList() ; ��= ��`n
{
	; ��ȡ ʹ���е�ע����ļ� �б�
	; HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\hivelist
	loop, HKLM, SYSTEM\CurrentControlSet\Control\hivelist
	{
		RegRead, NowValue
		Lists := A_LoopRegName . "=" . NowValue . "`n" . Lists
	}

	; ����Ϊ reg���� ��Ҫ�ĸ�ʽ
	stringreplace, Lists, Lists, \REGISTRY\MACHINE\, HKLM\, A
	stringreplace, Lists, Lists, \REGISTRY\USER\, HKU\, A
	loop, parse, Lists, `n, `r
	{
		regexmatch(A_loopfield, "Ui)(^[^=]+)=\\Device\\[^\\]+\\(.*)$", aaa_)
		If ( aaa_2 = "" )
			continue
		EndList .= aaa_1 . "=" . aaa_2 . "`n"
	}
	return, EndList
}

Set_Permissions(permissions="HKEY_LOCAL_MACHINE\SECURITY [17]`r`n")
{	; ʹ�� regini �޸�ע���Ȩ��
	fileappend, %permissions%, %A_windir%\foxquanxian.ini
	runwait, regini %A_windir%\foxquanxian.ini, , hide
	filedelete, %A_windir%\foxquanxian.ini
}

/*
Get_system_cmd()
{	; ��ȡһ������ system Ȩ�޵� cmd , �о��ú���
	runwait, sc Create systemcmd binPath= "cmd /K start" type= own type= interact, , hide
	runwait, sc start systemcmd, , hide
	runwait,sc delete systemcmd, , hide
}
*/

; ------------

TestExePath(PathList="c:\a.exe,d:\b.exe")
{
	loop, parse, PathList, `,, %A_space%
		IfExist, %A_loopfield%
			return, A_loopfield
}

/*
�ⷢ��Ҫ������:
1. ���� gru4dos �ļ��е� FoxRamOS��
2. ���� VDM�ļ��е� FoxRamOS��
3. ���� devcon.exe�� FoxRamOS��
*/

