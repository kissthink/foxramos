/*
�����Զ���(A,PageFile��)
*/
VerDate := "2012-9-21"
Drive_SysNow := "C:" ; ϵͳ�̷�
Drive_MountImg := "A:" ; ����Img���̷�
Drive_SysInRam := "B:" ; ϵͳ�̷���RamOS�е��̷�
ImgPath := "D:\RamOS.img"  ; Img·��

	DriveGet, NowDriveList, List ; ��ȡ��ǰ�̷��б���B��˵��������RamOS
	if instr(NowDriveList, "B")
		Ca1 := 0 , Ca2 := 1
	else
		Ca1 := 1 , Ca2 := 0

FoxRamOSGUIInit:
Gui, Add, Tab2, x0 y0 w480 h330 vFoxTab AltSubmit , 0.���ܼ�ѡ��|1.��װ����|2.��������|�������|������

Gui, Tab, 1
Gui, Font, s12
Gui, Add, Text, x6 y30 w460 h140 +border cGreen, %A_space%`t`t��ӭʹ�� FoxRamOS ������`n`n�������ߵ�Ŀ����Ϊ�˰�������������һ�����õ�RamOS`n����ȷ�����¼���:`n`t1. �Ѿ�װ��ϵͳ(�Ƽ�220M���ҵľ���XP)`,���ѱ���`n`t2. ����ϵͳ�е���Щ�������ʹ��:sc`,reg`,format`n`t3. �Ѿ��ر������в���Ҫ�ĳ���
Gui, Font
Gui, Add, Radio, x6 y180 w460 h20 cBlue vCKa1 Checked%Ca1%, &1. ����һ��RamOS
Gui, Add, Radio, x6 y230 w460 h20 cBlue vCKa2 Checked%Ca2%, &2. �Ѿ�����RamOSϵͳ�У�������������Ӳ������
Gui, Add, Radio, x6 y280 w350 h20 cBlue vCKa3, &3. ʹ�ù��������һЩ����
Gui, Add, Text, x36 y200 w430 h20 , �������֣���Ҫ����һ��RamOS�������Ǹ���������(����һ����)
Gui, Add, Text, x36 y250 w430 h20 , �Ѿ��ɹ�����RamOS���ˣ����ǳ��ַ�����Ӳ������
Gui, Add, Text, x36 y300 w320 h20 , �����ֹ����һЩ�����������ȱ��ݵ�
Gui, Add, Button, x366 y280 w100 h40 gChooseStep vStep1, ��һ��(&N)

