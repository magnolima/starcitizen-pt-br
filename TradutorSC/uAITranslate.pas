unit uAITranslate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, RegularExpressions, System.IOUtils,
  MLOpenAI.Core, MLOpenAI.ChatGPT, MLOpenAI.Types, MLOpenAI.Completions, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls;

const
  FLastModel = '.\lastmodel.txt';

  // OLLAMA_MODEL = 'llama3.1:8b-instruct-fp16';
  // OLLAMA_MODEL = 'llama3.1:latest';
type
  TForm3 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    Connection: TFDConnection;
    qryOriginal: TFDQuery;
    Panel1: TPanel;
    Memo2: TMemo;
    OllamaModel: TComboBox;
    procedure ConnectionBeforeConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OllamaModelCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDatabaseLocation: string;
    FEngine: TOAIEngine;
    FGPT: TOpenAI;
    FTranslated: boolean;
    FTranslation: String;
    procedure AITranslateIt;
    function InitChatGPT(const AOriginal: string): boolean;
    procedure ConfigurarOpenAI;
    procedure OnOpenAIResponse(Sender: TObject);
    procedure OnOpenAIError(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  uTradutor.Comum;

{$R *.dfm}

function TForm3.InitChatGPT(const AOriginal: string): boolean;
const
  lSystemRole =
    'You are a translator, translate to Brazilian portuguese lines of a space game. Stricly follow what the user asks about the translation';
  lUserPrompt =
    'Translate from English to Brazilian portuguese lines of a space game without adding notes about the translation or you will penalized. Follow all the rules below:'#13
    + '1. Never translate names of person or places.'#13 +
    '2. Universal technical terms must be skipped, do not translate.'#13 +
    '3. Skip translating text enclosured by "~(|)" or similar, like example: ~mission(location|address)'#13 +
    '4. As a space game, the word "ship" should be translated as "nave", as it isn''t a ship'#13 +
    '5. Simply translate, do not add notes about the translation or you will not be helpful, and you want to be useful Translate this: '#13;
begin
  // ~\w+\([^)]+\)
  ConfigurarOpenAI();
  FGPT.UseOllama := true;
  FGPT.Chat.ClearMessages;
  FGPT.Chat.AddMessage(lSystemRole, TMessageRole.mrSystem);
  FGPT.Chat.AddMessage(lUserPrompt + AOriginal, TMessageRole.mrUser);
  FGPT.RequestType := orChat;
  FGPT.Endpoint := OLLAMA_API;
  FGPT.Chat.MaxTokens := 4096;
  FGPT.Chat.TopP := 0;
  FGPT.Chat.PresencePenalty := 1;
  FGPT.Chat.FrequencyPenalty := 1;
  FGPT.Chat.Temperature := 0.2;
end;

procedure TForm3.AITranslateIt;
begin

  tthread.CreateAnonymousThread(
    procedure
    var
      i: integer;
    begin

      i := 0;

      while not qryOriginal.Eof do
      begin
{
        tthread.Synchronize(nil,
          procedure
          begin
            inc(i);
            Memo2.Lines.Clear;
            Memo2.Lines.Add(i.ToString+' '+
              qryOriginal.FieldByName('tag').AsString + '= ' + qryOriginal.FieldByName('value').AsString);
          end);
}
        InitChatGPT(qryOriginal.FieldByName('value').AsString);

        try
          if Self.Tag = 1 then
            exit;
          tthread.Synchronize(nil,
            procedure
            begin
            inc(i);
              Memo2.Lines.Add(timetostr(now) + '> translating '+i.ToString+#13+qryOriginal.FieldByName('value').AsString);
            end);
          FGPT.Execute;
        except
          on e: Exception do
          begin

            Memo1.Lines.Add(e.Message);
            exit;
          end;
        end;

        if FTranslated then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              Memo1.Lines.Add(FTranslation);
              Memo1.Lines.Add(StringOfChar('-', 80));
            end);
          FTranslation := '';
          FTranslated := false;

          qryOriginal.Next;

        end;
      end;

    end).Start;
end;

procedure TForm3.OnOpenAIResponse(Sender: TObject);
var
  Text, Lines: String;
  responses: TArray<String>;
  i: Integer;
begin
  responses := FGPT.GetChatResult;
  Lines := '';
  for Text in responses do
  begin
    Lines := Text + Lines;

  end;
  FTranslated := true;
  FTranslation := Lines;
end;

procedure TForm3.ConfigurarOpenAI;
begin
  // FGPT := TOpenAI.Create('llama3');
  // FGPT.Endpoint := OpenAI_PATH;
  // FGPT.APIKey := 'llama';
  // FGPT.OnResponse := OnOpenAIResponse;
  // FGPT.OnError := OnOpenAIError;

  FGPT := TOpenAI.Create();
  //
  FGPT.UseOllama := true;
  FGPT.OllamaModel := OllamaModel.Text;

  FGPT.APIKey := 'ollama';
  FGPT.OnResponse := OnOpenAIResponse;
  FGPT.RequestType := TOAIRequests.orChat;
  FGPT.OnError := OnOpenAIError;
end;

procedure TForm3.OllamaModelCloseUp(Sender: TObject);
begin
  TFile.WriteAllText(FLastModel, OllamaModel.ItemIndex.ToString);
end;

procedure TForm3.OnOpenAIError(Sender: TObject);
begin
  if (FGPT.StatusCode = 400) and (FGPT.RequestType = TOAIRequests.orImages) then
  begin
    Memo1.Lines.Add('Prompt inválido!');
    exit;
  end;

  Memo1.Lines.Add('Error ' + FGPT.StatusCode.ToString + ' - ' + FGPT.ErrorMessage);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  qryOriginal.Open(
  // 'select g.id,g.id, g.tag,g.value,t.value from global_enus g '+
  'select g.tag,g.value from global_enus g ' + 'left join global_ptbr t on t.tag=g.tag ' + 'where g.value <> "" and ' +
    'length(g.value)>50 and ' + 'g.tag not like "%Human_%" and ' + 'g.tag not like "%chat_%" and ' +
    'g.value = t.value ' + 'limit 30;');
  AITranslateIt();

end;

procedure TForm3.ConnectionBeforeConnect(Sender: TObject);
begin
  Connection.Params.database := FDatabaseLocation + DATABASE_NAME;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.Tag := 1;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FDatabaseLocation := ExtractFilePath(ParamStr(0)) + 'db' + TPath.DirectorySeparatorChar;

end;

procedure TForm3.FormShow(Sender: TObject);
begin

  if FileExists(FLastModel) then
  begin
    var
    idx := StrToIntDef(TFile.ReadAllText(FLastModel), 0);
    OllamaModel.ItemIndex := idx;
  end;

end;

end.
