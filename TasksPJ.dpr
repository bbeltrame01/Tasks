program TasksPJ;

uses
  Vcl.Forms,
  Tasks in 'Tasks.pas' {TFrTasks};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTFrTasks, TFrTasks);
  Application.Run;
end.