Gui, Tab, 2
Gui, Font, s12
Gui, Add, Text, x6 y30 w460 h140 +border cGreen, `n�������β������ܻᵼ������(FiraDisk)`n`n������ȷ�������һ��֮ǰ�Ѿ����ݺ�ϵͳ
Gui, Font
Gui, Add, CheckBox, x6 y180 w320 h20 cBlue vCKb1 +Checked, &1. ��װ/ж��FiraDisk����
Gui, Add, Text, x36 y200 w320 h20 , ������������RamOS�Ĺؼ�(���ƿ�ʹ��΢������)
Gui, Add, Button, x366 y180 w100 h40 gChooseStep vUninstallDrivers, ж������(����)

Gui, Add, CheckBox, x6 y230 w460 h20 cBlue vCKb2 +Checked, &2. ��װ/ж�� ImDisk
Gui, Add, Text, x36 y250 w430 h20 , �ù��߿���������img�����ļ������ܺܶ࣬�����������˽�
Gui, Add, CheckBox, x6 y280 w350 h20 cBlue vCKb3 +Checked, &3. ����grldr���޸�boot.ini
Gui, Add, Text, x36 y300 w320 h20 , ���grub4dos������ʹGrub4Dos����Img�����ļ�
Gui, Add, Button, x366 y280 w100 h40 gChooseStep vStep2, ��һ��(&N)

Gui, Tab, 3
Gui, Font, s12
Gui, Add, Text, x6 y30 w460 h140 border cGreen, `n������Ҫ: ��Ҫ���˹�ȷ�������ļ��Ĵ�С`n`n�������㷽��: C�����ÿռ��3/4�������ļ���С���ô����ڴ��С`n����������ȷ��ϵͳ��ΪC����A��B��
Gui, Font
Gui, Add, Edit, x196 y180 w50 h20 cRed vImgSizeA, 600
Gui, Add, CheckBox, x6 y180 w190 h20 cBlue vCKc1 +Checked, &1. �������񲢹���  ��С(M):
Gui, Add, Text, x36 y200 w430 h20 , ���������ļ�:D:\RamOS.img �����ص� A:����ʽ��Ϊ:NTFS��ѹ��
Gui, Add, CheckBox, x6 y230 w460 h20 cBlue vCKc2 +Checked, 2. �ȱ���
Gui, Add, Text, x36 y250 w320 h20 , ��C:\�������ļ����Ƶ�A:\  (�����ֹ���PE�¸���)
Gui, Add, CheckBox, x6 y280 w350 h20 cBlue vCKc3 +Checked, 3. ��RamOS�е�ʵ��C���̷��޸�ΪB��
Gui, Add, Text, x36 y300 w430 h20 , Ŀ��: ����RamOS��ԭC�̱�ΪB�̣���C��Ϊ�ڴ�ϵͳ��AΪ���ؾ���Ԥ���̷�
Gui, Add, Button, x366 y260 w100 h30 gChooseStep vStep3, ���һ��(&N)
	Gui, Add, Progress, +Hidden cGreen x0 y320 w477 h10 vJinDu, 0


Gui, Tab, 4
Gui, Font, s12
Gui, Add, Text, x6 y30 w460 h140 border cGreen, ��ȷ��:`n����1. ȷ���Ѿ�����RamOS`n����2. ���ַ�����Ӳ����Ϣ���ڳ�������Ҫ��ʱѡ���`n����3. �Ѿ��رղ���Ҫ�ĳ���
Gui, Font
Gui, Add, CheckBox, x6 y180 w460 h20 cBlue vCKd1 +Checked , &1. reg�����system�ļ�(�����´���������Ȼ����������Ӳ��)
Gui, Add, Text, x36 y200 w430 h20 , ���ݵ�ǰϵͳsystem�ļ���A(system�ļ�����������Ӳ�����ע������)
Gui, Add, CheckBox, x6 y230 w460 h20 cBlue vCKd2 +Checked , &2. ɾ�������ע�����C:
Gui, Add, Text, x36 y250 w430 h20 , ɾ��SYSTEMR\MountedDevices�¶����\DosDevices\C:��
;Gui, Add, CheckBox, x6 y280 w460 h20 cBlue vCKd3 +Checked , &3.
;Gui, Add, Text, x36 y300 w430 h20 , Text
Gui, Add, Button, x366 y280 w100 h40 gChooseStep vStep4, ִ��(&N)

