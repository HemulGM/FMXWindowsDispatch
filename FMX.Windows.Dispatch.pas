unit FMX.Windows.Dispatch;

interface

uses
  FMX.Forms;

procedure AllowDispatchWindowMessages(Form: TCustomForm);

implementation

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, FMX.Platform.Win;

function NewWndProc(Wnd: HWND; Msg: UINT; WParam: WParam; LParam: LParam): LRESULT; stdcall;
begin
  var LForm := FindWindow(Wnd);
  if Assigned(LForm) then
  begin
    var Mess: TMessage;
    Mess.Msg := Msg;
    Mess.WParam := WParam;
    Mess.lParam := LParam;
    Mess.Result := 0;
    LForm.Dispatch(Mess);
    Result := Mess.Result;
    if Result <> 0 then
      Exit;
  end;
  Result := CallWindowProc(Pointer(GetWindowLong(ApplicationHWND, GWL_WNDPROC)), Wnd, Msg, WParam, LParam);
end;

procedure AllowDispatchWindowMessages(Form: TCustomForm);
begin
  SetWindowLong(FormToHWND(Form), GWL_WNDPROC, Integer(@NewWndProc));
end;

end.

