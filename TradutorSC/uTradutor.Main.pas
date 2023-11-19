(*

  (C)reated by Magno Lima 2023 :: Made by Community of Star Citizen
  (https://github.com/magnolima/starcitizen-pt-br)

  *** https://robertsspaceindustries.com ***

  Dependences:
  - Skia4Delphi: https://github.com/skia4delphi/skia4delphi
  - VCL LockBox with BlowFish: Install using Getit
  - MLOpenAI: https://github.com/magnolima/OpenAI-Delphi

  You should also install or remove (if you would like to) the theme styles

*)
unit uTradutor.Main;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
   FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
   FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
   FireDAC.Phys.SQLiteDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
   FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLite, System.ImageList, Vcl.ImgList,
   Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.Themes, Vcl.Styles,
   Vcl.DBCtrls, System.IOUtils, System.Skia, Vcl.Skia, Vcl.ComCtrls, MLOpenAI.Core, MLOpenAI.ChatGPT,
   MLOpenAI.Types, MLOpenAI.Completions, LbCipher, LbClass, uTradutor.Comum;

const
   clVerde = $0080FF80;

type
   TEdit = class(Vcl.StdCtrls.TEdit)
   private
      FIsPasting: Boolean;
      procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
      procedure WMPaste(var Message: TMessage); message WM_PASTE;
   end;

type
   TfrmTradutorSC = class(TForm)
      Connection: TFDConnection;
      FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
      qryTraducao: TFDQuery;
      MainMenu1: TMainMenu;
      Arquivo1: TMenuItem;
      ImportarGlobalini1: TMenuItem;
      ExportarGlobalini1: TMenuItem;
      N1: TMenuItem;
      Sair1: TMenuItem;
      Sobre1: TMenuItem;
      Panel1: TPanel;
      Panel2: TPanel;
      Panel3: TPanel;
      Edit1: TEdit;
      btnFiltrar: TButton;
      dgTraducao: TDBGrid;
      ImageList1: TImageList;
      DBNavigator1: TDBNavigator;
      DataSource1: TDataSource;
      OpenDialog1: TOpenDialog;
      Label1: TLabel;
      SkAnimatedImage1: TSkAnimatedImage;
      btnInterromper: TButton;
      cbProcurarTag: TCheckBox;
      qryTraducaoId: TFDAutoIncField;
      qryTraducaoTag: TWideStringField;
      qryTraducaoValor: TWideStringField;
      qryTraducaochanged: TWideStringField;
      ImportarGlobaliniparabaseIngls1: TMenuItem;
      PageControl1: TPageControl;
      TabSheet1: TTabSheet;
      TabSheet2: TTabSheet;
      dgOriginal: TDBGrid;
      DataSource2: TDataSource;
      qryOriginal: TFDQuery;
      FDAutoIncField1: TFDAutoIncField;
      WideStringField1: TWideStringField;
      WideStringField2: TWideStringField;
      WideStringField3: TWideStringField;
      Panel4: TPanel;
      mmTraducao: TMemo;
      Label2: TLabel;
      btAtualizar: TButton;
      btnCancelar: TButton;
      sbTraduzir: TSpeedButton;
      mmOriginal: TMemo;
      Splitter1: TSplitter;
      ObtenhasuachaveDeepLTranslate1: TMenuItem;
      cbSincronizar: TCheckBox;
      sbLimparFiltro: TSpeedButton;
      MenuTema1: TMenuItem;
      btnUsarTraducao: TButton;
      SaveDialog1: TSaveDialog;
      N4: TMenuItem;
      N5: TMenuItem;
      Label3: TLabel;
      cbMelhorar: TCheckBox;
      PopupMenu1: TPopupMenu;
      Atualizartodasocorrncias1: TMenuItem;
      Importartudo1: TMenuItem;
      Importarapenasnovastags1: TMenuItem;
      Importartudo2: TMenuItem;
      Importarapenasnovastags2: TMenuItem;
      qryOriginalComment: TWideStringField;
      qryOriginalNew: TIntegerField;
      Editar1: TMenuItem;
      EditarpromptChatGPT1: TMenuItem;
      cbMostrarNovasTags: TCheckBox;
      qryTraducaoComment: TWideStringField;
      qryTraducaoNew: TIntegerField;
      sbImportarNovasTags: TSpeedButton;
      Panel5: TPanel;
      CompararTags1: TMenuItem;
      Label4: TLabel;
      LocalizaoStarCitizen1: TMenuItem;
      ImplantarTraduo1: TMenuItem;
      procedure btnInterromperClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure sbTraduzirClick(Sender: TObject);
      procedure Splitter1Moved(Sender: TObject);
      procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
      procedure PageControl1Change(Sender: TObject);
      procedure Sobre1Click(Sender: TObject);
      procedure btnFiltrarClick(Sender: TObject);
      procedure Edit1Change(Sender: TObject);
      procedure sbLimparFiltroClick(Sender: TObject);
      procedure Sair1Click(Sender: TObject);
      procedure ObtenhasuachaveDeepLTranslate1Click(Sender: TObject);
      procedure ExportarGlobalini1Click(Sender: TObject);
      procedure mmTraducaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure ConnectionBeforeConnect(Sender: TObject);
      procedure btnUsarTraducaoClick(Sender: TObject);
      procedure btnCancelarClick(Sender: TObject);
      procedure btAtualizarClick(Sender: TObject);
      procedure Atualizartodasocorrncias1Click(Sender: TObject);
      procedure Importartudo1Click(Sender: TObject);
      procedure Importarapenasnovastags1Click(Sender: TObject);
      procedure qryTraducaoAfterScroll(DataSet: TDataSet);
      procedure qryOriginalAfterScroll(DataSet: TDataSet);
      procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
      procedure EditarpromptChatGPT1Click(Sender: TObject);
      procedure cbMostrarNovasTagsClick(Sender: TObject);
      procedure dgTraducaoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
        State: TGridDrawState);
      procedure sbImportarNovasTagsClick(Sender: TObject);
      procedure CompararTags1Click(Sender: TObject);
      procedure LocalizaoStarCitizen1Click(Sender: TObject);
      procedure ImplantarTraduo1Click(Sender: TObject);
   private
      FEngine: TOAIEngine;
      FChatGPT: TOpenAI;
      FDatabaseLocation: String;
      FTmpDatabase: String;
      FTextUndo: String;
      procedure ImportarGlobal(const Filename: string; const AIsOriginalBase: Boolean = false);
      procedure CreateTempTable(const ADatabase, ALocale: string);
      procedure ProcessarGlobalIni(const Filename, ALocale: string; const ATagsOnly: Boolean);
      function InserirLinha(var AQuery: TFDQuery; const ATag, AValue: string; const ANew: Boolean = false): Boolean;
      procedure CreateTables(AQuery: TFDQuery; const ALocale: string);
      procedure OnOpenAIResponse(Sender: TObject);
      procedure OnOpenAIError(Sender: TObject);
      function InitChatGPT(const ATraducao, AOriginal: string): Boolean;
      procedure Procurar;
      procedure Filtro(const AFiltro: string);
      procedure AdicionarTemas(const ATemaDefault: string);
      procedure SelecionarTema(Sender: TObject);
      procedure Aplicartema(const ATema: string);
      procedure ConfigurarOpenAI;
      procedure ExportarGlobal(const Filename: string);
      procedure AtualizarDatabase(const id: Integer; const ATag, AValor, AOldValor: string);
      procedure ErroImportacao(const ErrorMessage: string);
      procedure ImportacaoConcluida;
      procedure AbrirTabelas;
      procedure SetPaineis(AEnabled: Boolean);
      procedure GetTraducao(const ADatasource: TDataSource);
      procedure AtualizarTraducao;
      function NewTag(var AQuery: TFDQuery; ATag: string): Boolean;
      procedure SelecionarDiretorioSC;
      { Private declarations }
   public
      { Public declarations }
   end;

