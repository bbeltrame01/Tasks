unit Tasks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.NumberBox, System.Threading, System.SyncObjs, System.IOUtils;

type
  TDados = record
    FileName:    String;
    TempoExec:   String;
    QtdPalavras: Integer;
  end;

  TTFrTasks = class(TForm)
    pgbSequencial: TProgressBar;
    memSequencial: TMemo;
    pgbParalelo: TProgressBar;
    memParalelo: TMemo;
    btnIniciar: TButton;
    Shape1: TShape;
    btnFechar: TButton;
    btnLimpar: TButton;
    btnSelecFile: TButton;
    edtFilePath: TEdit;
    dlgFile: TOpenDialog;
    labSequencial: TLabel;
    labParalelo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIniciarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnSelecFileClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    FTaskFor: ITask;
    FTaskParallel: ITask;
    FContent:  String;
    procedure HabilitarCampos(AHabilitar: Boolean=true);
    procedure LimparCampos();
    procedure ProcessarArquivo;
    function ValidarCampos: Boolean;
    function CountWordsUsingFor(const Content: string): TDados;
    function CountWordsUsingParallel(const Content: string): TDados;
  public
    { Public declarations }
  end;

var
  TFrTasks: TTFrTasks;

implementation

{$R *.dfm}

procedure TTFrTasks.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TTFrTasks.btnIniciarClick(Sender: TObject);
begin
  if ValidarCampos then
    ProcessarArquivo;
end;

procedure TTFrTasks.btnLimparClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TTFrTasks.btnSelecFileClick(Sender: TObject);
begin
  if dlgFile.Execute then
    begin
      edtFilePath.Text := dlgFile.FileName;
      FContent := TFile.ReadAllText(dlgFile.FileName);
    end;
end;

function TTFrTasks.CountWordsUsingFor(const Content: string): TDados;
var
  LWords: TArray<string>;
  LWord: string;
  LCount: Integer;
  LInicio: TDateTime;
begin
  LInicio := Now;
  LWords := Content.Split([' ', #13, #10], TStringSplitOptions.ExcludeEmpty);

  pgbSequencial.Position := 0;
  pgbSequencial.Max := Length(LWords);
  LCount := 0;
  for LWord in LWords do
    begin
      if TTask.CurrentTask.Status = TTaskStatus.Canceled then
        Exit;
      if (LWord <> '') then
        Inc(LCount);
      pgbSequencial.StepIt;
    end;
  Result.FileName    := dlgFile.FileName;
  Result.QtdPalavras := LCount;
  Result.TempoExec   := FormatDateTime('ss.zzz', Now - LInicio);
end;

function TTFrTasks.CountWordsUsingParallel(const Content: string): TDados;
var
  LWords: TArray<string>;
  LCount: Integer;
  LInicio: TDateTime;
begin
  LInicio := Now;
  LWords := Content.Split([' ', #13, #10], TStringSplitOptions.ExcludeEmpty);

  pgbParalelo.Position := 0;
  pgbParalelo.Max := Length(LWords);
  LCount := 0;
  TParallel.For(0, Length(LWords) - 1,
    procedure(Index: Integer)
    begin
      if TTask.CurrentTask.Status = TTaskStatus.Canceled then
        Exit;
      if (LWords[Index] <> '') then
        TInterlocked.Increment(LCount);
      pgbParalelo.StepIt;
    end
  );
  Result.FileName    := dlgFile.FileName;
  Result.QtdPalavras := LCount;
  Result.TempoExec   := FormatDateTime('ss.zzz', Now - LInicio);
end;

procedure TTFrTasks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FTaskFor) then
    FTaskFor.Cancel;
  if Assigned(FTaskParallel) then
    FTaskParallel.Cancel;
  Action := caFree;
end;


procedure TTFrTasks.HabilitarCampos(AHabilitar: Boolean);
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
    begin
      if Self.Components[I] is TEdit then
        TEdit(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TComboBox then
        TComboBox(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TCheckBox then
        TCheckBox(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TRadioButton then
        TRadioButton(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TMemo then
        TMemo(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TRichEdit then
        TRichEdit(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TListBox then
        TListBox(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TDateTimePicker then
        TDateTimePicker(Self.Components[I]).Enabled := AHabilitar
      else if Self.Components[I] is TButton then
        TButton(Self.Components[I]).Enabled := AHabilitar;
    end;
end;

procedure TTFrTasks.LimparCampos();
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
    begin
      if Self.Components[I] is TEdit then
        TEdit(Self.Components[I]).Clear
      else if Self.Components[I] is TComboBox then
        TComboBox(Self.Components[I]).ItemIndex := -1
      else if Self.Components[I] is TCheckBox then
        TCheckBox(Self.Components[I]).Checked := False
      else if Self.Components[I] is TRadioButton then
        TRadioButton(Self.Components[I]).Checked := False
      else if Self.Components[I] is TMemo then
        TMemo(Self.Components[I]).Clear
      else if Self.Components[I] is TRichEdit then
        TRichEdit(Self.Components[I]).Clear
      else if Self.Components[I] is TListBox then
        TListBox(Self.Components[I]).ItemIndex := -1
      else if Self.Components[I] is TDateTimePicker then
        TDateTimePicker(Self.Components[I]).Date := Now;
    end;
end;

procedure TTFrTasks.ProcessarArquivo;
var
  LForData, LParallelData: TDados;
begin
  //Desabilitar Componentes
  HabilitarCampos(False);

  FTaskFor := TTask.Run(
    procedure
    begin
      LForData := CountWordsUsingFor(FContent);
    end
  );

  FTaskParallel := TTask.Run(
    procedure
    begin
      LParallelData := CountWordsUsingParallel(FContent);
    end
  );

  TTask.Run(
    procedure
    begin
      FTaskFor.Wait;

      TThread.Queue(nil,
        procedure
        begin
          if (FTaskFor.Status <> TTaskStatus.Canceled) then
            begin
              memSequencial.Lines.Add(Format('Arquivo: %s', [LForData.FileName]));
              memSequencial.Lines.Add(Format('Tempo de Execução: %s(s)', [LForData.TempoExec]));
              memSequencial.Lines.Add(Format('Quantidade de Palavras: %d', [LForData.QtdPalavras]));
            end;
        end
      );
    end
  );

  TTask.Run(
    procedure
    begin
      FTaskParallel.Wait;

      TThread.Queue(nil,
        procedure
        begin
          if (FTaskParallel
          .Status <> TTaskStatus.Canceled) then
            begin
              memParalelo.Lines.Add(Format('Arquivo: %s', [LParallelData.FileName]));
              memParalelo.Lines.Add(Format('Tempo de Execução: %s(s)', [LParallelData.TempoExec]));
              memParalelo.Lines.Add(Format('Quantidade de Palavras: %d', [LParallelData.QtdPalavras]));
            end;
        end
      );
    end
  );

  TTask.Run(
    procedure
    begin
      TTask.WaitForAll([FTaskFor, FTaskParallel]);

      TThread.Queue(nil,
        procedure
        begin
          HabilitarCampos;
        end
      );
    end
  );
end;

function TTFrTasks.ValidarCampos: Boolean;
begin
  Result := True;
  if edtFilePath.Text = '' then
  begin
    ShowMessage('Nenhum arquivo selecionado.');
    Exit(False);
  end;
end;

end.
