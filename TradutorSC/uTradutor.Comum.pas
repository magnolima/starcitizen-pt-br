unit uTradutor.Comum;

interface

const
   ITENS_CONFIG = 4;
   DEFAULT_LOCALE = 'ptbr';
   ORIGINAL_LOCALE = 'enus';
   BOM_CHARACTER = #$FEFF;
   SC_CONFIG = '.\tradutorsc.conf';
   DATABASE_NAME = 'global-sc.db';
   PROMPT_TRANSLATE =
     'Traduza para Portugu�s Brasileiro o texto abaixo, ignore termos universais comuns do ingl�s como termos ' +
     't�cnicos. O contexto da palavra inglesa "ship" normalmente se refere a nave espacial e n�o navio:\n{original}';
   PROMPT_ENHANCE =
     'O texto a seguir, foi traduzido do ingl�s: {traducao}\n\nO original �:\n{original}\nMelhore esta tradu��o, ' +
     'considere o que contexto em ingl�s da palavra "ship" refere-se a nave espacial e n�o navio.';
   SELECT_PTBR =
     'select Id, datetime(changed) as changed, cast(tag as varchar) as Tag, cast(value as varchar) as Valor, ' +
     'cast(Comment as varchar) as Comment, New from Global_ptbr %where% order by tag;';
   SELECT_ENUS =
     'select Id, datetime(changed) as changed, cast(tag as varchar) as Tag, cast(value as varchar) as Valor, ' +
     'cast(Comment as varchar) as Comment, New from Global_enus %where% order by tag;';
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
   end;

function GetWindowsProgramVersion: String;

implementation

uses
  Windows, System.SysUtils;

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

end.
