program Project51;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit5 in 'Unit5.pas' {Form5},
  FMX.Windows.Dispatch in '..\FMX.Windows.Dispatch.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
