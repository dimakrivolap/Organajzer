unit UnitAddAlarm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ComCtrls, UnitMain;

type
  TFormAlarm = class(TForm)
    dtpAlarm: TDateTimePicker;
    medtAlarm: TMaskEdit;
    btnOK: TButton;
    btncancel: TButton;
    edt1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure btncancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAlarm: TFormAlarm;

implementation

{$R *.dfm}

procedure TFormAlarm.btncancelClick(Sender: TObject);
begin
    FormAlarm.close;
end;

procedure TFormAlarm.btnOKClick(Sender: TObject);
var f: file of Alarms;
begin
    if medtAlarm.Text<>'  :  ' then  //проверка на ввод
    begin
      lbl2.caption:=DateToStr(dtpAlarm.Date);
      //запись в массив
      FormMain.al[FormMain.count_alarms].date:=StrToDate(lbl2.Caption);
      FormMain.al[FormMain.count_alarms].Time:=StrToTime(medtAlarm.Text);
      FormMain.al[FormMain.count_alarms].Comments:=edt1.Text;
      AssignFile(f,formmain.dir+formmain.h.name+'alarms');
      Reset(f);
      write(f,formmain.al[formmain.count_alarms]);
      Inc(formmain.count_alarms);
      CloseFile(f);
    end;
    FormAlarm.Close;
end;

procedure TFormAlarm.FormCreate(Sender: TObject);
begin
  //по умолчанию дата=сегодня
  dtpAlarm.Date:=Now;
end;

end.