var
   frmTradutorSC: TfrmTradutorSC;
   KeyTag: String;
   TradutorConfig: TConfig;

implementation

{$R *.dfm}

uses
   FileCtrl, Clipbrd, uTradutor.Novatag, uTradutor.Sobre, uTradutor.CompararTags;

procedure TEdit.CNCommand(var Message: TWMCommand);
begin
   inherited;
   // if (Message.NotifyCode = EN_MAXTEXT) and FIsPasting then
   // ShowMessage('Too much text!');
end;

procedure TEdit.WMPaste(var Message: TMessage);
begin
   FIsPasting := True;
   try
      inherited;
   finally
      FIsPasting := false;
   end;
end;

function EncodeString(Const Text: string): string;
var
   LbBlowfish: TLbBlowfish;
begin
   try
      LbBlowfish := TLbBlowfish.Create(nil);
      Result := LbBlowfish.EncryptString(Text);
   finally
      LbBlowfish.Free;
   end;
end;

function DecodeString(Const Text: string): string;
var
   LbBlowfish: TLbBlowfish;
begin
   try
      LbBlowfish := TLbBlowfish.Create(nil);
      Result := LbBlowfish.DecryptString(Text);
   finally
      LbBlowfish.Free;
   end;
end;

procedure SalvarConfiguracao;
var
   configuracao: TArray<string>;
