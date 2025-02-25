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
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
	FireDAC.Stan.Error,
	FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
	FireDAC.Stan.Async,
	FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs,
	FireDAC.Phys.SQLiteWrapper.Stat,
	FireDAC.Phys.SQLiteDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
	FireDAC.DApt, Data.DB,
	FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
	System.ImageList, Vcl.ImgList,
	Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
	Vcl.Themes, Vcl.Styles,
	Vcl.DBCtrls, System.IOUtils, System.Skia, Vcl.Skia, Vcl.ComCtrls,
	MLOpenAI.Core, MLOpenAI.ChatGPT, MLOpenAI.Types, MLOpenAI.Completions,
	LbCipher, LbClass, uTradutor.Comum;

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
		pcTextStrings: TPageControl;
		tsTranslation: TTabSheet;
		tsOriginal: TTabSheet;
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
		btnUsarOriginal: TButton;
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
		Panel5: TPanel;
		CompararTags1: TMenuItem;
		Label4: TLabel;
		LocalizaoStarCitizen1: TMenuItem;
		ImplantarTraduo1: TMenuItem;
		N2: TMenuItem;
		ExportarGlobaliniOriginal1: TMenuItem;
		cbMostrarVazios: TCheckBox;
		PastaversoLive1: TMenuItem;
		Escolherlugar1: TMenuItem;
		UtilizarOllamaAI: TMenuItem;
		raduoIA1: TMenuItem;
		cbExata: TCheckBox;
		edDontranslate: TEdit;
		Label5: TLabel;
		cbNotTranslated: TCheckBox;
		procedure btnInterromperClick(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure sbTraduzirClick(Sender: TObject);
		procedure Splitter1Moved(Sender: TObject);
		procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
		procedure pcTextStringsChange(Sender: TObject);
		procedure Sobre1Click(Sender: TObject);
		procedure btnFiltrarClick(Sender: TObject);
		procedure Edit1Change(Sender: TObject);
		procedure sbLimparFiltroClick(Sender: TObject);
		procedure Sair1Click(Sender: TObject);
		procedure ObtenhasuachaveDeepLTranslate1Click(Sender: TObject);
		procedure ExportarGlobalini1Click(Sender: TObject);
		procedure mmTraducaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
		procedure ConnectionBeforeConnect(Sender: TObject);
		procedure btnUsarOriginalClick(Sender: TObject);
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
		procedure CompararTags1Click(Sender: TObject);
		procedure LocalizaoStarCitizen1Click(Sender: TObject);
		procedure ExportarGlobaliniOriginal1Click(Sender: TObject);
		procedure cbMostrarVaziosClick(Sender: TObject);
		procedure dgTraducaoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
		  State: TGridDrawState);
		procedure PastaversoLive1Click(Sender: TObject);
		procedure Escolherlugar1Click(Sender: TObject);
		procedure DataSource1DataChange(Sender: TObject; Field: TField);
		procedure mmTraducaoEnter(Sender: TObject);
		procedure UtilizarOllamaAIClick(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure edDontranslateExit(Sender: TObject);
		procedure cbNotTranslatedClick(Sender: TObject);
	private
		FEngine: TOAIEngine;
		FChatGPT: TOpenAI;
		FDatabaseLocation: String;
		FTmpDatabase: String;
		FTextUndo: String;
		procedure ImportarGlobal(const Filename: string; const AIsOriginalBase: Boolean = false);
		procedure CreateTempTable(const ADatabase, ALocale: string);
		procedure ProcessarGlobalIni(const Filename, ALocale: string; const ATagsOnly: Boolean);
		procedure CreateTables(AQuery: TFDQuery; const ALocale: string);
		procedure OnOpenAIResponse(Sender: TObject);
		procedure OnOpenAIError(Sender: TObject);
		function InitChatGPT(const ATraducao, AOriginal: string): Boolean;
		procedure Procurar;
		procedure Filtro(const AFiltro, AOrder: string);
		procedure AdicionarTemas(const ATemaDefault: string);
		procedure SelecionarTema(Sender: TObject);
		procedure Aplicartema(const ATema: string);
		procedure ConfigurarAI;
		procedure ExportarGlobal(const Filename, ALocale: string);
		procedure AtualizarDatabase(const id: Integer; const ATag, AValor, AOldValor: string);
		procedure ErroImportacao(const ErrorMessage: string);
		procedure ImportacaoConcluida;
		procedure AbrirTabelas;
		procedure SetPaineis(AEnabled: Boolean);
		procedure GetTraducao(const ADatasource: TDataSource);
		procedure AtualizarTraducao;
		function NewTag(var AQuery: TFDQuery; ATag, ALocale: string; const aCheckForChanged: Boolean = true): Integer;
		procedure SelecionarDiretorioSC;
		procedure Exportar(const ALocale: string);
		procedure EnableTextGrid;
		function ConfirmDeploy(const AFolder: string): Boolean;
		{ Private declarations }
	public
		{ Public declarations }
		function UpdateTableRow(var AQuery: TFDQuery; const ATag, AValue: string; const ANew: Boolean = false): Boolean;
	end;

var
	frmTradutorSC: TfrmTradutorSC;
	LastDir, KeyTag: String;
	TradutorConfig: TConfig;

implementation

{$R *.dfm}

uses
	FileCtrl, Clipbrd, uTradutor.Novatag, uTradutor.Sobre,
	uTradutor.CompararTags;

procedure TEdit.CNCommand(var Message: TWMCommand);
begin
	inherited;
	// if (Message.NotifyCode = EN_MAXTEXT) and FIsPasting then
	// ShowMessage('Too much text!');
end;

procedure TEdit.WMPaste(var Message: TMessage);
begin

	FIsPasting := true;
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
	configuracao[2] := 'prompt-translate:' + StringReplace(TradutorConfig.PromptTranslate, #13, '\n', [rfReplaceAll]);
	configuracao[3] := 'prompt-enhance:' + StringReplace(TradutorConfig.PromptEnhance, #13, '\n', [rfReplaceAll]);
	configuracao[4] := 'localization-folder:' + TradutorConfig.LocalizationFolder;
	configuracao[5] := 'last-used-folder:' + TradutorConfig.LastUsedFolder;
	if TradutorConfig.UseOllamaAI then
		configuracao[6] := 'ollama-ai:1'
	else
		configuracao[6] := 'ollama-ai:0';
	configuracao[7] := 'dont-translate:' + TradutorConfig.DontTranslate;
	TFile.WriteAllLines(SC_CONFIG, configuracao, TEncoding.UTF8);
end;

procedure CarregarConfiguracao();
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
			if item.Contains('last-used-folder:') then
				TradutorConfig.LastUsedFolder := value;
			// if item.Contains('prompt-translate') then
			// TradutorConfig.PromptTranslate := value;
			if item.Contains('prompt-enhance') then
				TradutorConfig.PromptEnhance := value;
			if item.Contains('dont-translate') then
				TradutorConfig.DontTranslate := value;
			if item.Contains('localization-folder') then
			begin
				TradutorConfig.LocalizationFolder := value;
				LastDir := value;
			end;
			if item.Contains('ollama-ai') then
				TradutorConfig.UseOllamaAI := (StrToInt(value) = 1);
		end;

		TradutorConfig.OpenaiKey := GetEnvironmentVariable('OPENAI_API_KEY');

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
	if pcTextStrings.ActivePage = tsTranslation then
		LocateSuccess := DataSource1.DataSet.Locate(Key, Edit1.Text, SearchOptions)
	else
		LocateSuccess := DataSource2.DataSet.Locate(Key, Edit1.Text, SearchOptions);
end;

procedure TfrmTradutorSC.qryOriginalAfterScroll(DataSet: TDataSet);
var
	s: string;
begin
	if pcTextStrings.ActivePage = tsTranslation then
		Exit;
	GetTraducao(DataSource2);
	if DataSource1.DataSet.State = TDataSetState.dsInactive then
		DataSource1.DataSet.Open;

	if DataSource1.DataSet.Locate('tag', KeyTag, [loCaseInsensitive]) then
	begin
		s := StringReplace(DataSource1.DataSet.FieldByName('valor').AsWideString, '\n', #13, [rfReplaceAll]);

		mmOriginal.Lines.Text := s;
	end
	else
		mmOriginal.Lines.Clear;

end;

procedure TfrmTradutorSC.qryTraducaoAfterScroll(DataSet: TDataSet);
var
	s: string;
begin
	if pcTextStrings.ActivePage = tsOriginal then
		Exit;
	GetTraducao(DataSource1);
	if DataSource2.DataSet.State = TDataSetState.dsInactive then
		DataSource2.DataSet.Open;

	if DataSource2.DataSet.Locate('tag', KeyTag, [loCaseInsensitive]) then
	begin
		s := StringReplace(DataSource2.DataSet.FieldByName('valor').AsWideString, '\n', #13, [rfReplaceAll]);
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
	if cbExata.Checked then
		Filtro(Format('%s = "%s"', [Key, Trim(Edit1.Text)]), 'tag')
	else
		Filtro(Key + ' LIKE "%' + Trim(Edit1.Text) + '%" ', 'tag ');

end;

procedure TfrmTradutorSC.btnInterromperClick(Sender: TObject);
begin
	Self.Tag := 1;
end;

procedure TfrmTradutorSC.EnableTextGrid;
begin
	dgTraducao.Enabled := true;
	dgTraducao.Color := clWindow;
end;

procedure TfrmTradutorSC.btAtualizarClick(Sender: TObject);
begin
	AtualizarTraducao();
	EnableTextGrid();
end;

procedure TfrmTradutorSC.btnCancelarClick(Sender: TObject);
begin
	mmTraducao.Lines.Text := FTextUndo;
	EnableTextGrid();
end;

procedure TfrmTradutorSC.btnUsarOriginalClick(Sender: TObject);
begin
	mmTraducao.Lines.Text := mmOriginal.Lines.Text;
end;

procedure TfrmTradutorSC.cbMostrarNovasTagsClick(Sender: TObject);
begin
	if cbMostrarNovasTags.Checked then
	begin
		Filtro('NEW=1', 'changed desc');
		// sbImportarNovasTags.Enabled := not DataSource2.DataSet.IsEmpty;
	end
	else
	begin
		// sbImportarNovasTags.Enabled := false;
		Filtro('', '');
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

procedure TfrmTradutorSC.DataSource1DataChange(Sender: TObject; Field: TField);
begin
	mmTraducao.Tag := 0;
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
		if pcTextStrings.ActivePage = tsOriginal then
		begin
			frmNovaTag.edtTag.Text := DataSource2.DataSet.FieldByName('tag').AsString;
			frmNovaTag.mmTraducao.Text := DataSource2.DataSet.FieldByName('valor').AsWideString;
		end;

		frmNovaTag.ShowModal;

		if frmNovaTag.ModalResult = mrOk then
		begin

			lQuery := TFDQuery.Create(Self);
			try
				lQuery.Connection := Connection;
				lQuery.SQL.Text := 'INSERT INTO global_' + TRANSLATED_LOCALE +
				  ' (Tag, Value, Comment, Changed, New) VALUES (:Tag,:Value, :Comment, :Changed, :New)';
				UpdateTableRow(lQuery, Trim(frmNovaTag.edtTag.Text), Trim(frmNovaTag.mmTraducao.Text), true);
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
	// if not(gdFocused in State)  then
	begin
		if ((Sender as TDBGrid).DataSource.DataSet.FieldByName('new').AsInteger = 1) then
		begin
			(Sender as TDBGrid).Canvas.Brush.Color := clVerde;
			(Sender as TDBGrid).Canvas.Font.Color := clBlack;
		end;
	end
	else
	begin
		(Sender as TDBGrid).Canvas.Brush.Color := clHighlight;
		(Sender as TDBGrid).Canvas.Font.Color := clWhite;
	end;
	(Sender as TDBGrid).Canvas.FillRect(Rect);
	(Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmTradutorSC.edDontranslateExit(Sender: TObject);
begin
	TradutorConfig.DontTranslate := Trim(edDontranslate.Text);
end;

procedure TfrmTradutorSC.GetTraducao(const ADatasource: TDataSource);
begin
	FTextUndo := StringReplace(ADatasource.DataSet.FieldByName('valor').AsWideString, '\n', #13, [rfReplaceAll]);
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
	if InputQuery('Edit Prompt', ['Translate', 'Improve translation'], APrompts) then
	begin
		TradutorConfig.PromptTranslate := APrompts[0];
		TradutorConfig.PromptEnhance := APrompts[1];
		SalvarConfiguracao();
		ShowMessage('Configuration has been saved. Prompts have been reset.');
	end;

end;

procedure TfrmTradutorSC.ExportarGlobal(const Filename, ALocale: string);
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
				AQuery.SQL.Text := 'SELECT cast(tag as varchar) as Tag, cast(value as varchar) as Valor FROM Global_' +
				  ALocale + ' ORDER BY TAG;';
				AQuery.Open;
				i := 0;
				while not AQuery.Eof do
				begin
					if Self.Tag = 1 then
						break;
					aLinha := StringReplace(AQuery.FieldByName('Valor').AsWideString.Trim, #10, '', [rfReplaceAll]);
					aLinha := AQuery.FieldByName('Tag').AsString.Trim + '=' + aLinha;

					ini.WriteLine(aLinha);

					if (i mod 100 = 0) then
						tthread.Synchronize(tthread.CurrentThread,
							procedure
							begin
								Label1.Caption := 'Exported lines: ' + i.ToString;
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
						Label1.Caption := 'Exported lines: ' + i.ToString;
						ShowMessage('Export completed: ' + Filename);
					end);
				AQuery.Free;
				aConnection.Free;
			end;
		end).Start;

end;

procedure TfrmTradutorSC.Exportar(const ALocale: string);
var
	aa, mm, dd: Word;
	Filename: string;
begin
	DecodeDate(Now(), aa, mm, dd);
	Filename := Format('global_%d-%d-%d - %s.ini', [aa, mm, dd, ALocale.ToUpper]);
	SaveDialog1.Filename := Filename;
	if SaveDialog1.Execute() then
	begin
		SkAnimatedImage1.Animation.Enabled := true;
		if FileExists(SaveDialog1.Filename) and (MessageDlg('File "' + SaveDialog1.Filename + '" already exists, override?',
		  TMsgDlgType.mtWarning, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) <> mrYes) then
			Exit;
		ExportarGlobal(SaveDialog1.Filename, ALocale);
	end;

end;

procedure TfrmTradutorSC.ExportarGlobalini1Click(Sender: TObject);
begin
	Exportar(TRANSLATED_LOCALE);
end;

procedure TfrmTradutorSC.ExportarGlobaliniOriginal1Click(Sender: TObject);
begin
	Exportar(ORIGINAL_LOCALE);
end;

procedure TfrmTradutorSC.ObtenhasuachaveDeepLTranslate1Click(Sender: TObject);
var
	Key: string;
begin
	MessageDlg('This program will read the key from your system''s environment variable.'#13 +
		'Create the key with the name: OPENAI_API_KEY and assign the value.'#13 +
		'It is recommended to create a specific key, avoiding using your main key.'#13#13 +
		'For information see here:	 https://help.openai.com/en/articles/5112595-best-practices-for-api-key-safety',
	  TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
end;

procedure TfrmTradutorSC.OnOpenAIError(Sender: TObject);
begin
	if (FChatGPT.StatusCode = 400) and (FChatGPT.RequestType = TOAIRequests.orImages) then
	begin
		mmOriginal.Lines.Add('Invalid prompt!');
		Exit;
	end;
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
	mmTraducao.Lines.Text := Lines;
end;

procedure TfrmTradutorSC.Aplicartema(const ATema: string);
begin
	try
		TStyleManager.TrySetStyle(ATema);
		Self.Refresh;
		TradutorConfig.Tema := ATema;
	except
		ShowMessage('Theme "' + ATema + '" not available')
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
	(Sender as TMenuItem).Checked := true;
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

procedure TfrmTradutorSC.cbMostrarVaziosClick(Sender: TObject);
begin
	if cbMostrarVazios.Checked then
	begin
		Filtro('value="" or value = null;', 'tag');
	end
	else
	begin
		Filtro('', '');
	end;
end;

procedure TfrmTradutorSC.cbNotTranslatedClick(Sender: TObject);
begin
	// This takes a lot of time, disabled until new improvements
	(*
	  if cbNotTranslated.Checked then
	  begin
	  Filtro('EXISTS (SELECT 1 FROM global_enus WHERE value = t.value) ', 'changed desc');
	  end
	  else
	  begin
	  Filtro('', '');
	  end;
	*)
end;

procedure TfrmTradutorSC.CompararTags1Click(Sender: TObject);
begin
	frmCompararTags.ShowModal;
end;

procedure TfrmTradutorSC.ConfigurarAI;
begin
	FChatGPT := TOpenAI.Create(TradutorConfig.OpenaiKey);
	FChatGPT.UseOllama := TradutorConfig.UseOllamaAI;

	if FChatGPT.UseOllama then
	begin
		FChatGPT.Endpoint := OLLAMA_ENDPOINT;
		FChatGPT.Chat.Model := TOAIModel.mdOllama;
		FChatGPT.OllamaModel := 'qwen2.5:14b';
	end
	else
	begin
		// This model, GPT 4o-mini, is perfect, fast and cheap
		FChatGPT.Endpoint := OAI_ENDPOINT;
		FChatGPT.Chat.Model := TOAIModel.mdGpt4omini;
	end;

	FChatGPT.OnResponse := OnOpenAIResponse;
	FChatGPT.OnError := OnOpenAIError;
end;

procedure TfrmTradutorSC.ConnectionBeforeConnect(Sender: TObject);
begin
	Connection.Params.database := FDatabaseLocation + DATABASE_NAME;
end;

procedure TfrmTradutorSC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	SalvarConfiguracao();
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

	if TradutorConfig.DontTranslate.IsEmpty then
		TradutorConfig.PromptTranslate := StringReplace(TradutorConfig.PromptTranslate, '%donttranslate%', '', [])
	else
		TradutorConfig.PromptTranslate := StringReplace(TradutorConfig.PromptTranslate, '%donttranslate%',
		  '- do not translate: ' + TradutorConfig.DontTranslate + #13, []);

	edDontranslate.Text := TradutorConfig.DontTranslate;

	AdicionarTemas(TradutorConfig.Tema);
	ConfigurarAI();
	pcTextStrings.ActivePage := tsTranslation;
	UtilizarOllamaAI.Checked := TradutorConfig.UseOllamaAI;
end;

procedure TfrmTradutorSC.Filtro(const AFiltro, AOrder: string);
var
	select: string;
begin
	if pcTextStrings.ActivePage = tsTranslation then
		select := SELECT_PTBR
	else
		select := SELECT_ENUS;

	if AOrder.IsEmpty then
		select := StringReplace(select, '%order%', '', [])
	else
		select := StringReplace(select, '%order%', 'ORDER BY ' + AOrder, []);

	if AFiltro.IsEmpty then
		select := StringReplace(select, '%where%', '', [])
	else
		select := StringReplace(select, '%where%', 'WHERE ' + AFiltro, []);

	qryTraducao.Open(select);
end;

procedure TfrmTradutorSC.AbrirTabelas;
begin
	try
		CreateTables(qryTraducao, ORIGINAL_LOCALE);
		CreateTables(qryTraducao, TRANSLATED_LOCALE);
		Filtro('', 'tag');
		dgTraducao.Columns.items[2].Width := (Self.Width div 2) - 300;
		dgOriginal.Columns.items[2].Width := (Self.Width div 2) - 300;
	except
		on e: Exception do
			ShowMessage('Error! Database cannot be opened. ' + e.Message)
	end;
end;

procedure TfrmTradutorSC.FormShow(Sender: TObject);
begin
	btnInterromper.Visible := false;
	AbrirTabelas();
	sbTraduzir.Enabled := (not TradutorConfig.OpenaiKey.IsEmpty) or (TradutorConfig.UseOllamaAI);
end;

function TfrmTradutorSC.UpdateTableRow(var AQuery: TFDQuery; const ATag, AValue: string;
const ANew: Boolean = false): Boolean;
begin
	AQuery.Close;
	AQuery.Params.ParamByName('Tag').AsString := ATag;
	AQuery.Params.ParamByName('Value').AsWideString := AValue;
	AQuery.Params.ParamByName('Changed').AsDateTime := Now();

	if ANew then
	begin
		AQuery.Params.ParamByName('Comment').AsString := 'original';
		AQuery.Params.ParamByName('New').AsInteger := 1
	end
	else
	begin
		AQuery.Params.ParamByName('Comment').AsString := '';
		AQuery.Params.ParamByName('New').AsInteger := 0;
	end;
	try
		AQuery.ExecSQL;
		Result := true;
	except
		Result := false;
	end;
end;

procedure TfrmTradutorSC.UtilizarOllamaAIClick(Sender: TObject);
begin
	TradutorConfig.UseOllamaAI := UtilizarOllamaAI.Checked;
	sbTraduzir.Enabled := (not TradutorConfig.OpenaiKey.IsEmpty) or (TradutorConfig.UseOllamaAI);
end;

procedure TfrmTradutorSC.SelecionarDiretorioSC;
const
	SELDIRHELP = 1000;
var
	Dir: string;
begin
	Dir := TradutorConfig.LocalizationFolder;
	if Dir.IsEmpty then
		Dir := TRANSLATED_LOCALIZATION_FOLDER + LOCALIZATION_PTBR;

	if GetFolderDialog(Self.Handle, 'Star Citizen instalation', Dir) then
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
			lQuery.SQL.Text := 'UPDATE GLOBAL_PTBR SET NEW=0,VALUE=:VALUE, CHANGED=datetime() WHERE VALUE=:OLD_VALUE;';
			lQuery.ParamByName('VALUE').AsWideString := AValor.Trim;
			lQuery.ParamByName('OLD_VALUE').AsWideString := AOldValor.Trim;
		end
		else
		begin
			lQuery.SQL.Text :=
			  'UPDATE GLOBAL_PTBR SET NEW=0,VALUE=:VALUE, COMMENT=:COMMENT, CHANGED=datetime() WHERE Id=:Id;';
			lQuery.ParamByName('Id').AsInteger := id;
			lQuery.ParamByName('VALUE').AsWideString := AValor.Trim;
			lQuery.ParamByName('COMMENT').AsWideString := 'translated';
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
	if MessageDlg('This operation will replace ALL EXACT tag values.'#13#13 + '"' + Copy(FTextUndo, 1, 15) +
	  '"... it will replace:' + #13 + '"' + Copy(traducao, 1, 15) + '"' + #13#13 +
	  'Make sure you have a copy of the database for backup purposes, '#13 +
	  'if necessary.'#13#13' Do you want to continue?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0)
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

procedure TfrmTradutorSC.mmTraducaoEnter(Sender: TObject);
begin
	dgTraducao.Enabled := false;
	dgTraducao.Color := clBtnFace;
end;

procedure TfrmTradutorSC.mmTraducaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if (ssCtrl in Shift) and (Key = 13) then
	begin
		Key := 0;
		AtualizarTraducao();
	end;
end;

procedure TfrmTradutorSC.pcTextStringsChange(Sender: TObject);
begin
	if not cbSincronizar.Checked then
		Exit;

	if pcTextStrings.ActivePage = tsTranslation then
		dgTraducao.DataSource.DataSet.Locate('tag', KeyTag, [loCaseInsensitive])
	else
		dgOriginal.DataSource.DataSet.Locate('tag', KeyTag, [loCaseInsensitive]);
end;

function TfrmTradutorSC.ConfirmDeploy(const AFolder: String): Boolean;
begin
	Result := MessageDlg
	  ('This operation will deploy the translated "global.ini" file directly into the localization folder.'#13#13 +
	  'Local: ' + AFolder + #13'Do you want to continue?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes],
	  0) = mrYes
end;

procedure TfrmTradutorSC.PastaversoLive1Click(Sender: TObject);
begin
	if TradutorConfig.LocalizationFolder.IsEmpty then
		SelecionarDiretorioSC();
	if TradutorConfig.LocalizationFolder.IsEmpty or (not DirectoryExists(TradutorConfig.LocalizationFolder)) then
	begin
		ShowMessage('Folder not found, confirm location');
		Exit;
	end;

	if ConfirmDeploy(TradutorConfig.LocalizationFolder) then
	begin
		try
			ExportarGlobal(TradutorConfig.LocalizationFolder + '\' + GLOBAL_INI, TRANSLATED_LOCALE);
		except
			ShowMessage('Error trying to deploy Localization file.');
		end;
	end;
end;

function TfrmTradutorSC.NewTag(var AQuery: TFDQuery; ATag, ALocale: string;
const aCheckForChanged: Boolean = true): Integer;
var
	qryCmp: TFDQuery;
begin
	Result := TAG_SAME;

	AQuery.Close;
	AQuery.ParamByName('TAG').AsString := ATag;
	AQuery.Open;

	// tag already exists
	if not AQuery.IsEmpty then
	begin
		if not aCheckForChanged then
			Exit;
		// so let's check if the tag was changed
		qryCmp := TFDQuery.Create(Self);
		try
			qryCmp.Connection := AQuery.Connection;
			qryCmp.SQL.Text := 'SELECT Value FROM global_' + ALocale + ' WHERE Value = :value;';
			qryCmp.ParamByName('value').AsWideString := AQuery.FieldByName('value').AsWideString;
			qryCmp.Open;
			// something has changed...
			if qryCmp.IsEmpty then
				Result := TAG_CHANGED;
		finally
			qryCmp.Free;
		end;
	end
	else
		Result := TAG_NEW;

end;

procedure ErroLinhaNaoInserida(ATag: string);
begin
	tthread.Synchronize(tthread.CurrentThread,
		procedure
		begin
			ShowMessage('Error inserting Tag. Does it already exist?' + #13#13 + ATag);
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
			SQLInsert, SQLUpdate, DB: string;
			new: Integer;

			procedure ProcessNewTags(const ALocale: String);
			begin
				new := NewTag(sQuery, ATag, ALocale);
				if new = TAG_NEW then
				begin
					AQuery.SQL.Text := SQLInsert;
					if UpdateTableRow(AQuery, ATag, AValue, true) then
						inc(j)
					else
						ErroLinhaNaoInserida(ATag);
				end;
				if new = TAG_CHANGED then
				begin
					AQuery.SQL.Text := SQLUpdate;
					if not UpdateTableRow(AQuery, ATag, AValue, true) then
						ErroLinhaNaoInserida(ATag);
				end;
			end;

			procedure ProcessTags(const ALocale: string);
			begin
				new := NewTag(sQuery, ATag, ALocale);
				if ALocale = ORIGINAL_LOCALE then
				begin
					AQuery.SQL.Text := SQLInsert;
					if not UpdateTableRow(AQuery, ATag, AValue, new = TAG_NEW) then
						ErroLinhaNaoInserida(ATag);
				end;

				if ALocale = TRANSLATED_LOCALE then
				begin
					AQuery.SQL.Text := SQLInsert;
					if new = TAG_NEW then
						if not UpdateTableRow(AQuery, ATag, AValue, false) then
							ErroLinhaNaoInserida(ATag);
				end;

				inc(j);
			end;

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

					// SQLUpdate used only with translations
					// if we detect changes in the original English
					SQLUpdate := 'UPDATE ' + TRANSLATED_LOCALE +
					  ' SET Value = :value, Comment = :Comment, New = :new, Changed = :Changed where Tag=:tag;';

					//
					SQLInsert := 'INSERT INTO global_' + ALocale +
					  ' (Tag, Value, Comment, Changed, New) VALUES (:Tag, :Value, :Comment, :Changed, :New)';
					AQuery.Connection := aConnection;

					sQuery.Connection := aConnection;
					if ALocale = ORIGINAL_LOCALE then
						sQuery.SQL.Text := 'SELECT tag,value FROM global_' + ORIGINAL_LOCALE + ' WHERE Tag = :TAG;'
					else
						sQuery.SQL.Text := 'SELECT tag,value FROM global_' + TRANSLATED_LOCALE + ' WHERE Tag = :TAG;';
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
							ProcessNewTags(ALocale)
						end
						else
						begin
							ProcessTags(ALocale)
						end;

						inc(i);
						if (i mod 100 = 0) then
							tthread.Synchronize(tthread.CurrentThread,
								procedure
								begin
									Label1.Caption := 'Imported lines: ' + j.ToString;
								end);
					end;
				except
					on e: Exception do
						tthread.Synchronize(nil,
							procedure
							begin
								SkAnimatedImage1.Animation.Enabled := false;
								Label1.Caption := 'Error trying to import file. Imported lines: ' + i.ToString;
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
						ImportarGlobalini1.Enabled := true;
						ImportarGlobaliniparabaseIngls1.Enabled := true;
						SkAnimatedImage1.Animation.Enabled := false;
						Label1.Caption := 'Imported lines: ' + j.ToString;
						if not ATagsOnly then
							ImportacaoConcluida()
						else
							Filtro('', 'changed');
						SetPaineis(true);
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
			SetPaineis(true);
			ShowMessage('Error trying to import. Data reverted.' + #13 + ErrorMessage);
			Filtro('', 'changed');
		end);

end;

procedure TfrmTradutorSC.Escolherlugar1Click(Sender: TObject);
begin
	if LastDir.IsEmpty then
		LastDir := TRANSLATED_LOCALIZATION_FOLDER;

	if GetFolderDialog(Self.Handle, 'Salvar em', LastDir) then
	begin
		if not DirectoryExists(LastDir) then
		begin
			ShowMessage('Folder not found, confirm location');
			Exit;
		end;

		if ConfirmDeploy(LastDir) then
		begin
			try
				ExportarGlobal(LastDir + '\' + GLOBAL_INI, TRANSLATED_LOCALE);
				TradutorConfig.LastUsedFolder := LastDir;
				SalvarConfiguracao();
			except
				ShowMessage('Error trying to deploy Localization file.');
			end;
		end;
	end;
end;

procedure TfrmTradutorSC.SetPaineis(AEnabled: Boolean);
begin
	Panel1.Enabled := AEnabled;
	Panel2.Enabled := AEnabled;
	Panel4.Enabled := AEnabled;
	btnInterromper.Visible := not AEnabled;
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
			SetPaineis(true);
			ShowMessage('Import completed successfully.');
			Filtro('', 'changed');
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

	if FChatGPT.Chat.Model = TOAIModel.mdGpto3mini then
	begin
		FChatGPT.Engine := TOAIEngine.egGpto3mini;
		FChatGPT.Chat.AddMessage('You are a helpful translator', TMessageRole.mrDeveloper);
	end;

	FChatGPT.Chat.AddMessage(prompt, TMessageRole.mrUser);

	FChatGPT.RequestType := orChat;
	FChatGPT.Chat.MaxTokens := 4096;
	FChatGPT.Chat.TopP := 1;
	FChatGPT.Chat.PresencePenalty := 1;
	FChatGPT.Chat.Temperature := 0.1;
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

	SkAnimatedImage1.Animation.Enabled := true;
	Label1.Caption := 'Translating, please wait...';

	tthread.CreateAnonymousThread(
		procedure
		var
			doExecute: Boolean;
		begin

			try
				doExecute := true;
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
	Filtro('', 'tag');
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
	if MessageDlg('Importing only new tags may take considerable time,'#13 +
	  'because each of them must be checked in the database.'#13#13' Do you want to continue?', TMsgDlgType.mtWarning,
	  [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrYes then
	begin
		if OpenDialog1.Execute() then
		begin
			if (Sender as TMenuItem).Tag = 1 then
				locale := ORIGINAL_LOCALE
			else
				locale := TRANSLATED_LOCALE;
			ProcessarGlobalIni(OpenDialog1.Filename, locale, true);
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
			locale := TRANSLATED_LOCALE;

		btnInterromper.Visible := true;
		Label1.Caption := 'Copying database';
		SkAnimatedImage1.Animation.Enabled := true;

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
	if MessageDlg('Attention, importing means restarting the database with this new data.'#13 +
	  'The current database will be saved with the .back extension.'#13#13'Do you want to continue?',
	  TMsgDlgType.mtWarning, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrYes then
	begin
		if OpenDialog1.Execute() then
			ImportarGlobal(OpenDialog1.Filename, (Sender as TMenuItem).Tag = 1);
	end;

end;

end.
