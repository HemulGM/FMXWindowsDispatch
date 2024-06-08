unit FMX.Windows.Dispatch;

interface

uses
  FMX.Forms;

procedure AllowDispatchWindowMessages(Form: TCustomForm);

implementation

uses
  Winapi.Windows, Winapi.Messages, FMX.Platform.Win;

function NewWndProc(Wnd: HWND; Msg: UINT; WParam: WParam; LParam: LParam): LRESULT; stdcall;
begin
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

procedure AllowDispatchWindowMessages(Form: TCustomForm);
begin
  var OldWndProc := Pointer(GetWindowLongPtr(FormToHWND(Form), GWL_WNDPROC));
  SetWindowLongPtr(FormToHWND(Form), GWL_USERDATA, NativeInt(OldWndProc));
  SetWindowLongPtr(FormToHWND(Form), GWL_WNDPROC, NativeInt(@NewWndProc));
end;

end.