Gui, Tab, 5
Gui, Font, s10
Gui, Add, Edit, x6 y30 w460 h100 cGreen +readonly, ľʲô��˵�ģ��ð��ҷ�һЩ��Ϣ:`n`n��������: ������֮��  QQ:308639546`n������ַ: http://linpinger.github.io`n`n����OlSoul�ĵ���ҳ: http://go.olsoul.com����QȺ:3754982
Gui, Font
/*
Gui, Add, GroupBox, x6 y140 w330 h80 cBlue, ����:
Gui, Add, ComboBox, x16 y160 w120 h20 choose1, D:\RamOS.img
Gui, Add, Edit, x16 y190 w50 h20 , 600
Gui, Add, Button, x66 y190 w70 h20 , ����(&C)
Gui, Add, Button, x146 y160 w100 h20 , ���ص�(&M)>>
Gui, Add, Button, x146 y190 w100 h20 , ж��(&U)
Gui, Add, ComboBox, x256 y160 w70 h20 choose1, A:
Gui, Add, Button, x256 y190 w70 h20 , ��ʽ��

Gui, Add, GroupBox, x346 y140 w120 h80 cBlue, �ȱ���
Gui, Add, Button, x356 y160 w100 h20 , �����ȱ���
Gui, Add, Button, x356 y190 w100 h20 , reg�ȱ���

Gui, Add, GroupBox, x6 y240 w220 h80 cBlue, ���ؼ�ж�ؾ����е����õ�Ԫ
Gui, Add, ComboBox, x16 y260 w90 h20 R10 choose1, system|software
Gui, Add, Button, x16 y290 w90 h20 , ��ע���
Gui, Add, Button, x116 y260 w100 h20 , �������õ�Ԫ
Gui, Add, Button, x116 y290 w100 h20 , ж�����õ�Ԫ

Gui, Add, GroupBox, x236 y240 w230 h80 cBlue, ʹ��reg�����ע����ļ�
Gui, Add, ComboBox, x246 y260 w210 h20 R10 choose1, ����ע���|system|software
Gui, Add, Button, x246 y290 w210 h20 , ������C:\
*/

; Generated using SmartGUI Creator 4.0
Gui, Add, StatusBar, , ������֮�� ��RamOS�����򵼣���ӭʹ�ã�������ֻҪһֱ����һ��
Gui, Show, w477 h347, FoxRamOS ������ �汾: %VerDate%
Return

ChooseStep:
	Gui, Submit, nohide
	if ( A_GuiControl = "Step1" ) {
		if ( CKa1 = 1 ) {
			WarnString := envcheck()
			if ( WarnString != "" ) {
				msgbox, 8484, ϵͳ�������, ��⵽���¿���Ӱ������������:`n`n%WarnString%`n�Ƿ����������
				ifmsgbox, no
					return
			}

			Guicontrol, Choose, FoxTab, 2
			SB_SetText("1 / 2: �����һ����ʼ׼����װFiraDisk, ImDisk, Grub4Dos")
		}
		if ( CKa2 = 1 ) {
			Guicontrol, Choose, FoxTab, 4
		}
		if ( CKa3 = 1 ) {
			Guicontrol, Choose, FoxTab, 5
		}
	}
	if ( A_GuiControl = "Step2" ) {
		if ( CKb1 = 1 ) {
			SB_SetText("��ʼ��װ: FiraDisk����...")
			SB_SetText(InstallFiraDisk("install"))
		}
		if ( CKb2 = 1 ) {
			SB_SetText("��ʼ��װ: Imdisk...")
			SB_SetText(InstallimDisk())
		}
		if ( CKb3 = 1 ) {
			SB_SetText("��ʼ����: Grub4Dos...")
			SB_SetText(InstallGrub4Dos(Drive_SysNow))
		}
		Guicontrol, Choose, FoxTab, 3
		SB_SetText("2 / 2: �����һ����ʼ��������")
	}
	if ( A_GuiControl = "Step3" ) {
		if ( CKc1 = 1 ) {
			SB_SetText("�������ɴ�СΪ " . ImgSizeA . "M �ľ����ļ�: " . ImgPath)
			CreateBlankFile(ImgPath, ImgSizeA * 1024 * 1024)
			SB_SetText("���ڹ��ؾ����ļ�: " . ImgPath . " ��: " . Drive_MountImg)
			mountImg(ImgPath, Drive_MountImg) ; �����������
			SB_SetText("���ڸ�ʽ�� " . Drive_MountImg . " ��С: " . ImgSizeA . " ����:NTFS ����:ѹ��")
			runwait, cmd /c format %Drive_MountImg% /FS:NTFS /V:FoxRamOS /Q /C /Y, , Hide
		}
		if ( CKc2 = 1 ) {
			SB_SetText("�ȱ�����...")
			CopyVolume(Drive_SysNow, Drive_MountImg) ; �����ݸ���: ʹ��ǿ�Ƹ���
			IniDelete, %Drive_MountImg%\boot.ini, operating systems, %Drive_SysNow%\grldr
;			SB_SetText("�ȱ������")
		}
		if ( CKc3 = 1 ) {
			SB_SetText("�޸��̷���...")
			IfNotExist, %Drive_MountImg%\WINDOWS\system32\config\system
			{
				sb_setText("����system���õ�Ԫ�����ڣ����ȹ���")
				return
			}
			sb_setText("������: HKLM\systemR")
			runwait, REG LOAD HKLM\systemR %Drive_MountImg%\WINDOWS\system32\config\system, , Hide
			sb_setText("�������: HKLM\systemR")

		; ʵ������Ϣ->�޸�->ӳ��ע���
		RegRead, TrueValue, HKLM, SYSTEM\MountedDevices, \DosDevices\%Drive_SysNow%
		RegDelete, HKLM, systemR\MountedDevices, \DosDevices\%Drive_SysNow%
		RegWrite, REG_BINARY, HKLM, systemR\MountedDevices, \DosDevices\%Drive_SysInRam%, %TrueValue%

		RegWrite, REG_SZ, HKCU,Software\Microsoft\Windows\CurrentVersion\Applets\Regedit, LastKey, �ҵĵ���\HKEY_LOCAL_MACHINE\SYSTEMR\MountedDevices
;		run, regedit

			sb_setText("ж����: HKLM\systemR")
			runwait, REG UnLOAD HKLM\systemR, , Hide
			sb_setText("ж�����: HKLM\systemR")
		}
		SB_SetText("RamOS�����ɹ�, �����������������, ѡ����ĿRamOS��Ȼ��Ϳ��Խ�����")
		msgbox,8516, ����ȷ��, RamOS�����ɹ�`n�����������������`,ѡ����ĿRamOS��Ȼ��Ϳ��Խ�����`n`n���Ҫ������
		; 324
		ifmsgbox, yes
			shutdown, 2

	}
	if ( A_GuiControl = "Step4" ) {
		if ( CKd1 = 1 ) {
			SB_SetText("���ڹ��ؾ����ļ�: " . ImgPath . " ��: " . Drive_MountImg)
			mountImg(ImgPath, Drive_MountImg) ; �����������
			FileDelete, %Drive_MountImg%\WINDOWS\SYSTEM32\config\system
			runwait, Reg SAVE HKLM\SYSTEM %Drive_MountImg%\WINDOWS\SYSTEM32\config\system, , Hide
			SB_SetText("���: reg����system")
		}
		if ( CKd2 = 1 ) {
			sb_setText("������: HKLM\systemR")
			runwait, REG LOAD HKLM\systemR %Drive_MountImg%\WINDOWS\system32\config\system, , Hide
			sb_setText("�������: HKLM\systemR")

			RegDelete, HKLM, systemR\MountedDevices, \DosDevices\%Drive_SysNow%

			sb_setText("ж����: HKLM\systemR")
			runwait, REG UnLOAD HKLM\systemR, , Hide
			sb_setText("ж�����: HKLM\systemR")
			SB_SetText("���: ɾ��ע�����" . Drive_SysNow)
		}
	}
	if ( A_GuiControl = "UninstallDrivers" ) {
		WarnStringUn := ""
		DriveGet, NowDriveListUn, List ; ��ȡ��ǰ�̷��б���B��˵��������RamOS
		if instr(NowDriveListUn, "B")
			WarnStringUn .= "����: ��ǰϵͳ����B�̣������ܴ���RamOSϵͳ�У����������ϵͳ`n"
		if instr(NowDriveListUn, "A")
			WarnStringUn .= "����: ��ǰϵͳ����A�̣��������ѹ��ؾ����ļ���A�̣�����A�����Ҽ�ж��Imdisk������`n"

		if ( CKb2 = 1 )
			IfNotExist, %A_windir%\INF\imdisk.inf
				WarnStringUn .= "����: δ��⵽ ImDisk �� inf �ļ�������û�а�װImDisk`n"

		if ( WarnStringUn != "" ) {
			msgbox, 8484, ϵͳ�������, ��⵽���¿���Ӱ��ж�ص�����:`n`n%WarnStringUn%`n�Ƿ����ж�أ�
			ifmsgbox, no
				return
		}
		if ( CKb1 = 1 )
			SB_SetText(InstallFiraDisk("Uninstall"))
		if ( CKb2 = 1 )
			SB_SetText(InstallimDisk("Uninstall"))
		if ( CKb3 = 1 )
			SB_SetText(InstallGrub4Dos(Drive_SysNow,"Uninstall"))
		SB_SetText("��ʾ: ж���������")
	}
return

GuiClose:
	ExitApp
return

; -----��ע:
^esc::reload
+esc::Edit
!esc::ExitApp

EnvCheck() {  ; ���ϵͳ����
	; ϵͳ����,�������б�,���������б�,����img��С��������װ״�����
	WarnString := ""
	; -----
	if ( A_OSVersion != "WIN_XP" )
		WarnString .= "����: ��ǰϵͳ ����XP,���ܱ�֤�ܷ�ɹ�`n"
	; -----
	DriveGet, NowDriveList, List
	if instr(NowDriveList, "A")
		WarnString .= "����: ��ǰϵͳ �����̷�A�������������ж��A`n"
	StringLeft, SysDLa, A_windir,1
	IfExist, %SysDLa%:\pagefile.sys
		WarnString .= "����: ��ǰϵͳ ���� pagefile.sys������������ڴ�`n"
	; ----- cmd format reg sc
	IfNotExist, %A_windir%\system32\cmd.exe
		WarnString .= "����: ��ǰϵͳ ������ cmd.exe`n"
	IfNotExist, %A_windir%\system32\format.com
		WarnString .= "����: ��ǰϵͳ ������ format.com`n"
	IfNotExist, %A_windir%\system32\reg.exe
		WarnString .= "����: ��ǰϵͳ ������ reg.exe`n"
	IfNotExist, %A_windir%\system32\sc.exe
		WarnString .= "����: ��ǰϵͳ ������ sc.exe`n"
	; ----- ����img��С
	SysMemSize := GetSysMemSize()  ; �����ڴ��� M
	StringLeft, SysDL, A_windir,3
	DriveGet, Size_All, Capacity, %SysDL%
	DriveSpaceFree, Size_Free, %SysDL%
	PageFileSize := 0
	IfExist, %SysDL%pagefile.sys
		FileGetSize, PageFileSize, %SysDLa%pagefile.sys, M
	Size_Used := round( ( Size_All - Size_Free - PageFileSize ) * 3 / 4) ; Ԥ�������С=3/4 * ���ô�С
	If ( ( SysMemSize - Size_Used ) < 200 ) { ; ���뾵���ϵͳ�����ڴ����200M����ϵͳ����
		WarnString .= "����: " . SysDL . "�̹����ڴ�С��Ԥ��Img��С.  �ڴ�:" . SysMemSize . "  Ԥ��Img:" . Size_Used . "�����Сϵͳ�����`n"
;		SB_SetText(SysDL . "�̹���  Ԥ��ѹ������: " . Size_Used " M  �����ڴ�: " . SysMemSize . " M" )
		Guicontrol, Text, ImgSizeA, 0
	} else {
;		SB_SetText("Ԥ��ѹ������: " . Size_Used " M  �����ڴ�: " . SysMemSize . " M" )
		Guicontrol, Text, ImgSizeA, %Size_Used%
	}
	; ----- �������
	return, WarnString
}

TestExePath(PathList="c:\a.exe,d:\b.exe")
{
	loop, parse, PathList, `,, %A_space%
		IfExist, %A_loopfield%
			return, A_loopfield
}

InstallFiraDisk(Action="install") ; ��װFiraDisk����
{
	SrcDir := A_scriptdir . "\FoxRamOS"
	DevConP := TestExePath("D:\bin\bin32\devcon.exe," . SrcDir . "\devcon.exe,C:\bin\bin32\devcon.exe")

	If ( Action = "Uninstall" ) {
		RunWait, "%DevConP%" remove root\firadisk, %SrcDir%, Hide
		return, "FiraDisk ж�����"
	}
	If ( Action = "install" ) {
		IfExist, %A_windir%\system32\drivers\firadisk.sys
		{
			msgbox, 8484, ȷ��, �Ѽ�⵽FiraDisk.sys���Ƿ�ǿ�ư�װ��
			Ifmsgbox, no
				return, "ò���Ѿ���װ��FiraDisk"
		}
		RunWait, "%DevConP%" install "%SrcDir%\FiraDisk\firadisk.INF" root\firadisk, %SrcDir%, Hide
;		runwait rundll32.exe setupapi`,InstallHinfSection DefaultInstall 132 %A_ScriptDir%\firadisk.inf
		return, "FiraDisk ��װ���"
	}
}

