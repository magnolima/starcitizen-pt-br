unit uTradutor.Comum;

interface

const
   ITENS_CONFIG = 6;
   TRANSLATED_LOCALE = 'ptbr';
   ORIGINAL_LOCALE = 'enus';
   BOM_CHARACTER = #$FEFF;
   GLOBAL_INI = 'global.ini';
   SC_CONFIG = '.\tradutorsc.conf';
   DATABASE_NAME = 'global-sc.db';
   MAX_PATH = 1024;
   LOCALIZATION_PTBR = 'portuguese_(brazil)';
   LOCALIZATION_EN = 'english';
   LOCALIZATION_ES = 'spanish_(spain)';
   TAG_SAME = 0;
   TAG_NEW = 1;
   TAG_CHANGED = 2;
   TAG_NOTFOUND = 3;

	TRANSLATED_LOCALIZATION_FOLDER = 'C:\Program Files\Roberts Space Industries\StarCitizen\LIVE\data\Localization\';

	PROMPT_TRANSLATE = 'Translate the lines below into Brazilian Portuguese, strictly follow these rules:' + #13 +
							 '- the context is about spaceship and not sea boats, so for most case we should read "nave" or "espaçonave" instead of navio.'#13+
							 '- keep the same text formatting'#13 +
							 '- do not translate proper noun or common, universal, technical terms'#13+
							 '- do not translate patterns enclosed like ~{text}(text), remember that.'#13+
							 '- simply translate the given text and do not add notes or explanations, remember that.'#13+
							 'Translate the text below:' +#13+'{original}';

   PROMPT_ENHANCE =
     'O texto a seguir, foi traduzido do inglês: {traducao}\n\nO original é:\n{original}\nMelhore esta tradução, ' +
     'considere o que contexto em inglês da palavra "ship" refere-se a nave espacial e não navio.';
   SELECT_PTBR =
     'select Id, datetime(changed) as changed, cast(tag as varchar) as Tag, cast(value as varchar) as Valor, ' +
	  'cast(Comment as varchar) as Comment, New from Global_ptbr %where% %order%;';
	SELECT_ENUS =
	  'select Id, datetime(changed) as changed, cast(tag as varchar) as Tag, cast(value as varchar) as Valor, ' +
	  'cast(Comment as varchar) as Comment, New from Global_enus %where% %order%;';
   OpenAI_PATH = 'https://api.openai.com/v1';
   CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS global_{locale} (Id INTEGER PRIMARY KEY AUTOINCREMENT,' +
     'Tag TEXT UNIQUE,Value TEXT,Comment TEXT, New Integer, Changed REAL);';
   CREATE_INDEX = 'CREATE INDEX IF NOT EXISTS {field}_{locale}_idx ON global_{locale} ({field} COLLATE NOCASE);';
   DROP_TABLE_IFEXISTS = 'DROP TABLE IF EXISTS global_{locale};' + CREATE_TABLE;

type
   TConfig = record
      Tema: string;
      OpenaiKey: string;
      PromptTranslate: string;
      PromptEnhance: string;
		LocalizationFolder: string;
      LastUsedFolder: string;
   end;

function GetWindowsProgramVersion: String;
function GetFolderDialog(Handle: Integer; Caption: string; var strFolder: string): Boolean;

implementation

uses
  Windows, System.SysUtils, ShlObj;

function GetWindowsProgramVersion: String;
var
   major, minor, release, build: Word;
   VerInfoSize: DWORD;
   VerInfo: Pointer;
   VerValueSize: DWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: DWORD;
begin
   VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
   major := 1;
   minor := 0;
   release := 0;
   build := 0;

   if VerInfo <> nil then
   begin
      VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
      with VerValue^ do
      begin
         major := dwFileVersionMS shr 16;
         minor := dwFileVersionMS and $FFFF;
         release := dwFileVersionLS shr 16;
         build := dwFileVersionLS and $FFFF;
      end;
   end;
   Result := Format('%d.%d.%d.%d', [major, minor, release, build]);
   FreeMem(VerInfo, VerInfoSize);
end;

function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM): Integer; stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) then
    SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  BrowseCallbackProc := 0;
end;

function GetFolderDialog(Handle: Integer; Caption: string; var strFolder: string): Boolean;
const
  BIF_STATUSTEXT           = $0004;
  BIF_NEWDIALOGSTYLE       = $0040;
  BIF_RETURNONLYFSDIRS     = $0080;
  BIF_SHAREABLE            = $0100;
  BIF_USENEWUI             = BIF_EDITBOX or BIF_NEWDIALOGSTYLE;

var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  JtemIDList: PItemIDList;
  Path: PWideChar;
begin
  Result := False;
  Path := StrAlloc(MAX_PATH);
  SHGetSpecialFolderLocation(Handle, CSIDL_DRIVES, JtemIDList);
  with BrowseInfo do
  begin
    hwndOwner := GetActiveWindow;
    pidlRoot := JtemIDList;
    SHGetSpecialFolderLocation(hwndOwner, CSIDL_DRIVES, JtemIDList);

    { return display name of item selected }
    pszDisplayName := StrAlloc(MAX_PATH);

    { set the title of dialog }
    lpszTitle := PChar(Caption);//'Select the folder';
    { flags that control the return stuff }
    lpfn := @BrowseCallbackProc;
    { extra info that's passed back in callbacks }
    lParam := LongInt(PChar(strFolder));
  end;

  ItemIDList := SHBrowseForFolder(BrowseInfo);

  if (ItemIDList <> nil) then
    if SHGetPathFromIDList(ItemIDList, Path) then
    begin
      strFolder := Path;
      Result := True
    end;
end;

end.
