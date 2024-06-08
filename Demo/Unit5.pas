unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, Winapi.Messages;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  end;

var
  Form5: TForm5;

implementation

uses
  FMX.Windows.Dispatch;

{$R *.fmx}

procedure TForm5.FormCreate(Sender: TObject);
begin
  AllowDispatchWindowMessages(Self);
end;

procedure TForm5.WMSize(var Message: TWMSize);
begin
  Label1.Text := Message.Width.ToString + ':' + Message.Height.ToString;
end;

end.