InstallimDisk(Action="install") ; ��װimDisk
{
	If ( Action = "Uninstall" ) {
		IfExist, %A_windir%\INF\imdisk.inf
		{
			runwait, rundll32.exe setupapi.dll`,InstallHinfSection DefaultUninstall 132 %A_windir%\INF\imdisk.inf
			return, "ж�����: imDisk"
		} else
			return, "����: δ��⵽ imDisk �� inf �ļ�"
	}

	SrcDir := A_scriptdir . "\FoxRamOS\imDisk"
	IfExist, %A_windir%\system32\drivers\imdisk.sys
	{
		msgbox, 8484, ȷ��, �Ѽ�⵽imdisk.sys���Ƿ�ǿ�ư�װ��
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

InstallGrub4Dos(TarDrive="C:", Action="install") ; ��װ Grub4Dos
{
	If ( Action = "Uninstall" ) {
		FileSetAttrib, -R, %TarDrive%\boot.ini
		IniDelete, %TarDrive%\boot.ini, operating systems, %TarDrive%\grldr
		FileDelete, %TarDrive%\grldr
		FileDelete, %TarDrive%\menu.lst
		return, "ж�����: Grub4Dos"
	}

	SrcDir := TestExePath("D:\bin\img," . A_scriptdir . "\FoxRamOS\Grub4Dos")
	FileCopy, %SrcDir%\grldr, %TarDrive%\grldr, 1
	FileCopy, %SrcDir%\menu.lst, %TarDrive%\menu.lst, 1

	FileSetAttrib, -R, %TarDrive%\boot.ini
	IniWrite, 5, %TarDrive%\boot.ini, boot loader, timeout
	IniWrite, "FoxRamOS", %TarDrive%\boot.ini, operating systems, %TarDrive%\grldr
	return, "Grub4Dos�Ѳ��õ�: " . TarDrive
}


CreateBlankFile(FilePath="D:\RamOS.img", Size=629145600) ; �������ļ�
{
	IfExist, %FilePath%
		FileMove, %FilePath%, %FilePath%.old, 1
	If ( ( hFile:=DllCall("CreateFile", Str,FilePath, UInt,0x80000000|0x40000000, UInt,0x1|0x2, UInt,0, UInt,1, UInt,0, UInt,0) ) < 0 )
		Return -1
	If DllCall( "SetFilePointerEx", UInt,hFile, Int64,Size, Int64P,nPtr, UInt,0 ) = 0
		Return (DllCall( "CloseHandle", UInt,hFile )+null) "-2"
	If DllCall( "SetEndOfFile", UInt,hFile ) = 0
		Return (DllCall( "CloseHandle", UInt,hFile )+null) "-3"
	Return (DllCall( "CloseHandle", UInt,hFile )+null) "1"
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
	:\grldr
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
		sb_setText("����: " . NowCount . " / " . FileCount . " : " . A_LoopFileFullPath)
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
	SB_settext("�ȱ��ݽ���!  �ļ���: " . FileCount)
}

GetSysMemSize()  ; ��ȡ�����ڴ�����(M)
{
	VarSetCapacity(MEMORYSTATUSEX,64,0) , NumPut(64,MEMORYSTATUSEX) 
	DllCall("GlobalMemoryStatusEx", UInt,&MEMORYSTATUSEX) 
	PhysMemSizeB := NumGet(MEMORYSTATUSEX,8,"Int64")
	return, Round(PhysMemSizeB/1024/1024)
}

