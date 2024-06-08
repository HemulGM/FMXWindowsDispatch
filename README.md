# FMXWindowsDispatch

Add to form message event
```pascal
type
  TForm5 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  end;

...

procedure TForm5.WMSize(var Message: TWMSize);
begin
  Label1.Text := Message.Width.ToString + ':' + Message.Height.ToString;
end;
```

Add unit to uses

```pascal
uses
  FMX.Windows.Dispatch;
```

And call AllowDispatchWindowMessages procedure

```pascal
procedure TForm5.FormCreate(Sender: TObject);
begin
  AllowDispatchWindowMessages(Self);
end;
```
