unit FMX.Windows.Dispatch;

interface

uses
  FMX.Forms, System.SysUtils;

procedure AllowDispatchWindowMessages(Form: TCustomForm);

var
  DwmWinProcProirity: Boolean = False;
  ProcCallback: TProc<Cardinal, NativeUInt, NativeInt>;

implementation

{$IFDEF MSWINDOWS}

uses
  Winapi.Windows, Winapi.Messages, Winapi.Dwmapi, FMX.Platform.Win;
{$ENDIF}

{$IFDEF MSWINDOWS}

function NewWndProc(Wnd: HWND; Msg: UINT; WParam: WParam; LParam: LParam): LRESULT; stdcall;
begin
  if DwmWinProcProirity and DwmDefWindowProc(Wnd, Msg, WParam, LParam, Result) then
    Exit;
  if Assigned(ProcCallback) then
    ProcCallback(Msg, WParam, LParam);
  var LForm := FindWindow(Wnd);
  if Assigned(LForm) then
  begin
    var Message: TMessage;
    Message.Msg := Msg;
    Message.WParam := WParam;
    Message.lParam := LParam;
    Message.Result := 0;
    LForm.Dispatch(Message);
    Result := Message.Result;
    if Result <> 0 then
      Exit;
  end;
  Result := CallWindowProc(Pointer(GetWindowLongPtr(Wnd, GWL_USERDATA)), Wnd, Msg, WParam, LParam);
end;
{$ENDIF}

procedure AllowDispatchWindowMessages(Form: TCustomForm);
begin
  {$IFDEF MSWINDOWS}
  var OldWndProc := Pointer(GetWindowLongPtr(FormToHWND(Form), GWL_WNDPROC));
  SetWindowLongPtr(FormToHWND(Form), GWL_USERDATA, NativeInt(OldWndProc));
  SetWindowLongPtr(FormToHWND(Form), GWL_WNDPROC, NativeInt(@NewWndProc));
  {$ENDIF}
end;

end.

