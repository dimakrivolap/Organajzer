program ProjectOrganajzer;

uses
  Forms,
  UnitVhod in 'UnitVhod.pas' {FormVhod},
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitAddEvent in 'UnitAddEvent.pas' {FormAddEvent},
  UnitAddAlarm in 'UnitAddAlarm.pas' {FormAlarm},
  UnitReg in 'UnitReg.pas' {FormReg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormVhod, FormVhod);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAddEvent, FormAddEvent);
  Application.CreateForm(TFormAlarm, FormAlarm);
  Application.CreateForm(TFormReg, FormReg);
  Application.Run;
end.