begin
   SetLength(configuracao, ITENS_CONFIG);
   configuracao[0] := 'tema:' + TradutorConfig.Tema;
   configuracao[1] := 'openai_key:' + EncodeString(TradutorConfig.OpenaiKey);
   configuracao[2] := 'prompt-translate:' + StringReplace(TradutorConfig.PromptTranslate, #13, '\n', [rfReplaceAll]);
   configuracao[3] := 'prompt-enhance:' + StringReplace(TradutorConfig.PromptEnhance, #13, '\n', [rfReplaceAll]);
   configuracao[4] := 'localization-folder:' + TradutorConfig.LocalizationFolder;
   TFile.WriteAllLines(SC_CONFIG, configuracao, TEncoding.UTF8);
end;

procedure CarregarConfiguracao;
var
   configuracao: TArray<string>;
   item, value: string;
begin

   if FileExists(SC_CONFIG) then
   begin
      SetLength(configuracao, ITENS_CONFIG);
      configuracao := TFile.ReadAllLines(SC_CONFIG, TEncoding.UTF8);
      for item in configuracao do
      begin
         value := Copy(item, Pos(':', item) + 1);
         if item.Contains('tema:') then
            TradutorConfig.Tema := value;
         if item.Contains('openai_key:') then
         begin
            if not value.IsEmpty then
            begin
               value := DecodeString(value);
               TradutorConfig.OpenaiKey := value;
            end;
         end;
         if item.Contains('prompt-translate') then
            TradutorConfig.PromptTranslate := value;
         if item.Contains('prompt-enhance') then
            TradutorConfig.PromptEnhance := value;
         if item.Contains('localization-folder') then
            TradutorConfig.LocalizationFolder := value;
      end;

   end;
end;

procedure TfrmTradutorSC.Procurar;
var
   Key: string;
   LocateSuccess: Boolean;
   SearchOptions: TLocateOptions;
begin
   Key := 'Valor';
   if cbProcurarTag.Checked then
      Key := 'Tag';

   SearchOptions := [loPartialKey, loCaseInsensitive];
   if PageControl1.ActivePageIndex = 0 then
      LocateSuccess := DataSource1.DataSet.Locate(Key, Edit1.Text, SearchOptions)
   else
      LocateSuccess := DataSource2.DataSet.Locate(Key, Edit1.Text, SearchOptions);
end;

procedure TfrmTradutorSC.qryOriginalAfterScroll(DataSet: TDataSet);
var
   s: string;
begin
   if PageControl1.ActivePageIndex = 0 then
      Exit;
   GetTraducao(DataSource2);
   if DataSource1.DataSet.State = TDataSetState.dsInactive then
      DataSource1.DataSet.Open;

   if DataSource1.DataSet.Locate('tag', KeyTag, [loCaseInsensitive]) then
   begin
      s := StringReplace(DataSource1.DataSet.FieldByName('valor').AsString, '\n', #13, [rfReplaceAll]);
      mmOriginal.Lines.Text := s;
   end
   else
      mmOriginal.Lines.Clear;

end;

procedure TfrmTradutorSC.qryTraducaoAfterScroll(DataSet: TDataSet);
var
   s: string;
begin
   if PageControl1.ActivePageIndex = 1 then
      Exit;
   GetTraducao(DataSource1);
   if DataSource2.DataSet.State = TDataSetState.dsInactive then
      DataSource2.DataSet.Open;

   if DataSource2.DataSet.Locate('tag', KeyTag, [loCaseInsensitive]) then
   begin
      s := StringReplace(DataSource2.DataSet.FieldByName('valor').AsString, '\n', #13, [rfReplaceAll]);
      mmOriginal.Lines.Text := s;
   end
   else
      mmOriginal.Lines.Text := mmTraducao.Lines.Text;
end;

procedure TfrmTradutorSC.btnFiltrarClick(Sender: TObject);
var
   Key: string;
begin
   Key := 'Value';
   if cbProcurarTag.Checked then
      Key := 'Tag';

   Filtro(' WHERE ' + Key + ' LIKE "%' + Trim(Edit1.Text) + '%" ')
end;

procedure TfrmTradutorSC.btnInterromperClick(Sender: TObject);
begin
   Self.Tag := 1;
end;

procedure TfrmTradutorSC.btAtualizarClick(Sender: TObject);
begin
   AtualizarTraducao();
end;

procedure TfrmTradutorSC.btnCancelarClick(Sender: TObject);
begin
   mmTraducao.Lines.Text := FTextUndo;
end;

procedure TfrmTradutorSC.btnUsarTraducaoClick(Sender: TObject);
begin
   mmTraducao.Lines.Text := mmOriginal.Lines.Text;
end;

procedure TfrmTradutorSC.cbMostrarNovasTagsClick(Sender: TObject);
begin
   if cbMostrarNovasTags.Checked then
   begin
      Filtro(' WHERE NEW=1;');
      sbImportarNovasTags.Enabled := not DataSource2.DataSet.IsEmpty;
   end
   else
   begin
      sbImportarNovasTags.Enabled := false;
      Filtro('');
   end;
end;

procedure TfrmTradutorSC.CreateTables(AQuery: TFDQuery; const ALocale: string);
var
   index: string;
begin
   AQuery.Close;
   AQuery.SQL.Text := StringReplace(CREATE_TABLE, '{locale}', ALocale, []);
   AQuery.ExecSQL;
   // index 1
   AQuery.Close;
   index := StringReplace(CREATE_INDEX, '{locale}', ALocale, [rfReplaceAll]);
   AQuery.SQL.Text := StringReplace(index, '{field}', 'tag', [rfReplaceAll]);;
   AQuery.ExecSQL;

   // index 2
   AQuery.Close;
   index := StringReplace(CREATE_INDEX, '{locale}', ALocale, [rfReplaceAll]);
   AQuery.SQL.Text := StringReplace(index, '{field}', 'value', [rfReplaceAll]);;
   AQuery.ExecSQL;

   AQuery.Close;
end;

procedure TfrmTradutorSC.CreateTempTable(const ADatabase, ALocale: string);
var
   AQuery: TFDQuery;
   aConnection: TFDConnection;
begin
   aConnection := TFDConnection.Create(Self);
   aConnection.Params := Connection.Params;
   aConnection.Params.database := ADatabase;
   AQuery := TFDQuery.Create(Self);

   try
      AQuery.Connection := aConnection;
      AQuery.SQL.Text := StringReplace(DROP_TABLE_IFEXISTS, '{locale}', ALocale, [rfReplaceAll]);
      AQuery.ExecSQL;
      CreateTables(AQuery, ALocale);

   finally
      AQuery.Free;
      aConnection.Close;
      aConnection.Free;
   end;

end;

procedure TfrmTradutorSC.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
var
   lQuery: TFDQuery;
begin
   if Button = TNavigateBtn.nbInsert then
   begin
      DataSource1.DataSet.Cancel;
      frmNovaTag.edtTag.Text := '';
      frmNovaTag.mmTraducao.Text := '';
      if PageControl1.ActivePageIndex = 1 then
      begin
         frmNovaTag.edtTag.Text := DataSource2.DataSet.FieldByName('tag').AsString;
         frmNovaTag.mmTraducao.Text := DataSource2.DataSet.FieldByName('valor').AsString;
      end;

      frmNovaTag.ShowModal;

      if frmNovaTag.ModalResult = mrOk then
      begin

         lQuery := TFDQuery.Create(Self);
         try
            lQuery.Connection := Connection;
            lQuery.SQL.Text := 'INSERT INTO global_' + DEFAULT_LOCALE +
              ' (Tag, Value, Changed, New) VALUES (:Tag,:Value,:Changed, :New)';
            InserirLinha(lQuery, Trim(frmNovaTag.edtTag.Text), Trim(frmNovaTag.mmTraducao.Text), True);
            lQuery.Close;
            lQuery.SQL.Text := 'UPDATE global_' + ORIGINAL_LOCALE + ' set New=0 where id=' +
              DataSource2.DataSet.FieldByName('id').AsString;
            lQuery.ExecSQL;
            DataSource2.DataSet.DisableControls;
            qryTraducao.Refresh;
            qryOriginal.Refresh;
            DataSource2.DataSet.EnableControls;
         finally
            lQuery.Free;
         end;
      end;
   end;

end;

procedure TfrmTradutorSC.dgTraducaoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if not((gdFocused in State) or (gdSelected in State)) then
   begin
      if ((Sender as TDBGrid).DataSource.DataSet.FieldByName('new').AsInteger = 1) then
      begin
         (Sender as TDBGrid).Canvas.Brush.Color := clVerde;
         (Sender as TDBGrid).Canvas.Font.Color := clBlack;
      end;
   end;
   (Sender as TDBGrid).Canvas.FillRect(Rect);
   (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmTradutorSC.GetTraducao(const ADatasource: TDataSource);
begin
   FTextUndo := StringReplace(ADatasource.DataSet.FieldByName('valor').AsString, '\n', #13, [rfReplaceAll]);
   mmTraducao.Lines.Text := FTextUndo;
   KeyTag := ADatasource.DataSet.FieldByName('tag').AsString;
   Label1.Caption := '(' + ADatasource.DataSet.FieldByName('id').AsString + ') TAG: ' + KeyTag;
end;

procedure TfrmTradutorSC.Edit1Change(Sender: TObject);
begin
   Procurar();
end;

procedure TfrmTradutorSC.EditarpromptChatGPT1Click(Sender: TObject);
var
   APrompts: TArray<String>;
   CloseQFnc: TInputCloseQueryFunc;
begin

   SetLength(APrompts, 2);
   APrompts[0] := TradutorConfig.PromptTranslate;
   APrompts[1] := TradutorConfig.PromptEnhance;
   if InputQuery('Editar Prompt', ['Traduzir', 'Melhorar tradução'], APrompts) then
   begin
      TradutorConfig.PromptTranslate := APrompts[0];
      TradutorConfig.PromptEnhance := APrompts[1];
      SalvarConfiguracao();
      ShowMessage('Configuração foi salva. Prompts redefinidos.');
   end;

end;

procedure TfrmTradutorSC.ExportarGlobal(const Filename: string);
begin
   Self.Tag := 0;

   tthread.CreateAnonymousThread(
      procedure
      var
         i: Integer;
         aLinha, ATag, AValue: string;
         aConnection: TFDConnection;
         AQuery: TFDQuery;
         ini: TStreamWriter;
      begin
         ini := TStreamWriter.Create(Filename, false, TEncoding.UTF8);

         aConnection := TFDConnection.Create(Self);
         AQuery := TFDQuery.Create(Self);
         try
            aConnection.Params := Connection.Params;
            AQuery.Connection := aConnection;
            AQuery.SQL.Text :=
              'SELECT cast(tag as varchar) as Tag, cast(value as varchar) as Valor FROM Global_ptbr ORDER BY TAG;';
            AQuery.Open;
            i := 0;
            while not AQuery.Eof do
            begin
               if Self.Tag = 1 then
                  break;
               aLinha := AQuery.FieldByName('Tag').AsString.Trim + '=' + AQuery.FieldByName('Valor').AsString.Trim;

               ini.WriteLine(aLinha);

               if (i mod 100 = 0) then
                  tthread.Synchronize(tthread.CurrentThread,
                     procedure
                     begin
                        Label1.Caption := 'Linhas exportadas: ' + i.ToString;
                     end);
               AQuery.Next;
               inc(i);
            end;
         finally
            ini.Free;
            tthread.Synchronize(tthread.CurrentThread,
               procedure
               begin
                  SkAnimatedImage1.Animation.Enabled := false;
                  Label1.Caption := 'Linhas exportadas: ' + i.ToString;
                  ShowMessage('Exportação concluída: ' + Filename);
               end);
            AQuery.Free;
            aConnection.Free;
         end;
      end).Start;

end;

procedure TfrmTradutorSC.ExportarGlobalini1Click(Sender: TObject);
var
   aa, mm, dd: Word;
   Filename: string;
begin
   DecodeDate(Now(), aa, mm, dd);
   Filename := Format('global_%d-%d-%d.ini', [aa, mm, dd]);
   SaveDialog1.Filename := Filename;
   if SaveDialog1.Execute() then
   begin
      SkAnimatedImage1.Animation.Enabled := True;
      if FileExists(SaveDialog1.Filename) and (MessageDlg('Arquivo "' + SaveDialog1.Filename + '" já existe, sobrepor?',
        TMsgDlgType.mtWarning, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) <> mrYes) then
         Exit;
      ExportarGlobal(SaveDialog1.Filename);
   end;
end;

procedure TfrmTradutorSC.ObtenhasuachaveDeepLTranslate1Click(Sender: TObject);
var
   Key: string;
begin

   if MessageDlg('Atenção, sua chave será guardada no arquivo de configuração'#13 +
     'deste programa de forma criptografada.'#13 +
     'Recomenda-se criar uma chave especifica evitando usar a sua chave principal.'#13 +
     'Se já houver uma chave registrada esta será substituída.'#13#13 + 'Prosseguir?', TMsgDlgType.mtWarning,
     [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrYes then
   begin
      InputQuery('Entre com a chave', 'Chave API OpenAI:', Key);
      if Key.IsEmpty then
         Exit;
      TradutorConfig.OpenaiKey := Key;
      SalvarConfiguracao();
   end;
end;

procedure TfrmTradutorSC.OnOpenAIError(Sender: TObject);
begin
   if (FChatGPT.StatusCode = 400) and (FChatGPT.RequestType = TOAIRequests.orImages) then
   begin
      mmOriginal.Lines.Add('Prompt inválido!');
      Exit;
   end;

   mmOriginal.Lines.Add('Error ' + FChatGPT.StatusCode.ToString + ' - ' + FChatGPT.ErrorMessage);
end;

procedure TfrmTradutorSC.OnOpenAIResponse(Sender: TObject);
var
   Text, Lines: String;
   responses: TArray<String>;
   i: Integer;
begin
   responses := FChatGPT.GetChatResult;
   Lines := '';
   for Text in responses do
   begin
      Lines := Text + Lines;

   end;
   mmOriginal.Lines.Text := Lines;
end;

procedure TfrmTradutorSC.Aplicartema(const ATema: string);
begin
   try
      TStyleManager.TrySetStyle(ATema);
      Self.Refresh;
      TradutorConfig.Tema := ATema;
   except
      ShowMessage('Tema "' + ATema + '" não disponível')
   end;
end;

procedure TfrmTradutorSC.SelecionarTema(Sender: TObject);
var
   skin: string;
   menuItem: TMenuItem;

begin
   if not(Sender is TMenuItem) then
      Exit;
   for menuItem in MenuTema1 do
      menuItem.Checked := false;
   Self.Invalidate;
   skin := (Sender as TMenuItem).Hint;
   Aplicartema(skin);
   SalvarConfiguracao();
   (Sender as TMenuItem).Checked := True;
end;

procedure TfrmTradutorSC.AdicionarTemas(const ATemaDefault: string);
var
   stylename, Filename: string;
   menuItem: TMenuItem;
begin
   for stylename in TStyleManager.StyleNames do
   begin
      menuItem := TMenuItem.Create(MainMenu1);
      menuItem.Caption := stylename;
      menuItem.Hint := stylename;
      menuItem.OnClick := SelecionarTema;
      MenuTema1.Add(menuItem);
   end;
   if ATemaDefault.IsEmpty then
      Exit;
   Aplicartema(ATemaDefault);
end;

procedure TfrmTradutorSC.CompararTags1Click(Sender: TObject);
begin
   frmCompararTags.ShowModal;
end;

procedure TfrmTradutorSC.ConfigurarOpenAI;
begin
   FChatGPT := TOpenAI.Create(TradutorConfig.OpenaiKey);
   FChatGPT.Endpoint := OpenAI_PATH;
   FChatGPT.OnResponse := OnOpenAIResponse;
   FChatGPT.OnError := OnOpenAIError;
end;

procedure TfrmTradutorSC.ConnectionBeforeConnect(Sender: TObject);
begin
   Connection.Params.database := FDatabaseLocation + DATABASE_NAME;
end;

procedure TfrmTradutorSC.FormCreate(Sender: TObject);
var
   linha, configuracao: string;
begin
   FDatabaseLocation := ExtractFilePath(ParamStr(0));
   ForceDirectories(FDatabaseLocation + 'db');
   FDatabaseLocation := FDatabaseLocation + 'db' + TPath.DirectorySeparatorChar;
   Connection.Close;
   TradutorConfig.Tema := '';
   TradutorConfig.PromptTranslate := StringReplace(PROMPT_TRANSLATE, '\n', #13, [rfReplaceAll]);
   TradutorConfig.PromptEnhance := StringReplace(PROMPT_ENHANCE, '\n', #13, [rfReplaceAll]);
   CarregarConfiguracao();
   AdicionarTemas(TradutorConfig.Tema);
   ConfigurarOpenAI();
   PageControl1.ActivePageIndex := 0;
end;

procedure TfrmTradutorSC.Filtro(const AFiltro: string);
var
   select: string;
begin
   select := StringReplace(SELECT_PTBR, '%where%', AFiltro, []);
   qryTraducao.Open(select);
end;

procedure TfrmTradutorSC.AbrirTabelas;
begin
   try
      CreateTables(qryTraducao, ORIGINAL_LOCALE);
      CreateTables(qryTraducao, DEFAULT_LOCALE);
      Filtro('');
      dgTraducao.Columns.items[2].Width := (Self.Width div 2) - 300;
      dgOriginal.Columns.items[2].Width := (Self.Width div 2) - 300;
   except
      on e: Exception do
         ShowMessage('Erro! Banco de dados não pode ser aberto. ' + e.Message)
   end;
end;

procedure TfrmTradutorSC.FormShow(Sender: TObject);
begin
   btnInterromper.Visible := false;
   AbrirTabelas();
   sbTraduzir.Enabled := not TradutorConfig.OpenaiKey.IsEmpty;
end;

function TfrmTradutorSC.InserirLinha(var AQuery: TFDQuery; const ATag, AValue: string;
const ANew: Boolean = false): Boolean;
begin
   AQuery.Close;
   AQuery.Params.ParamByName('Tag').AsString := ATag;
   AQuery.Params.ParamByName('Value').AsString := AValue;
   AQuery.Params.ParamByName('Changed').AsDateTime := Now();
   if ANew then
      AQuery.Params.ParamByName('New').AsInteger := 1
   else
      AQuery.Params.ParamByName('New').AsInteger := 0;
   try
      AQuery.ExecSQL;
      Result := True;
   except
      Result := false;
   end;
end;

procedure TfrmTradutorSC.SelecionarDiretorioSC;
const
   SELDIRHELP = 1000;
var
   Dir: string;
begin
   Dir := TradutorConfig.LocalizationFolder;
   if Dir.IsEmpty then
      Dir := DEFAULT_LOCALIZATION_FOLDER + LOCALIZATION_PTBR;

   if GetFolderDialog(Self.Handle, 'Instalação Star Citizen', Dir) then
   begin
      TradutorConfig.LocalizationFolder := Dir;
      SalvarConfiguracao();
   end;
end;

procedure TfrmTradutorSC.LocalizaoStarCitizen1Click(Sender: TObject);
begin
   SelecionarDiretorioSC();
end;

procedure TfrmTradutorSC.AtualizarDatabase(const id: Integer; const ATag, AValor, AOldValor: string);
var
   lQuery: TFDQuery;
begin
   lQuery := TFDQuery.Create(Self);
   try
      lQuery.Connection := Connection;
      if ATag.IsEmpty then
      begin
         lQuery.SQL.Text := 'UPDATE GLOBAL_PTBR SET NEW=0,VALUE=:VALUE WHERE VALUE=:OLD_VALUE;';
         lQuery.ParamByName('VALUE').AsString := AValor.Trim;
         lQuery.ParamByName('OLD_VALUE').AsString := AOldValor.Trim;
      end
      else
      begin
         lQuery.SQL.Text := 'UPDATE  GLOBAL_PTBR SET NEW=0,VALUE=:VALUE WHERE Id=:Id;';
         lQuery.ParamByName('Id').AsInteger := id;
         lQuery.ParamByName('VALUE').AsString := AValor.Trim;
      end;
      lQuery.ExecSQL;
   finally
      lQuery.Free;
   end;
end;

procedure TfrmTradutorSC.Atualizartodasocorrncias1Click(Sender: TObject);
var
   traducao: string;
begin
   traducao := StringReplace(mmTraducao.Lines.Text.Trim, #13, '\n', [rfReplaceAll]);
   if MessageDlg('Esta opção irá substituir TODOS os valores de tags EXATAS.'#13#13 + '"' + Copy(FTextUndo, 1, 15) +
     '"... será alterado para:' + #13 + '"' + Copy(traducao, 1, 15) + '"' + #13#13 +
     'Certifique-se em ter uma cópia do banco de dados para fins de '#13 +
     'recuperação, caso necessário.'#13#13' Continuar?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0)
     = mrYes then
   begin
      AtualizarDatabase(DataSource1.DataSet.FieldByName('id').AsInteger, '', traducao, FTextUndo);
      DataSource1.DataSet.Refresh;
      Edit1.SetFocus;
   end;
end;

procedure TfrmTradutorSC.AtualizarTraducao;
var
   traducao: string;
begin
   traducao := StringReplace(mmTraducao.Lines.Text.Trim, #13, '\n', [rfReplaceAll]);
   AtualizarDatabase(DataSource1.DataSet.FieldByName('id').AsInteger, DataSource1.DataSet.FieldByName('tag').AsString,
     traducao, '');
   DataSource1.DataSet.Refresh;
   GetTraducao(DataSource1);
   qryTraducaoAfterScroll(DataSource1.DataSet);
   Edit1.SetFocus;
end;

procedure TfrmTradutorSC.mmTraducaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (ssCtrl in Shift) and (Key = 13) then
   begin
      Key := 0;
      AtualizarTraducao();
   end;
end;

procedure TfrmTradutorSC.PageControl1Change(Sender: TObject);
begin
   if not cbSincronizar.Checked then
      Exit;

   if PageControl1.ActivePageIndex = 0 then
      dgTraducao.DataSource.DataSet.Locate('tag', KeyTag, [loCaseInsensitive])
   else
      dgOriginal.DataSource.DataSet.Locate('tag', KeyTag, [loCaseInsensitive]);
end;

function TfrmTradutorSC.NewTag(var AQuery: TFDQuery; ATag: string): Boolean;
begin
   AQuery.Close;
   AQuery.ParamByName('TAG').AsString := ATag;
   AQuery.Open;
   Result := AQuery.IsEmpty;
end;

procedure ErroLinhaNaoInserida(ATag: string);
begin
   tthread.Synchronize(tthread.CurrentThread,
      procedure
      begin
         ShowMessage('Erro ao inserir Tag. Já existe?' + #13#13 + ATag);
      end);
end;

procedure TfrmTradutorSC.ProcessarGlobalIni(const Filename, ALocale: string; const ATagsOnly: Boolean);
begin
   Self.Tag := 0;
   ImportarGlobalini1.Enabled := false;
   ImportarGlobaliniparabaseIngls1.Enabled := false;
   SetPaineis(false);
   tthread.CreateAnonymousThread(
      procedure
      var
         i, j, p: Integer;
         ini: TextFile;
         aLinha, ATag, AValue: string;
         aConnection: TFDCustomConnection;
         AQuery, sQuery: TFDQuery;
         DB: string;
         new: Boolean;
      begin
         FileMode := 0;
         AssignFile(ini, Filename, CP_UTF8);
         Reset(ini);
         Screen.Cursor := crHourGlass;
         aConnection := TFDConnection.Create(Self);
         AQuery := TFDQuery.Create(Self);
         sQuery := TFDQuery.Create(Self);
         Connection.Close;
         try
            try

               aConnection.Params := Connection.Params;
               aConnection.DriverName := Connection.DriverName;

               if not ATagsOnly then
                  aConnection.Params.database := FTmpDatabase;

               AQuery.Connection := aConnection;
               AQuery.SQL.Text := 'INSERT INTO global_' + ALocale +
                 ' (Tag, Value, Changed, New) VALUES (:Tag,:Value, :Changed, :New)';

               sQuery.Connection := aConnection;
               if ALocale = ORIGINAL_LOCALE then
                  sQuery.SQL.Text := 'SELECT id FROM global_' + ORIGINAL_LOCALE + ' WHERE Tag = :TAG;'
               else
                  sQuery.SQL.Text := 'SELECT id FROM global_' + DEFAULT_LOCALE + ' WHERE Tag = :TAG;';
               i := 0;
               j := 0;
               while not Eof(ini) do
               begin
                  if Self.Tag = 1 then
                     break;

                  Readln(ini, aLinha);
                  // melhor remover um eventual UTF-8 BOM
                  if (i = 0) and (not aLinha.IsEmpty) and (aLinha[1] = BOM_CHARACTER) then
                     aLinha := Copy(aLinha, 2);

                  p := Pos('=', aLinha);
                  ATag := Copy(aLinha, 1, p - 1);
                  AValue := Copy(aLinha, p + 1);

                  if ATagsOnly then
                  begin
                     if NewTag(sQuery, ATag) then
                     begin
                        if InserirLinha(AQuery, ATag, AValue, True) then
                           inc(j)
                        else
                           ErroLinhaNaoInserida(ATag);
                     end;
                  end
                  else
                  begin

                     if ALocale = ORIGINAL_LOCALE then
                     begin
                        new := NewTag(sQuery, ATag);
                        if not InserirLinha(AQuery, ATag, AValue, new) then
                           ErroLinhaNaoInserida(ATag);
                     end;

                     if ALocale = DEFAULT_LOCALE then
                     begin
                        new := NewTag(sQuery, ATag);
                        if not new then
                           if not InserirLinha(AQuery, ATag, AValue, false) then
                              ErroLinhaNaoInserida(ATag);
                     end;

                     inc(j);
                  end;

                  inc(i);
                  if (i mod 100 = 0) then
                     tthread.Synchronize(tthread.CurrentThread,
                        procedure
                        begin
                           Label1.Caption := 'Linhas importadas: ' + j.ToString;
                        end);
               end;
            except
               on e: Exception do
                  tthread.Synchronize(nil,
                     procedure
                     begin
                        SkAnimatedImage1.Animation.Enabled := false;
                        Label1.Caption := 'Erro ao tentar importar arquivo. Linhas importadas: ' + i.ToString;
                        ErroImportacao(e.Message);
                     end);

            end;

         finally
            aConnection.Close;
            AQuery.Free;
            sQuery.Free;
            aConnection.Free;

            tthread.Synchronize(nil,
               procedure
               begin
                  Screen.Cursor := crDefault;
                  ImportarGlobalini1.Enabled := True;
                  ImportarGlobaliniparabaseIngls1.Enabled := True;
                  SkAnimatedImage1.Animation.Enabled := false;
                  Label1.Caption := 'Linhas importadas: ' + j.ToString;
                  if not ATagsOnly then
                     ImportacaoConcluida()
                  else
                     Filtro('');
                  SetPaineis(True);
               end);

         end;

         CloseFile(ini);

      end).Start;

end;

procedure TfrmTradutorSC.ErroImportacao(const ErrorMessage: string);
begin
   if FileExists(FTmpDatabase) then
      DeleteFile(FTmpDatabase);
   tthread.Synchronize(nil,
      procedure
      begin
         SetPaineis(True);
         ShowMessage('Erro ao tentar importar. Dados revertidos.' + #13 + ErrorMessage);
         Filtro('');
      end);

end;

procedure TfrmTradutorSC.SetPaineis(AEnabled: Boolean);
begin
   Panel1.Enabled := AEnabled;
   Panel2.Enabled := AEnabled;
   Panel4.Enabled := AEnabled;
   btnInterromper.Visible := not AEnabled;
end;

procedure TfrmTradutorSC.ImplantarTraduo1Click(Sender: TObject);
begin
   if TradutorConfig.LocalizationFolder.IsEmpty then
      SelecionarDiretorioSC();
   if TradutorConfig.LocalizationFolder.IsEmpty or (not DirectoryExists(TradutorConfig.LocalizationFolder)) then
   begin
      ShowMessage('Pasta não encontrada, confirme a localização');
      Exit;
   end;

   if MessageDlg('Esta operação irá implantar o arquivo "global.ini" traduzido diretamente na pasta de localização.'#13#13+
    'Local: '+TradutorConfig.LocalizationFolder+#13'Continuar?', TMsgDlgType.mtWarning,
     [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrYes then
   begin
      try
         ExportarGlobal(TradutorConfig.LocalizationFolder + '\' + GLOBAL_INI);
      except
         ShowMessage('Erro ao tentar implantar arquivo de Localização.');
      end;
   end;

end;

procedure TfrmTradutorSC.ImportacaoConcluida;
var
   DB: string;
begin
   Connection.Connected := false;
   DB := FDatabaseLocation + DATABASE_NAME;
   if FileExists(DB + '.back') then
      TFile.Delete(DB + '.back');
   RenameFile(DB, DB + '.back');
   RenameFile(FTmpDatabase, DB);

   Connection.Params.database := DB;
   qryTraducao.Open;

   tthread.Synchronize(nil,
      procedure
      begin
         SetPaineis(True);
         ShowMessage('Importação concluída com sucesso.');
         Filtro('');
      end);

end;

function TfrmTradutorSC.InitChatGPT(const ATraducao, AOriginal: string): Boolean;
var
   prompt: string;
begin
   if cbMelhorar.Checked then
      prompt := TradutorConfig.PromptEnhance + StringReplace(prompt, '{traducao}', ATraducao, [rfReplaceAll])
   else
      prompt := TradutorConfig.PromptTranslate;

   prompt := StringReplace(prompt, '{original}', AOriginal, [rfReplaceAll]);

   FChatGPT.Chat.AddMessage(prompt, TMessageRole.mrUser);
   FChatGPT.RequestType := orChat;
   FChatGPT.Chat.Model := TOAIModel.mdGPT3_5Turbo;
   FChatGPT.Endpoint := OAI_ENDPOINT;
   FChatGPT.Chat.MaxTokens := 1024;
   FChatGPT.Chat.TopP := 1;
   FChatGPT.Chat.Temperature := 0;
end;

procedure TfrmTradutorSC.Sair1Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmTradutorSC.Sobre1Click(Sender: TObject);
begin
   frmSobre.ShowModal;
end;

procedure TfrmTradutorSC.sbTraduzirClick(Sender: TObject);
var
   AOriginal, ATraducao: string;
begin
   FChatGPT.RequestType := orChat;
   ATraducao := mmTraducao.Lines.Text.Trim;
   AOriginal := mmOriginal.Lines.Text.Trim;
   if (FChatGPT.RequestType = orChat) and (ATraducao.IsEmpty) then
      Exit;

   SkAnimatedImage1.Animation.Enabled := True;
   Label1.Caption := 'Traduzindo, aguarde...';

   tthread.CreateAnonymousThread(
      procedure
      var
         doExecute: Boolean;
      begin

         try
            doExecute := True;
            InitChatGPT(ATraducao, AOriginal);
            try
               FChatGPT.Execute;
            except
               on e: Exception do
                  mmOriginal.Lines.Add(e.Message)
            end;
         finally
            tthread.Synchronize(nil,
               procedure
               begin
                  SkAnimatedImage1.Animation.Enabled := false;
                  Label1.Caption := '---';
               end);
         end;

      end).Start;
end;

procedure TfrmTradutorSC.sbLimparFiltroClick(Sender: TObject);
begin
   Edit1.Clear;
   Filtro('');
end;

procedure TfrmTradutorSC.sbImportarNovasTagsClick(Sender: TObject);
var
   lQuery: TFDQuery;
   lValue, lTag: string;
begin

   Screen.Cursor := crHourGlass;

   DataSource2.DataSet.DisableControls;
   lQuery := TFDQuery.Create(Self);
   lQuery.Connection := Connection;

   try
      DataSource2.DataSet.First;
      while not DataSource2.DataSet.Eof do
      begin
         lTag := Trim(DataSource2.DataSet.FieldByName('tag').AsString);
         lValue := Trim(DataSource2.DataSet.FieldByName('valor').AsString);

         lQuery.SQL.Text := 'INSERT INTO global_' + DEFAULT_LOCALE +
           ' (Tag, Value, Changed, New) VALUES (:Tag,:Value,:Changed, :New)';
         InserirLinha(lQuery, lTag, lValue, True);
         lQuery.Close;
         lQuery.SQL.Text := 'UPDATE global_' + ORIGINAL_LOCALE + ' set New=0 where id=' +
           DataSource2.DataSet.FieldByName('id').AsString;
         lQuery.ExecSQL;

         DataSource2.DataSet.Next;
      end;

   finally
      lQuery.Free;
      qryTraducao.Refresh;
      qryOriginal.Refresh;
      DataSource2.DataSet.EnableControls;
      Screen.Cursor := crDefault;
   end;

end;

procedure TfrmTradutorSC.Splitter1CanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
begin
   if NewSize < 280 then
      Accept := false;
end;

procedure TfrmTradutorSC.Splitter1Moved(Sender: TObject);
begin
   Panel4.Invalidate;
   mmTraducao.Height := (Panel4.Height div 2) - 60;
   mmOriginal.Height := mmTraducao.Height;
   mmOriginal.Top := mmTraducao.Height + 102;
   sbTraduzir.Top := mmTraducao.Height + 48;
   cbMelhorar.Top := mmTraducao.Height + 56;
   Label3.Top := mmTraducao.Height + 50;
   Label4.Top := mmTraducao.Height + 50;
   Panel4.Repaint;
end;

procedure TfrmTradutorSC.Importarapenasnovastags1Click(Sender: TObject);
var
   locale: string;
begin
   if MessageDlg('Importar apenas novas tags poderá demorar um tempo considerável,'#13 +
     'pois cada uma delas deverá ser verificada no banco de dados.'#13#13' Continuar?', TMsgDlgType.mtWarning,
     [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrYes then
   begin
      if OpenDialog1.Execute() then
      begin
         if (Sender as TMenuItem).Tag = 1 then
            locale := ORIGINAL_LOCALE
         else
            locale := DEFAULT_LOCALE;
         ProcessarGlobalIni(OpenDialog1.Filename, locale, True);
      end;
   end;

end;

procedure TfrmTradutorSC.ImportarGlobal(const Filename: string; const AIsOriginalBase: Boolean = false);
var
   locale: string;
   select: string;
begin
   try

      if AIsOriginalBase then
         locale := ORIGINAL_LOCALE
      else
         locale := DEFAULT_LOCALE;

      btnInterromper.Visible := True;
      Label1.Caption := 'Copiando banco de dados';
      SkAnimatedImage1.Animation.Enabled := True;

      SetPaineis(false);

      FTmpDatabase := FDatabaseLocation + DATABASE_NAME + '.tmp';
      if FileExists(FTmpDatabase) then
         TFile.Delete(FTmpDatabase);
      TFile.Copy(FDatabaseLocation + DATABASE_NAME, FTmpDatabase);
      qryTraducao.Close;
      qryOriginal.Close;

      CreateTempTable(FTmpDatabase, locale);
      ProcessarGlobalIni(Filename, locale, false);

   except
      SkAnimatedImage1.Animation.Enabled := false;
      btnInterromper.Visible := false;
   end;

end;

procedure TfrmTradutorSC.Importartudo1Click(Sender: TObject);
begin
   if MessageDlg('Atenção, ao importar significa reiniciar o banco de dados com estes novos dados.'#13 +
     'O banco de dados atual será salvo com extensão .back.'#13#13' Continuar?', TMsgDlgType.mtWarning,
     [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrYes then
   begin
      if OpenDialog1.Execute() then
         ImportarGlobal(OpenDialog1.Filename, (Sender as TMenuItem).Tag = 1);
   end;

end;

end.
